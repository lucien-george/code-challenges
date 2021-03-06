## explanation on why we use size / 2 - 1
# A complete binary heap of height h has 2^h - 1 elements.
# Of those, elements in the closed range [0, (2^h)/2-1] are internal nodes (including the root),
# and elements in the closed range [(2^h)/2, 2^h-2] are leaf nodes.
# The leaf nodes are already (trivial) heaps. The first element you need to heapify -- because it has a child,
# which might violate the heap property -- is at index (2^h)/2-1.

class Heap
  attr_accessor :size, :array

  def initialize(array = [])
    @array = array
    @size = array.size
    create_heap
  end

  def left_index(index)
    2 * index + 1
  end

  def right_index(index)
    2 * index + 2
  end

  def left(index)
    array[left_index(index)]
  end

  def right(index)
    array[right_index(index)]
  end

  def leaf?(index)
    index >= size / 2
  end

  def in_place?(index)
    array[index] >= left(index) && array[index] >= right(index)
  end

  def heapify(index)
    return if leaf?(index) || in_place?(index)

    left = left(index)
    right = right(index)

    larger_child_index = left > right ? left_index(index) : right_index(index)

    array[index], array[larger_child_index] = array[larger_child_index], array[index]
    heapify(larger_child_index)
  end

  def create_heap
    (size / 2 - 1).downto(0) do |index|
      heapify(index)
    end
  end

  def max
    array.first
  end

  def pop
    array[size - 1], array[0] = array[0], array[size - 1]
    @size -= 1
    max = array.pop
    heapify(0)
    max
  end

  def parent(index)
    array[(index - 1) / 2]
  end
end

heap = Heap.new((0..10).to_a)
heap.create_heap
max = heap.pop
p heap, max
