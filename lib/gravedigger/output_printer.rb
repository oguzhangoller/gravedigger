# frozen_string_literal: true

module Gravedigger
  module OutputPrinter
    NEW_LINE = "\n"
    def self.print_output(unused_methods, unused_variables, error_messages = [])
      print_scan_results(unused_methods.length, unused_variables.length, error_messages.length)

      if unused_methods.any?
        puts NEW_LINE
        puts "Unused methods in your project:"
        puts NEW_LINE
        unused_methods.each do |method_name, location|
          puts "#{method_name}: #{location}"
        end
      end

      if unused_variables.any?
        puts NEW_LINE
        puts "Unused variables in your project:"
        puts NEW_LINE
        unused_variables.each do |variable_name, location|
          puts "#{variable_name}: #{location}"
        end
      end

      if error_messages.any?
        puts NEW_LINE
        puts "Errors encountered while processing:"
        puts NEW_LINE
        error_messages.each do |error_message|
          puts error_message
        end
      end
    end

    def self.print_scan_results(unused_methods_length, unused_variables_length, error_messages_length)
      puts "="*80 + NEW_LINE
      puts "Scanning completed."
      puts print_with_green_color(unused_methods_length) + " unused method definitions found."
      puts print_with_green_color(unused_variables_length) + " unused variable definitions found."
      puts print_with_red_color(error_messages_length) + " errors encountered."
      puts "="*80 +NEW_LINE
    end

    def self.print_with_green_color(string)
      "\e[32m#{string}\e[0m"
    end

    def self.print_with_red_color(string)
      "\e[31m#{string}\e[0m"
    end
  end
end
