require 'date'
require_relative '../webdownloader'

module Orsos::Commands
  class Get < Thor
    desc "get daily transactions FROM [TO]", "Download campaign finance transactions FROM till TO and saves to sos_transactions_{%Y%m%d}-{current time stamp}. eg., orsos get transactions 2014-10-01 2014-10-31. TO defaults to today's date"
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
      
      (from_date..to_date).each do |date|
        Orsos::Webdownloader.new.download_campaign_finance_transactions date
      end
    end
  end
end
