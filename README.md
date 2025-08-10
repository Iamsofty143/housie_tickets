# Housie Ticket Generator

A Ruby program to generate random Housie tickets (also known as Bingo tickets in the UK and some other countries).

## What is Housie?

Housie is a version of Bingo played in the UK and some other countries. Each ticket shows exactly 15 numbers, and in each ticket every number from 1 to 90 is used exactly once.

## Ticket Structure

A Housie ticket is a grid of 3 rows by 9 columns with the following rules:

- **Grid**: 3 rows × 9 columns
- **Total Numbers**: Exactly 15 numbers per ticket
- **Numbers per Row**: Each row contains exactly 5 numbers (and 4 blanks)
- **Column Ranges**:
  - Column 1: Numbers 1-9
  - Column 2: Numbers 10-19
  - Column 3: Numbers 20-29
  - Column 4: Numbers 30-39
  - Column 5: Numbers 40-49
  - Column 6: Numbers 50-59
  - Column 7: Numbers 60-69
  - Column 8: Numbers 70-79
  - Column 9: Numbers 80-90
- **Column Constraints**: Each column contains 1, 2, or 3 numbers in increasing order downwards
- **Number Distribution**: Each number from 1 to 90 is used exactly once across all tickets

## Files

- `housie_ticket_generator.rb` - Main program that generates Housie tickets
- `test_ticket.rb` - Test script to verify ticket validity
- `README.md` - This documentation file

## Usage

### Basic Usage

To generate a single Housie ticket:

```ruby
require_relative 'housie_ticket_generator'

# Generate and print a ticket
generate_housie_ticket
```

### Running the Program

```bash
# Generate tickets directly
ruby housie_ticket_generator.rb

# Run tests to verify ticket validity
ruby test_ticket.rb
```

### Example Output

```
==================================================
HOUSIE TICKET
==================================================
    1   2   3   4   5   6   7   8   9
  -------------------------------------
  | X | X | 20| 31| 41| X | X | 73| 83|
  -------------------------------------
  |  3| 16| 29| X | 43| 54| X | X | X |
  -------------------------------------
  |  7| 19| X | 36| X | 58| 63| X | X |
==================================================
```

## Algorithm

The program uses the following approach to generate valid tickets:

1. **Column Distribution**: Uses a known valid distribution `[2, 2, 2, 2, 2, 2, 1, 1, 1]` where:
   - 6 columns get 2 numbers each
   - 3 columns get 1 number each
   - Total: 6×2 + 3×1 = 15 numbers

2. **Number Selection**: For each column, randomly selects the required number of values from the appropriate range (1-9, 10-19, etc.)

3. **Redistribution**: Initially places numbers in the first available rows, then redistributes them to ensure exactly 5 numbers per row

4. **Ordering**: Ensures numbers within each column are in increasing order from top to bottom

## Requirements

- Ruby (tested with Ruby 2.7+)
- No external dependencies required

## Testing

The `test_ticket.rb` script verifies that generated tickets meet all requirements:

- ✅ Exactly 5 numbers per row
- ✅ Exactly 15 numbers total
- ✅ Numbers in correct column ranges
- ✅ Numbers in increasing order within columns

## License

This project is open source and available under the MIT License.
