# frozen_string_literal: true

module Gravedigger
  module DefinitionFinder
    def self.get_definitions
      all_file_names = Dir[File.join(Dir.pwd,"/{app,lib,config}/**/*.{erb,haml,rb}")]
      method_definitions = {}
      errors = []

      all_file_names.each do |fileName|
        begin
        File.readlines(fileName).each_with_index do |line,index|
          next unless line
          method_name = find_method_definitions(line)
          location = "[#{fileName}:#{index+1}]"

          method_definitions[method_name] = location if method_name
        end
        rescue StandardError => error
          errors << "Error while reading file: #{fileName} \n #{error.message}"
        end
      end

      return method_definitions, errors
    end

    def self.find_method_definitions(line)
      find_method_regex_result = line[/[ ]+def [a-zA-Z0-9?_.\!]*/]
      if find_method_regex_result
        method_name = find_method_regex_result.strip.slice(4..-1)
        method_name = method_name.slice(0,4) if method_name && method_name[0..4] == 'self.'
      end
      method_name
    end
  end
end
