require_relative "static_array"
require 'byebug'

class DynamicArray

  attr_reader :length

  #Capacity is the number of available buckets in the static array.
  #Length is the number of elements currently stored.
  #Length == 1 ? index = 0 || @length - 1
  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @length <= index
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # relength.
  #Push item to next index based on current length.
  def push(val)
    @length += 1
    resize! if @length > capacity
    self[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  #Delete first element. Fill new store with all element's index offset by -1
  def shift
    raise "index out of bounds" if @length == 0
    shifted = self[0]
    store = StaticArray.new(@capacity)
    @store.each_with_index do |el, idx|
      break if idx == @length - 1
      store[idx] = @store[idx + 1]
    end
    @length -= 1
    @store = store
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    resize! if @length > @capacity
    store = StaticArray.new(@capacity)
    @store.each_with_index do |el,idx|
      store[idx + 1] = el
    end
    store[0] = val
    @store = store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity == 0 ? 1 : @capacity * 2
    store = StaticArray.new(@capacity)
    @store.each_with_index do |el, idx|
      store[idx] = el
    end
    @store = store
  end
end
