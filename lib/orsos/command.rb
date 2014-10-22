require 'thor'
require_relative './commands/get_command'
class Orsos::Command < Thor
  register Orsos::GetCommand, 'get', 'get [COMMAND]', 'downloads excel files from website'
  #register Orsos::ConvertCommand, 'convert', 'convert [COMMAND]', 'downloads and converts xls to csv'
end
