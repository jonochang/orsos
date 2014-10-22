require 'rest_client'
require 'json'
module Orsos::Commands
  class Api < Thor
    ROOT_URL = "http://hack-oregon-prototype.herokuapp.com"

    desc "api candidates", "gets json or text for #{ROOT_URL}/api/candidates.json"
    option :text, type: :boolean
    def candidates
      url = "#{ROOT_URL}/api/candidates.json"
      response = RestClient.get(url)
      if options[:text]
        puts "Candidates"
        puts "----------"
        puts JSON.parse(response.body)
      else
        puts JSON.pretty_generate(JSON.parse(response.body))
      end
    end
  end
end

