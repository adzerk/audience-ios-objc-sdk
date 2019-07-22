#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

# This script is based on a script by ReSwift that can be found at
# https://github.com/ReSwift/ReSwift/blob/master/.scripts/doc-preprocessor

def parse_options(paired_args)
  options = { args: [] }
  index = 0
  while index < ARGV.length
    arg = ARGV[index]

    paired_key = paired_args[arg]
    if paired_key
      if index >= ARGV.length - 1
        puts "Unable to find a value for the arg: '#{arg}'"
        exit 1
      end
      options[paired_key] = ARGV[index + 1]
      index += 1
    elsif /--.+/ =~ arg
      puts 'unknown option: ' + arg
    else
      options[:args].push arg
    end
    index += 1
  end
  options
end

def require_args(args, count)
  return unless args.length != count

  puts 'usage: docgen [input] [output] [...options]'
  exit 1
end

def split_sections(content)
  result = {}
  current = ''
  content.split("\n").each do |line|
    if /^#( | \w).*/ =~ line
      current = line.sub(/^#/, '').strip
      # current = line
      result[current] = result[current] || ''
    else
      result[current] += "\n" + line
    end
  end

  result.keys.each do |key|
    result[key] = result[key].strip
  end
  result
end

paired_args = {
  '--section' => :section,
  '--title' => :title,
  '--transforms' => :transforms
}
options = parse_options paired_args

require_args options[:args], 2
file_in = options[:args][0]
file_out = options[:args][1]

input = IO.read(file_in)

result = ''

# -----

if options[:section]
  sections = split_sections input
  section_name = options[:section]
  if sections[section_name]
    result = sections[section_name]
  else
    puts "Unable to find section: '" + section_name + "'"
    exit 1
  end
else
  result = input
end

result = "# #{options[:title]}\n\n" + result if options[:title]

# -----

if result == ''
  puts 'Not writing output as result is empty'
  exit 1
end

IO.write(file_out, result)

puts "[Processed]: #{file_out}"
