require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
      return @map[key].val
    else
      if count == @max
        eject!
      end
      node = @store.append(key, calc!(key))
      @map.set(key, node)
      return node.val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    remove_node(node)
    node.prev = @store.last
    node.next = @store.last.next
    @store.last.next = node
    @store.last.next.prev = node
  end

  def eject!
    remove_node(@store.first)
  end

  def remove_node(node)
    debugger
    prev_node = node.prev
    next_node = node.next
    prev_node.next = next_node
    next_node.prev = prev_node
    node.remove
  end
end
