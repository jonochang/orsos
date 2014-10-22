require 'thor'
require_relative './commands/get'
require_relative './commands/api'
class Orsos::Command < Thor
  register Orsos::Commands::Get, 'get', 'get [COMMAND]', 'downloads excel files from website'
  register Orsos::Commands::Api, 'api', 'api [COMMAND]', "client for api located at #{Orsos::Commands::Api::ROOT_URL}"
end
