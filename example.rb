#!/usr/bin/env ruby

# Example usage of the Housie Ticket Generator
# This script demonstrates how to generate multiple tickets and use the generator programmatically

require_relative 'housie_ticket_generator'

puts "Housie Ticket Generator - Example Usage"
puts "=" * 50

# Example 1: Generate a single ticket using the main function
puts "\nExample 1: Generate a single ticket"
puts "-" * 30
generate_housie_ticket

# Example 2: Generate multiple tickets using the class directly
puts "\nExample 2: Generate multiple tickets"
puts "-" * 30

generator = HousieTicketGenerator.new

3.times do |i|
  puts "\nTicket #{i + 1}:"
  ticket = generator.generate_ticket
  
  # You can also work with the ticket data programmatically
  puts "  Numbers in ticket: #{ticket.flatten.compact.sort.join(', ')}"
end

# Example 3: Generate tickets without printing (for programmatic use)
puts "\nExample 3: Generate ticket data without printing"
puts "-" * 30

# Create a new generator instance
generator2 = HousieTicketGenerator.new

# Generate a ticket and get the data
ticket_data = generator2.generate_ticket

# Work with the ticket data
puts "Ticket structure:"
ticket_data.each_with_index do |row, row_index|
  numbers = row.map { |cell| cell.nil? ? 'X' : cell.to_s.rjust(2) }
  puts "  Row #{row_index + 1}: [#{numbers.join(', ')}]"
end

puts "\nExample completed!"
