# Tax Calculator

This is a basic text-based tax calculator program.

## Installation and usage
1) Clone this repository.
1) Ensure you have all dependencies installed.
1) Open a terminal, navigate to the project folder
1) Run `ruby bin/application.rb`

To install all dependencies, please follow online guides. I recommend the following steps:
- Install RVM
- Install ruby through RVM
- Install bundle
- Install all other gems using bundle

### Dependencies
- ruby 3.1.3
- All gems listed in Gemfile

## Input

The program expects input to be saved in a file named `input`.

### Input Format

Input should follow the format: < number > < item description > at < price >

### Examples:

- 2 books at 12.49

- 1 imported box of chocolates at 10.00

- 3 imported boxes of chocolates at 11.25

## Configuration

The default configuration can be tweaked in the `config/rules.json` file.

The following rules are implemented by default.

### Basic tax

10% on all goods (except books, food and medical products)

### Import duty tax

5% on all imported goods.

### Rounding

Given shelf price p and tax rate of n%.

A np/100 amount of sales tax is rounded up to the nearest 0.05.

### Catalog

These are the terms added by default to identify books, food and medical items.

More terms can be added in `config/rules.json`.

- books: book
- food: food, chocolate
- medical: medical, pill