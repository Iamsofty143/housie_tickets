#!/usr/bin/env ruby

# Housie Ticket Generator
# 
# This program generates random Housie tickets according to the following rules:
# - Each ticket is a 3x9 grid (3 rows, 9 columns)
# - Each ticket contains exactly 15 numbers from 1 to 90
# - Each number from 1 to 90 is used exactly once across all tickets
# - Column 1: numbers 1-9, Column 2: numbers 10-19, ..., Column 9: numbers 80-90
# - Each column contains 1, 2, or 3 numbers in increasing order downwards
# - Each row contains exactly 5 numbers (and 4 blanks)
# - Numbers within each column must be in increasing order from top to bottom

require 'set'

class HousieTicketGenerator
  # Column ranges for Housie tickets
  COLUMN_RANGES = [
    (1..9),      # Column 1: 1-9
    (10..19),    # Column 2: 10-19
    (20..29),    # Column 3: 20-29
    (30..39),    # Column 4: 30-39
    (40..49),    # Column 5: 40-49
    (50..59),    # Column 6: 50-59
    (60..69),    # Column 7: 60-69
    (70..79),    # Column 8: 70-79
    (80..90)     # Column 9: 80-90
  ].freeze

  def initialize
    @used_numbers = Set.new
  end

  # Main function to generate and print a Housie ticket
  def generate_ticket
    # Reset used numbers for each new ticket
    @used_numbers.clear
    
    # Initialize the ticket grid with nil values (representing blanks)
    ticket = Array.new(3) { Array.new(9, nil) }
    
    # Generate a valid ticket using a proper algorithm
    if generate_valid_ticket(ticket)
      print_ticket(ticket)
      return ticket
    else
      puts "Failed to generate a valid ticket. Trying again..."
      return generate_ticket
    end
  end

  private

  # Generate a valid ticket using a proper algorithm
  def generate_valid_ticket(ticket)
    # First, determine how many numbers each column should have
    # We need exactly 15 numbers total, distributed across 9 columns
    # and exactly 5 numbers per row
    
    # Use a known valid distribution that works
    column_counts = [2, 2, 2, 2, 2, 2, 1, 1, 1]  # 6 columns with 2, 3 columns with 1
    
    # Generate numbers for each column based on the distribution
    COLUMN_RANGES.each_with_index do |range, col_index|
      count = column_counts[col_index]
      next if count == 0
      
      # Select random numbers from the range
      available_numbers = range.to_a - @used_numbers.to_a
      return false if available_numbers.size < count
      
      selected_numbers = available_numbers.sample(count).sort
      
      # Place numbers in the column (increasing order downwards)
      selected_numbers.each_with_index do |number, row_index|
        ticket[row_index][col_index] = number
        @used_numbers.add(number)
      end
    end
    
    # Now we need to redistribute the numbers to ensure exactly 5 per row
    # The current distribution has: 6 columns with 2 numbers = 12 numbers in first 2 rows
    # and 3 columns with 1 number = 3 numbers in first row
    # So we have: Row 1: 9 numbers, Row 2: 6 numbers, Row 3: 0 numbers
    
    # We need to move some numbers from row 1 to row 3 to get 5 numbers per row
    redistribute_numbers(ticket)
    
    true
  end

  # Redistribute numbers to ensure exactly 5 numbers per row
  def redistribute_numbers(ticket)
    # Count numbers in each row
    row_counts = ticket.map { |row| row.count { |cell| !cell.nil? } }
    
    # If row 1 has more than 5 numbers, move some to row 3
    if row_counts[0] > 5
      numbers_to_move = row_counts[0] - 5
      
      # Find columns that have numbers in row 1 but not in row 3
      columns_with_numbers_in_row1 = []
      (0...9).each do |col|
        if ticket[0][col] && !ticket[2][col]
          columns_with_numbers_in_row1 << col
        end
      end
      
      # Move numbers from row 1 to row 3
      columns_to_move = columns_with_numbers_in_row1.sample(numbers_to_move)
      columns_to_move.each do |col|
        ticket[2][col] = ticket[0][col]
        ticket[0][col] = nil
      end
    end
    
    # If row 2 has more than 5 numbers, move some to row 3
    if row_counts[1] > 5
      numbers_to_move = row_counts[1] - 5
      
      # Find columns that have numbers in row 2 but not in row 3
      columns_with_numbers_in_row2 = []
      (0...9).each do |col|
        if ticket[1][col] && !ticket[2][col]
          columns_with_numbers_in_row2 << col
        end
      end
      
      # Move numbers from row 2 to row 3
      columns_to_move = columns_with_numbers_in_row2.sample(numbers_to_move)
      columns_to_move.each do |col|
        ticket[2][col] = ticket[1][col]
        ticket[1][col] = nil
      end
    end
    
    # Ensure numbers in each column are in increasing order
    (0...9).each do |col|
      column_numbers = []
      (0...3).each do |row|
        column_numbers << ticket[row][col] if ticket[row][col]
      end
      
      # Sort the numbers and place them back in increasing order
      if column_numbers.size > 1
        sorted_numbers = column_numbers.sort
        number_index = 0
        (0...3).each do |row|
          if ticket[row][col]
            ticket[row][col] = sorted_numbers[number_index]
            number_index += 1
          end
        end
      end
    end
  end

  # Print the ticket in a readable format
  def print_ticket(ticket)
    puts "\n" + "=" * 50
    puts "HOUSIE TICKET"
    puts "=" * 50
    
    # Print column headers
    puts "    1   2   3   4   5   6   7   8   9"
    puts "  " + "-" * 37
    
    # Print each row
    ticket.each_with_index do |row, row_index|
      print "  |"
      row.each do |cell|
        if cell.nil?
          print " X |"
        else
          print " #{cell.to_s.rjust(2)}|"
        end
      end
      puts
      
      # Add separator line between rows
      puts "  " + "-" * 37 unless row_index == 2
    end
    
    puts "=" * 50
    puts
  end
end

# Main function that can be called to generate and print a Housie ticket
def generate_housie_ticket
  generator = HousieTicketGenerator.new
  generator.generate_ticket
end

# Example usage and testing
if __FILE__ == $0
  puts "Generating a random Housie ticket..."
  generate_housie_ticket
  
  puts "Generating another ticket..."
  generate_housie_ticket
end
