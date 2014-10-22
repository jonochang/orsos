module Orsos::Commands
  class Get < Thor
    option :from, type: :date, require: true
    option :to, type: :date
    desc "transactions", "Download campaign finance transactions"
    def transactions(from, to=Date.today)
      from_date = case from
        when Date
          from
        when String
          Date.parse from
        else
          raise 'invalid from date'
      end

      to_date = case to
        when Date
          from
        when String
          Date.parse to
        else
          raise 'invalid to date'
      end

      set_agent

      @agent.get("#{@base_url}/orestar/gotoPublicTransactionSearch.do") do |search_page|
        search_page.form_with(name: 'cneSearchForm') do |form|
          form.cneSearchTranFiledStartDate = from_date.strftime("%m/%d/%Y")
          form.cneSearchTranFiledEndDate = to_date.strftime("%m/%d/%Y")

          @results_page = @agent.submit(form, form.button_with(value: "Search"))
          if link = @results_page.link_with(text: "Export To Excel Format")
            @export_page  = @agent.click(link)
            File.open("sos_transactions_#{from_date.strftime("%Y%m%d")}-#{to_date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}.xls") {|f|
              f.write(@export_page.body)
            }
          end
        end
      end
    end

  private
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
      @agent.log = Logger.new(STDOUT)

      @history = @agent.history
      @base_url = URI 'https://secure.sos.state.or.us'
    end
  end
end
