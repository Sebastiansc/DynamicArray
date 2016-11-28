require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @logical_idx = 0
  end

  # O(1)
  #Finds the index starting to count from the logical_index
  def [](index)
    check_index(index)
    @store[actual_index(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[actual_index(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = self[@length - 1]
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    resize! if @length > capacity
    self[@length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    val = self[0]
    self[0] = nil
    @length -= 1
    @logical_idx = (@logical_idx + 1) % @capacity
    val
  end

  # O(1) ammortized
  #All other elements stay in place and ordered is only enforced by computing index with the new set logical_index.
  def unshift(val)
    @length += 1
    resize! if @length > @capacity
    @logical_idx = (@logical_idx - 1) % @capacity
    self[0] = val
  end

  protected
  attr_accessor :capacity, :logical_idx, :store
  attr_writer :length

  def check_index(index)
    if index < 0 || index >= @length
      raise "index out of bounds"
    end
  end

  def actual_index(index)
    (@logical_idx + index) % @capacity
  end

  def resize!
    new_capacity = @capacity * 2
    store = StaticArray.new(new_capacity)
    @length.times{ |idx| store[idx] = self[idx] }
    @store = store
    @logical_idx = 0
    @capacity = new_capacity
  end
end
