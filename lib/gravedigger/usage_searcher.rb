# frozen_string_literal: true

module Gravedigger
  module UsageSearcher
    def self.search_methods(method_definitions, files_to_search)
      errors = []
      files_to_search.each do |fileName|
        begin
          File.open(fileName).each_line do |line|
            next unless line
            method_usage_matches = line.scan(/(?<!def)[ \.\-\:\'\(\{\!\=\&\#\[\*]+([a-zA-Z0-9?_\!]+)?(?=[\\ \,\/\[\'\:\(\)\.\}]|$)/)
            method_usage_matches.each do |method_usage_match|
              method_definitions.delete(method_usage_match.first) if method_usage_match
            end
          end
        rescue StandardError => error
          errors << "Error while searching method in file: #{fileName}\n"\
"#{error.message}"
        end
      end

      return method_definitions, errors
    end

    def self.search_variables(variable_definitions, files_to_search)
      errors = []
      files_to_search.each do |fileName|
        begin
          File.readlines(fileName).each_with_index do |line,index|
            next unless line
            variable_usage_matchs = line.scan(/[ \(\{\[\=\,\+\*\-\/\:]+([A-Za-z0-9\_\-\?\!\@]+)/)
            variable_usage_matchs.each do |variable_usage_match|
              next unless variable_usage_match
              if variable_definitions[variable_usage_match.first] != "[#{fileName}:#{index+1}]"
                variable_definitions.delete(variable_usage_match.first)
              end
              
            end
          end
        rescue StandardError => error
          errors << "Error while searching variable in file: #{fileName}\n"\
"#{error.message}"
        end
      end

      return variable_definitions, errors
    end
  end
end
