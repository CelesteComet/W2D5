class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    str = self.to_s
    total = 0
    str.each_char.with_index do |ch, idx|
      total += ch.ord * 257**idx
    end
    total
  end
end

class String
  def hash
    total = 0
    self.each_char.with_index do |ch, idx|
      total += ch.ord * 256**idx
    end
    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    str = self.to_a.sort.to_s
    total = 0
    str.each_char.with_index do |ch, idx|
      total += ch.ord * 258**idx
    end
    total
  end
end
