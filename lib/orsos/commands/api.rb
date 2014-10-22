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
        json = JSON.parse(response.body)
        puts "Candidates"
        puts "----------"
        puts "id\tballot name\tparty\temail"
        puts "-------------------------"
        json["candidates"].each do |candidate|
          puts "#{candidate["id"]}\t#{candidate["ballot_name"]}\t#{candidate["party_affiliation"]}\t#{candidate["email"]}"
        end
      else
        puts JSON.pretty_generate(JSON.parse(response.body))
      end
    end

  end
end

