class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next = nil
    @prev = nil
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = @head
    until current_node == @tail
      current_node = current_node.next
      return current_node.val if current_node.key == key
    end
    nil
  end

  def include?(key)
    return false if self.get(key).nil?
    true
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = self.last
    self.last.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
    new_node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val unless node.nil?
  end

  def remove(key)
    node = get_node(key)
    unless node.nil?
      prev_node = node.prev
      next_node = node.next
      prev_node.next = next_node
      next_node.prev = prev_node
      node.remove
    end
  end

  def each(&prc)
    current_node = @head
    until current_node == @tail.prev
      current_node = current_node.next
      prc.call(current_node)
    end

  end

  private

  def get_node(key)
    current_node = @head
    until current_node == @tail
      current_node = current_node.next
      return current_node if current_node.key == key
    end
    nil
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
