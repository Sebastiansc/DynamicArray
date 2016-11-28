# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  include Enumerable

  def initialize(length)
    @size = length
    @store = []
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  def each(&prc)
    @store.each{ |el| prc.call(el)}
  end

  protected
  attr_accessor :store
end
