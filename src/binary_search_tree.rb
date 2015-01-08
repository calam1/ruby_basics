class Node
	attr_accessor :value, :left, :right

	def initialize(value)
		@value = value
		@left = nil
		@right = nil
	end

	def insert(value)
		if value == self.value
			puts "same value do nothing, we don't insert duplicates"
		elsif value < self.value
			puts "value to insert is less than node value"
			if left.nil?
				self.left = Node.new(value)
			elsif
				self.left.insert(value)
			end
		elsif value > self.value
			puts "value to insert is greater than node value"
			if right.nil?
				self.right = Node.new(value)
			elsif
				self.right.insert(value)
			end
		end
	end

	def printInOrder
		unless left.nil?
			left.printInOrder
		end

		puts self.value

		unless right.nil?
			right.printInOrder
		end
	end
end

class BinarySearchTree
	attr_accessor :root

	def insert(value)
		if root.nil?
			self.root = Node.new(value)
		else
			root.insert(value)	
		end
	end

	def insert_recursively(value)
		self.root = insert_value_recursively(value, self.root)
	end

	def insert_value_recursively(value, node)
		if node.nil?
			node = Node.new(value)
			return node
		end

		if value < node.value
			node.left = insert_value_recursively(value, node.left)
		end

		if value > node.value
			node.right = insert_value_recursively(value, node.right)
		end

		return node
	end

	def max_depth
		max_depth_of_node(self.root)	
	end

	def max_depth_of_node(node)
		if node.nil? 
			return 0
		end

		return [max_depth_of_node(node.left), max_depth_of_node(node.right)].max + 1
	end

	def min_depth
		min_depth_of_node(self.root)	
	end

	def min_depth_of_node(node)
		if node.nil? 
			return 0
		end

		return [min_depth_of_node(node.left), min_depth_of_node(node.right)].min + 1
	end

	def is_balanced?
		return (max_depth - min_depth) <= 1
	end

	def diameter
		return diameter_of_node(self.root)	
	end

	def diameter_of_node(node)
		if node.nil?
			return 0
		end

		left_height = max_depth_of_node(node.left)
		right_height = max_depth_of_node(node.right)

		left_diameter = diameter_of_node(node.left)
		right_diameter = diameter_of_node(node.right)

		return [(1 + left_height + right_height), [left_diameter, right_diameter].max].max
	end

	def printInOrder
		self.root.printInOrder
	end

	private :insert_value_recursively, :max_depth_of_node, :min_depth_of_node, :diameter_of_node

end

bst = BinarySearchTree.new
bst.insert(5)
bst.insert(15)
bst.insert(2)
bst.insert(25)
puts "-----------------"
puts "root value of bst #{bst.root.value}"
puts "-----------------"
bst.printInOrder
puts "-----------------"
puts "max depth of BST is #{bst.max_depth}"
puts "-----------------"
puts "min depth of BST is #{bst.min_depth}"
puts "-----------------"
puts "bst is balanced: #{bst.is_balanced?}"
puts "-----------------"
puts "diameter of BST is #{bst.diameter}"
puts "-----------------"
bst2 = BinarySearchTree.new
bst2.insert_recursively(6)
bst2.insert_recursively(22)
bst2.insert_recursively(5)
bst2.insert_recursively(4)
bst2.insert_recursively(2)
puts "root value of bst2 #{bst2.root.value}"
puts "-----------------"
bst2.printInOrder
puts "-----------------"
puts "max depth of BST2 is #{bst2.max_depth}"
puts "-----------------"
puts "min depth of BST2 is #{bst2.min_depth}"
puts "-----------------"
puts "bst is balanced: #{bst2.is_balanced?}"
puts "-----------------"
puts "diameter of BST2 is #{bst2.diameter}"
