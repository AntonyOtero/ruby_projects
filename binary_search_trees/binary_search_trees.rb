class Node
  include Comparable
  attr_accessor :left, :right, :data
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :root
  def initialize(arr)
    @arr = arr
    @root = build_tree(@arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def clean_arr(arr)
    clean_arr = arr.sort.uniq
  end

  # [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
  def build_tree(arr)
    nd_arr = clean_arr(arr)

    return nil if 0 > nd_arr.length - 1

    middle = nd_arr.length / 2

    node = Node.new(nd_arr[middle])

    node.left = build_tree(nd_arr.slice(0...middle))

    node.right = build_tree(nd_arr.slice((middle + 1)...nd_arr.length))

    node
  end

  def insert(value)
    clean_arr = clean_arr(@arr + [value])
    @root = build_tree(clean_arr)
  end

  def delete(value)
    clean_arr = clean_arr(@arr)
    clean_arr.delete_if {|elem| elem == value}
    @root = build_tree(clean_arr)
  end
 
  def find(value)

    return @root if @root.data == value

    tmp_left = @root.left
    while not tmp_left.left.nil? do
      
    end

    tmp_right = @root
    while not tmp_right.right.nil? do
    end
  end

  def level_order
  end

  def inorder
  end

  def preorder
  end
   
  def postorder
  end

  def height 
  end

  def depth 
  end
  

end

new_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# new_tree.pretty_print
# new_tree.insert(2)
# new_tree.pretty_print
# new_tree.delete(2)
new_tree.pretty_print
p new_tree.root