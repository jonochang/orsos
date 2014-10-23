require 'date'
require_relative '../webdownloader'

module Orsos::Commands
  class Get < Thor
    desc "transactions FROM [TO]", "Download campaign finance transactions daily between FROM till TO and saves each day to sos_transactions_{%Y%m%d}-{current time stamp}. eg., orsos get transactions 2014-10-01 2014-10-31. TO defaults to today's date"
    option :verbose, type: :boolean
    option :filer_id, type: :numeric
    option :single_file, type: :boolean
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
        filename = "sos_transactions_#{from_date.strftime("%Y%m%d")}-#{to_date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}.xls"
        Orsos::Webdownloader.new(options[:verbose])
                            .save_campaign_finance_transactions_to_xls from_date: from_date, 
                                                                       to_date: to_date, 
                                                                       filename: filename, 
                                                                       options: trans_opts

      else
        (from_date..to_date).each do |date|
          filename = "sos_transactions_#{date.strftime("%Y%m%d")}-#{DateTime.now.strftime("%Y%m%d%H%M%S")}.xls"

          Orsos::Webdownloader.new(options[:verbose])
                              .save_campaign_finance_transactions_to_xls from_date: date, 
                                                                         to_date: date, 
                                                                         filename: filename, 
                                                                         options: trans_opts
        end
      end
    end

    ### FIX for help issue (see commit) ###
    package_name "get"

    def self.banner(command, namespace = nil, subcommand = false)
      "#{basename} #{@package_name} #{command.usage}"
    end
    ### END FIX ###
  end
end
