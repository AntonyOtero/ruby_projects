class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @head.nil? then
      @tail = Node.new(value)
      @head = @tail
    elsif @tail.nil? then
      @tail = Node.new(value)
      @head.next_node = @tail
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size
    counter = 0
    tmp = @head
    while not tmp.nil? do
      counter += 1
      tmp = tmp.next_node
    end
    counter
  end


  def head
    @head
  end

  def tail
    @tail
  end

  def at(index)
    return @head if index == "first"
    return @tail if index == "last"
    tmp = @head
    if not tmp.nil? then
      index.times do
        tmp = tmp.next_node
      end
    end
    tmp
  end

  def pop
    tmp = @tail
    @tail = self.at(self.size - 2)
    @tail.next_node = nil
    tmp
  end

  def contains?(value)
    tmp = @head
    while not tmp.nil? do
      return true if tmp.value == value
      tmp = tmp.next_node
    end
    false
  end

  def find(value)
    tmp = @head
    counter = 0
    while not tmp.nil? do
      return counter if tmp.value == value
      tmp = tmp.next_node
      counter += 1
    end
  end

  def to_s
    tmp = @head
    while not tmp.nil? do
      print "( #{tmp.value} ) -> "
      tmp = tmp.next_node
    end
    puts "nil"
  end

  def insert_at(value, index)
    if index - 1 >= 0 then
      pre_node = self.at(index - 1)
    end
    next_node = self.at(index)
    insert_node = Node.new(value, next_node)
    pre_node.next_node = insert_node
  end

  def remove_at(index)
    if index - 1 >= 0 then
      pre_node = self.at(index - 1)
    end
    next_node = self.at(index + 1)
    pre_node.next_node = next_node
  end


end

class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

new_list = LinkedList.new
new_list.append('A')
new_list.prepend('B')
new_list.prepend('C')
new_list.prepend('D')
new_list.prepend('E')
# p new_list.size
# p new_list.at(4)
# new_list.pop
# p new_list.at("last")
# p new_list.contains?('F')
# p new_list.find('A')
# new_list.to_s
new_list.insert_at("F", 1)
new_list.to_s
new_list.remove_at(4)
new_list.to_s