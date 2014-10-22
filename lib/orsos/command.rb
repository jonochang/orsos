require 'thor'
require_relative './commands/get'
class Orsos::Command < Thor
  register Orsos::Commands::Get, 'get', 'get [COMMAND]', 'downloads excel files from website'
  #register Orsos::ConvertCommand, 'convert', 'convert [COMMAND]', 'downloads and converts xls to csv'
end
