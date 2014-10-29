require 'date'
require_relative '../webdownloader'

module Orsos::Commands
  class Get < Thor
    desc "transactions FROM [TO]", "Download campaign finance transactions daily between FROM till TO and saves each day to sos_transactions_{%Y%m%d}-{current time stamp}. eg., orsos get transactions 2014-10-01 2014-10-31. TO defaults to today's date"
    option :verbose, type: :boolean, desc: 'turn on verbose logging of search'
    option :filer_id, type: :numeric, desc: 'conduct search by filer_id'
    option :single_file, type: :boolean, desc: 'search and save data in date range as a single file rather than one search per day'
    option :in2csv, type: :boolean, desc: 'use in2csv to convert downloaded xls to csv'
    option :xls2csv, type: :boolean, desc: 'use xls2csv to convert downloaded xls to csv'
    option :stdout, type: :boolean, desc: 'output to stdout'
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

      if !options['single_file'].nil?
        filename = "sos_transactions_#{from_date.strftime("%Y%m%d")}-#{to_date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}.#{fileext}"
        Orsos::Webdownloader.new(verbose: options[:verbose],
                                 csvbin: csvbin,
                                 stdout: options['stdout'])
                            .save_campaign_finance_transactions from_date: from_date, 
                                                                to_date: to_date, 
                                                                filename: filename, 
                                                                options: trans_opts

      else
        (from_date..to_date).each do |date|
          filename = "sos_transactions_#{date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}.#{fileext}"

          Orsos::Webdownloader.new(verbose: options[:verbose],
                                   csvbin: csvbin,
                                   stdout: options['stdout'])
                              .save_campaign_finance_transactions from_date: date, 
                                                                  to_date: date, 
                                                                  filename: filename, 
                                                                  options: trans_opts
        end
      end
    end

    desc "committees", "Download committees information sos_committees_{search query}. eg., orsos get committees kitzhaber."
    option :committee_name_contains, type: :string, desc: 'search by name of committee which contains.... eg., --committee_name=kitzhaber searches for records that contain kitzhaber in the name.'
    option :in2csv, type: :boolean, desc: 'use in2csv to convert downloaded xls to csv'
    option :xls2csv, type: :boolean, desc: 'use xls2csv to convert downloaded xls to csv'
    option :stdout, type: :boolean, desc: 'output to stdout'

    def committees
      if options['in2csv']
        @csvbin = 'in2csv'
        @fileext = 'csv'
      elsif options['xls2csv']
        @csvbin = 'xls2csv'
        @fileext = 'csv'
      else
        @csvbin = nil
        @fileext = 'xls'
      end

      filename = "sos_committees_#{options['committee_name_contains']}.#{@fileext}"
      Orsos::Webdownloader.new(verbose: options[:verbose],
                               csvbin: @csvbin,
                               stdout: options['stdout'])
                          .save_committees committee_name_contains: options['committee_name_contains'], 
                                                              filename: filename

    end

    ### FIX for help issue (see commit) ###
    package_name "get"

    def self.banner(command, namespace = nil, subcommand = false)
      "#{basename} #{@package_name} #{command.usage}"
    end
    ### END FIX ###
  end
end
