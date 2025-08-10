#!/usr/bin/env ruby

require_relative 'housie_ticket_generator'

puts "Testing Housie ticket generation..."
puts "=" * 50

generator = HousieTicketGenerator.new
ticket = generator.generate_ticket

puts "\nVerifying ticket validity:"
puts "-" * 30

# Check each row has exactly 5 numbers
ticket.each_with_index do |row, row_index|
  numbers_in_row = row.count { |cell| !cell.nil? }
  puts "Row #{row_index + 1}: #{numbers_in_row} numbers #{numbers_in_row == 5 ? '✓' : '✗'}"
end

# Check total numbers
total_numbers = ticket.flatten.compact.size
puts "Total numbers: #{total_numbers} #{total_numbers == 15 ? '✓' : '✗'}"

# Check column ranges
COLUMN_RANGES = [
  (1..9), (10..19), (20..29), (30..39), (40..49),
  (50..59), (60..69), (70..79), (80..90)
]

puts "\nChecking column ranges:"
puts "-" * 30

(0...9).each do |col|
  range = COLUMN_RANGES[col]
  column_numbers = []
  (0...3).each do |row|
    column_numbers << ticket[row][col] if ticket[row][col]
  end
  
  if column_numbers.any?
    puts "Column #{col + 1} (#{range}): #{column_numbers.sort}"
    
    # Check if numbers are in correct range
    valid_range = column_numbers.all? { |num| range.include?(num) }
    puts "  Range valid: #{valid_range ? '✓' : '✗'}"
    
    # Check if numbers are in increasing order
    increasing_order = column_numbers == column_numbers.sort
    puts "  Increasing order: #{increasing_order ? '✓' : '✗'}"
  end
end

puts "\nTest completed!"
