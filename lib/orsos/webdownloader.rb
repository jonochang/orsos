require 'mechanize'
require 'logger'
require 'mkmf'

class Orsos::Webdownloader
  def initialize(verbose=false)
    @verbose = verbose
  end

  def save_campaign_finance_transactions from_date:, to_date:, filename: , csvbin:, stdout:, options: {}
    puts "downloading transactions for #{from_date.strftime('%Y-%m-%d')} till #{to_date.strftime('%Y-%m-%d')}" if !stdout

    export_page = download_campaign_finance_transactions from_date: from_date, to_date: to_date, filer_id: options['filer_id']
    raise "could not download campaign finance transactions" if export_page.nil?

    data = if !csvbin.nil?
      csvpath = find_executable csvbin
      raise "could not find #{csvbin} in $PATH" if csvpath.nil?
      file = Tempfile.new(['xls2csv-', '.xls'])
      file.binmode
      begin
        file.write(export_page.body)
        file.rewind

        `#{csvpath} #{file.path}`
      ensure
        file.close
        file.unlink
      end
    else
      export_page.body
    end

    if stdout
      $stdout.write data
    else
      File.open(filename, 'wb') {|f| f.write(data) }
      puts "saved transactions for #{from_date.strftime("%Y-%m-%d")} till #{to_date.strftime('%Y-%m-%d')} to #{filename}"
    end
  end

private
  def download_campaign_finance_transactions from_date:, to_date:, filer_id: nil
    set_agent
    export_page = nil

    @agent.get("#{@base_url}/orestar/gotoPublicTransactionSearch.do") do |search_page|
      search_page.form_with(name: 'cneSearchForm') do |form|
        form.cneSearchTranFiledStartDate = from_date.strftime("%m/%d/%Y")
        form.cneSearchTranFiledEndDate = to_date.strftime("%m/%d/%Y")
        form.cneSearchFilerCommitteeId = filer_id unless filer_id.nil?

        @results_page = @agent.submit(form, form.button_with(value: "Search"))
        if link = @results_page.link_with(text: "Export To Excel Format")
          export_page  = @agent.click(link)
        end
      end
    end

    return export_page
  end

  def set_source_xls_file_and_downloaded_at body, filename
    file = StringIO.new(body)
  end

  def parse_date source
    return nil if source.to_s.strip.empty?
    Date.strptime(source, '%m/%d/%Y')
  end

  def uri_path attachment
    return nil unless attachment.exists?
    case attachment.options[:storage]
    when :filesystem
      attachment.path
    when :s3
      attachment.url(:original, timestamp: false)
    else
      raise 'unsupported paperclip storage'
    end
  end

  def set_agent
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'#'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36' # Wikipedia blocks "mechanize"
    @agent.log = Logger.new(STDOUT) if @verbose

    @history = @agent.history
    @base_url = URI 'https://secure.sos.state.or.us'
  end
end
