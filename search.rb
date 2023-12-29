require 'optparse'
require 'json'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: search.rb [options]"

  opts.on('-q', '--query STRING', 'Search string') do |query|
    options[:query] = query
  end

  opts.on('-j', '--json [STRING]', 'File path of JSON Array to search') do |json|
    options[:json] = json
  end

  opts.on('-k', '--key [STRING]', 'JSON key to search on, if left nil it will default to "name"') do |key|
    options[:key] = key
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

key = (options[:key] || 'full_name').to_sym
file_path = options[:json] || './clients.json'
query_string = options[:query].downcase

file = File.read(file_path)
json_array = JSON.parse(file).map{|hash| hash.transform_keys(&:to_sym) }
matches = json_array.select { |json| json[key].include? query_string }

puts "Key: #{key}\n"
puts "Query String: #{query_string}\n"
puts "Search Results: \n"
matches.each_with_index do |json, index|
  puts "\t #{index + 1}.\n"
  puts "\t\t ID: #{json[:id]}\n"
  puts "\t\t Full Name: #{json[:full_name]}\n"
  puts "\t\t Email: #{json[:email]}\n"
end

email_group = json_array.group_by{ |json| json[:email] }
counts = email_group.map { |value, group| [value, group.map { |json| json[:id] }]}
duplicates = counts.select { |key, value| value.length > 1 }

puts "#{duplicates.length} Duplicate(s) Found: \n"
duplicates.each_with_index do |duplicate, index|
  human_readable_ids = [duplicate[1][0...-1].join(", "), duplicate[1].last].join(", and ")
  puts "  #{index + 1}. Clients with ids #{human_readable_ids} are using the same email (#{duplicate[0]})\n"
end
