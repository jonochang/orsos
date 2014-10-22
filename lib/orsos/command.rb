require 'thor'
class Orsos::Command < Thor
  desc "foo", "Prints foo"
  def foo
    puts "foo"
  end
end
