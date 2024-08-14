require 'net/http'
require 'uri'

# TODO: - update the base_url to your site name
BASE_URL = 'https://example.com/blog'.freeze

# The file where your redirects are located
# _redirects file here follows the following format
# old_url new_url status
# Example:
# https://example.com/old_url https://example.com/old-url 301
FILE_PATH = '_redirects'.freeze

errors = []

File.foreach(FILE_PATH) do |line|
  original_route, redirection_route, status = line.strip.split
  puts "http_route: #{original_route}"
  puts "redirection_route: #{redirection_route}"
  puts "status: #{status}"

  url = URI.join(BASE_URL, original_route)

  begin
    puts "making request to #{url}"
    response = Net::HTTP.get_response(url)

    if response.code.to_i != status && ![200, 301].include?(response.code.to_i)
      errors << {
        route: original_route,
        expected_status: status,
        actual_status: response.code,
        redirection: redirection_route
      }
    end
  rescue StandardError => e
    puts 'ERROR!!'
    errors << {
      route: original_route,
      error: e.message,
      redirection: redirection_route
    }
  end
end

if errors.empty?
  puts 'No errors found.'
else
  puts 'Errors found:'
  errors.each do |error|
    puts "Route: #{error[:route]}"
    puts "Actual Status: #{error[:actual_status]}" if error[:actual_status]
    puts "Error: #{error[:error]}" if error[:error]
    puts "Redirection: #{error[:redirection]}"
    puts '---'
  end
end
