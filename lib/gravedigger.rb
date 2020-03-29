require "thor"
require "gravedigger/definition_finder.rb"
require "gravedigger/usage_searcher"
require "gravedigger/output_printer"

module Gravedigger
  class CLI < Thor

    desc "dig", "Find unused code in your Rails project"

    def dig
      files_to_search = Dir[File.join(Dir.pwd,"/{app,lib,config}/**/*.{erb,haml,rb}")]
      method_definitions, variable_definitions, definition_errors = Gravedigger::DefinitionFinder.get_definitions(files_to_search)

      unused_methods, method_search_errors = Gravedigger::UsageSearcher.search_methods(method_definitions, files_to_search)
      unused_variables, variable_search_errors = Gravedigger::UsageSearcher.search_variables(variable_definitions, files_to_search)

      errors = definition_errors + method_search_errors + variable_search_errors

      Gravedigger::OutputPrinter.print_output(unused_methods, unused_variables, errors)
    end
  end
end
