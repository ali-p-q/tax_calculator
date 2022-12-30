# frozen_string_literal: true

module InputParser
  def parse(input_file_path)
    line_items = []
    File.foreach(input_file_path) do |each_line|
      scanned_line = each_line.scan(/[0-9a-zA-Z\.]+/)
      # Cast numeric values (assumes input file is properly formatted)
      quantity = scanned_line.first.to_i
      description = singularized_description(scanned_line, 1..scanned_line.length - 2)
      price = scanned_line.last.to_f
      # Merge items with same description
      updated = false
      line_items.each do |li|
        if li.description.eql?(description)
          li.quantity += quantity
          li.price += price
          updated = true
          break
        end
      end
      # If not merged to existing item, create new
      unless updated
        line_items.push(LineItem.new(quantity, description, price))
      end
    end
    return line_items
  end

  def singularized_description(words, range)
    range.each do |i|
      words[i] = lame_singularize(words[i])
    end
    return words[range].join(" ")
  end

  def lame_singularize(str)
    # TODO: Implement a smarter singularize (or use Rails)
    if str.eql?("boxes")
      return "box"
    elsif str.eql?("packets")
      return "packet"
    elsif str.eql?("bottles")
      return "bottle"
    elsif str.eql?("books")
      return "book"
    else
      return str
    end
  end
end
