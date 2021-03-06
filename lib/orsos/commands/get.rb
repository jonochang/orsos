require 'date'
require_relative '../webdownloader'

module Orsos::Commands
  class Get < Thor
    class_option :in2csv, type: :boolean, desc: 'use in2csv to convert downloaded xls to csv'
    class_option :xls2csv, type: :boolean, desc: 'use xls2csv to convert downloaded xls to csv'
    class_option :stdout, type: :boolean, desc: 'output to stdout'
    class_option :verbose, type: :boolean, desc: 'turn on verbose logging of search'

    desc "transactions FROM [TO]", "Download campaign finance transactions daily between FROM till TO and saves each day to sos_transactions_{%Y%m%d}-{current time stamp}. eg., orsos get transactions 2014-10-01 2014-10-31. TO defaults to today's date"
    option :filer_id, type: :numeric, desc: 'conduct search by filer_id'
    option :single_file, type: :boolean, desc: 'search and save data in date range as a single file rather than one search per day'
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
          to
        when String
          Date.parse to
        else
          raise 'invalid to date'
      end

      trans_opts = options.select{|k,v| ['filer_id'].include?(k) }

      if !options['single_file'].nil?
        Orsos::Webdownloader.new(get_downloader_options(filename: "sos_transactions_#{from_date.strftime("%Y%m%d")}-#{to_date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}", options: options))
                            .save_campaign_finance_transactions from_date: from_date, 
                                                                to_date: to_date, 
                                                                options: trans_opts

      else
        (from_date..to_date).each do |date|
          Orsos::Webdownloader.new(get_downloader_options(filename: "sos_transactions_#{date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}", options: options))
                              .save_campaign_finance_transactions from_date: date, 
                                                                  to_date: date, 
                                                                  options: trans_opts
        end
      end
    end

    desc "committees", "Download committees information sos_committees_{search query}. eg., orsos get committees kitzhaber."
    option :committee_name_contains, type: :string, desc: 'search by name of committee which contains.... eg., --committee_name=kitzhaber searches for records that contain kitzhaber in the name.'
    def committees
      Orsos::Webdownloader.new(get_downloader_options(filename: "sos_committees_#{options['committee_name_contains']}", options: options))
                          .save_committees committee_name_contains: options['committee_name_contains']
    end

    desc "candidate_filings FROM [TO]", "Download candidate_filings between FROM till TO into sos_candidate_filings_{from %Y%m%d}-{to %Y%m%d}-{current time stamp}. eg., orsos get candidate_filings 2014-10-01 2014-10-31. TO defaults to today's date"
    def candidate_filings(from, to=Date.today)
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
          to
        when String
          Date.parse to
        else
          raise 'invalid to date'
      end

      Orsos::Webdownloader.new(get_downloader_options(filename: "sos_candidate_filings_#{from_date.strftime("%Y%m%d")}-#{to_date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}", options: options))
                          .save_candidate_filings from_date: from_date, to_date: to_date
    end

    ### FIX for help issue (see commit) ###
    package_name "get"

    def self.banner(command, namespace = nil, subcommand = false)
      "#{basename} #{@package_name} #{command.usage}"
    end

    ### END FIX ###
    private

    def get_downloader_options filename: , options: {}
      if options['in2csv']
        csvbin = 'in2csv'
        fileext = 'csv'
      elsif options['xls2csv']
        csvbin = 'xls2csv'
        fileext = 'csv'
      else
        csvbin = nil
        fileext = 'xls'
      end
      
      {
        verbose: options[:verbose],
        csvbin: csvbin,
        stdout: options['stdout'],
        filename: "#{filename}.#{fileext}"
      }
    end
  end
end
