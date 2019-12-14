# frozen_string_literal: true

module Gravedigger
  module OutputPrinter
    NEW_LINE = "\n"
    def self.print_output(output, error_messages = [])
      print_scan_results(output.length, error_messages.length)

      if output.any?
        puts NEW_LINE
        puts "Unused methods in your project:"
        puts NEW_LINE
        output.each do |method_name, location|
          puts "#{method_name}: #{location}"
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

    def self.print_scan_results(output_length, error_messages_length)
      puts "="*80 + NEW_LINE
      puts "Scanning completed."
      puts print_with_green_color(output_length) + " unused method definitions found."
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
