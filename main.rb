$LOAD_PATH << File.join(__dir__, 'lib')

require 'life'

if ARGV.empty?
  puts "Usage: #{$0} /path/to/config.json"
  exit 1
end

begin
  grid = Life.load(ARGV.first)
  grid.run
rescue Interrupt
  puts
end
