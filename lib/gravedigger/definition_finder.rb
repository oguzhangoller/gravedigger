# frozen_string_literal: true

module Gravedigger
  module DefinitionFinder
    def self.get_definitions(files_to_search)
      method_definitions = {}
      variable_definitions = {}
      errors = []
      initialize_method = false

      files_to_search.each do |fileName|
        initialize_method = false
        begin
        File.readlines(fileName).each_with_index do |line,index|
          next unless line
          next if initialize_method && not_ending(line)
          method_name = find_method_definitions(line)
          if method_name == 'initialize'
            initialize_method = true
          end
          variable_name = find_variable_definitions(line)

          location = "[#{fileName}:#{index+1}]"

          method_definitions[method_name] = location if method_name
          variable_definitions[variable_name] = location if variable_name
        end
        rescue StandardError => error
          errors << "Error while reading file: #{fileName} \n #{error.message}"
        end
      end

      return method_definitions, variable_definitions, errors
    end

    def self.find_method_definitions(line)
      find_method_regex_result = line[/[ ]+def [a-zA-Z0-9?_.\!]*/]
      if find_method_regex_result
        method_name = find_method_regex_result.strip.slice(4..-1)
        method_name = method_name.slice(0,4) if method_name && method_name[0..4] == 'self.'
      end
      method_name
    end

    def self.find_variable_definitions(line)
      result = line.scan(/^[ ]+([A-Za-z0-9_\!\@]*)[ ]*\=[^\=\>]/)
      return nil if result.empty?
      result[0][0]
    end

    def self.not_ending(line)
      line.strip != 'end'
    end
  end
end
