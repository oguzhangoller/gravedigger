require "thor"
require "gravedigger/definition_finder.rb"
require "gravedigger/usage_searcher"
require "gravedigger/output_printer"

module Gravedigger
  class CLI < Thor

    desc "dig", "Find unused code in your Rails project"

    def dig
      method_definitions, get_definitions_errors = Gravedigger::DefinitionFinder.get_definitions
      output, method_search_errors = Gravedigger::UsageSearcher.search_methods(method_definitions)

      errors = get_definitions_errors.concat method_search_errors

      Gravedigger::OutputPrinter.print_output(output, errors)
    end
  end
end
