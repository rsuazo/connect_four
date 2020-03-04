class Array
  def all_empty?
    self.all? { |element| element.to_s.empty? }
  end

  def all_same?
    self.all? { |element| element == self[0] }
  end

  def four_in_a_row?
    count = 0
    x = 0
    y = x + 1

    while x < length do
      while y < length do
        if self[y] == self[x] && self[x] != ''
          count += 1
        else
          break
        end
        return true if count == 3
        y += 1
      end
      count = 0
      x += 1
      y = x + 1
    end    
    false
  end
  
    
  def any_empty?
    self.any? { |element| element.to_s.empty? }
  end

  def none_empty?
    !any_empty?
  end
end