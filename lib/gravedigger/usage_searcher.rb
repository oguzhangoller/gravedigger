# frozen_string_literal: true

module Gravedigger
  module UsageSearcher
    def self.search_methods(method_definitions)
      all_file_names = Dir[File.join(Dir.pwd,"/{app,lib,config}/**/*.{erb,haml,rb}")]
      errors = []
      all_file_names.each do |fileName|
        begin
          File.open(fileName).each_line do |line|
            next unless line
            method_usage_matches = line.scan(/(?<!def)[ \.\-\:\'\(\{\!\=\&\#\[\*]+([a-zA-Z0-9?_\!]+)?(?=[\\ \,\/\[\'\:\(\)\.\}]|$)/)
            method_usage_matches.each do |method_usage_match|
              method_definitions.delete(method_usage_match.first) if method_usage_match
            end
          end
        rescue StandardError => error
          errors << "Error while searching method: #{method_name} in file: #{fileName}\n"\
"#{error.message}"
        end
      end

      return method_definitions, errors
    end
  end
end
