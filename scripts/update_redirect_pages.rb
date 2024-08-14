#!/usr/bin/env ruby
require 'date'

# the directory where your posts are located
POSTS_DIR = '_posts'

# The file where your redirects are located
# _redirects file here follows the following format
# old_url new_url status
# Example:
# https://example.com/old_url https://example.com/old-url 301
REDIRECTS_FILE = '_redirects'

def sanitize_slug(slug)
  slug.downcase
      .gsub(/[^a-z0-9\-_]/, '') # Remove all characters except lowercase letters, numbers, hyphens, and underscores
      .gsub('_', '-')           # Replace underscores with hyphens
      .gsub(/-+/, '-')          # Replace multiple hyphens with a single hyphen
      .gsub(/^-|-$/, '')        # Remove leading and trailing hyphens
end

redirects = []

Dir.glob(File.join(POSTS_DIR, '*.md')).each do |file|
  filename = File.basename(file, '.md')
  date_parts = filename.split('-')[0..2].map(&:to_i)
  slug = filename.split('-')[3..].join('-')

  begin
    date = Date.new(*date_parts)
    new_slug = sanitize_slug(slug)

    next if slug == new_slug

    old_url = "/#{date.strftime('%Y/%m/%d')}/#{slug}/"
    new_url = "/#{date.strftime('%Y/%m/%d')}/#{new_slug}/"
    redirects << "#{old_url} #{new_url} 301"
    puts "Found redirect: #{old_url} -> #{new_url}"
  rescue Date::Error
    puts "Warning: Invalid date format in filename: #{filename}"
  end
end

if redirects.any?
  file = File.open(REDIRECTS_FILE, 'a')
  file.write(REDIRECTS_FILE, redirects.join("\n"))
  puts "Redirects written to #{REDIRECTS_FILE}"
else
  puts 'No redirects found'
end
