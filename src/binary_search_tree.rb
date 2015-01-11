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
			if left.nil?
				self.left = Node.new(value)
			elsif
				self.left.insert(value)
			end
		elsif value > self.value
			if right.nil?
				self.right = Node.new(value)
			elsif
				self.right.insert(value)
			end
		end
	end

	def print_in_order
		unless left.nil?
			left.print_in_order
		end

		puts self.value

		unless right.nil?
			right.print_in_order
		end
	end
	
	def print_pre_order
		puts self.value

		unless left.nil?
			left.print_in_order
		end

		unless right.nil?
			right.print_in_order
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

	def has_path_sum?(value)
		return node_has_path_sum?(value, self.root)	
	end

	def node_has_path_sum?(value, node)
		if node.nil?
			return false
		end

		if node.left.nil? && node.right.nil?
			if node.value == value
				return true
			end
		else
			return node_has_path_sum?(value - node.value, node.left) || node_has_path_sum?(value - node.value, node.right)
		end

		return false
	end

	def self.process_sorted_array(sorted_array)
		return process_sorted_array_into_binary_search_tree(sorted_array, 0, sorted_array.size - 1)
	end

	def self.process_sorted_array_into_binary_search_tree(sorted_array, low, high)
		if (high < low)
			return nil
		end

		mid = (high - low)/2 + low
		node = Node.new(sorted_array.at(mid))
		node.left = process_sorted_array_into_binary_search_tree(sorted_array, low, mid - 1)
		node.right = process_sorted_array_into_binary_search_tree(sorted_array, mid + 1, high )

		return node
	end

	def node_count(node)
		if node.nil?
			return 0
		end

		left = node_count(node.left)
		right = node_count(node.right)

		return left + right + 1
	end

	def node_counter
		return node_count(self.root)
	end

	def node_leaves(node)
		if node.nil?
			return 0
		end

		if node.left.nil? && node.right.nil?
			return 1
		end
		
		left = node_leaves(node.left)
		right = node_leaves(node.right)

		return left + right 
	end	

	def leaf_counter
		return node_leaves(self.root)
	end

	def print_in_order
		self.root.print_in_order
	end

	def print_pre_order
		self.root.print_pre_order
	end

	private :insert_value_recursively, :max_depth_of_node, :min_depth_of_node, :diameter_of_node, :node_has_path_sum?, :node_count, :node_leaves

end

bst = BinarySearchTree.new
bst.insert(5)
bst.insert(15)
bst.insert(2)
bst.insert(25)
puts "-----------------"
puts "root value of bst #{bst.root.value}"
puts "----------------- print in order"
bst.print_in_order
puts "----------------- print pre order"
bst.print_pre_order
puts "-----------------"
puts "max depth of BST is #{bst.max_depth}"
puts "-----------------"
puts "min depth of BST is #{bst.min_depth}"
puts "-----------------"
puts "bst is balanced: #{bst.is_balanced?}"
puts "-----------------"
puts "diameter of BST is #{bst.diameter}"
puts "-----------------"
puts "does BST have path sum of 7 #{bst.has_path_sum?(7)}"
puts "-----------------"
puts "does BST have path sum of 9 #{bst.has_path_sum?(9)}"
puts "-----------------"
puts "does BST have path sum of 45 #{bst.has_path_sum?(45)}"
puts "-----------------"
puts "the number of nodes in bst is: #{bst.node_counter}"
puts "-----------------"
puts "the number of leaves in bst is: #{bst.leaf_counter}"
puts "-----------------"
bst2 = BinarySearchTree.new
bst2.insert_recursively(3)
bst2.insert_recursively(1)
bst2.insert_recursively(2)
bst2.insert_recursively(4)
bst2.insert_recursively(5)
puts "root value of bst2 #{bst2.root.value}"
puts "----------------- print in order"
bst2.print_in_order
puts "----------------- print pre order"
bst2.print_pre_order
puts "-----------------"
puts "max depth of BST2 is #{bst2.max_depth}"
puts "-----------------"
puts "min depth of BST2 is #{bst2.min_depth}"
puts "-----------------"
puts "bst2 is balanced: #{bst2.is_balanced?}"
puts "-----------------"
puts "diameter of BST2 is #{bst2.diameter}"
puts "-----------------"
node = BinarySearchTree.process_sorted_array([1, 2, 3, 4, 5])
bst3 = BinarySearchTree.new
bst3.root = node
puts "-----------------"
puts "max depth of BST3 is #{bst3.max_depth}"
puts "-----------------"
puts "min depth of BST3 is #{bst3.min_depth}"
puts "-----------------"
puts "bst3 is balanced: #{bst3.is_balanced?}"
puts "----------------- print in order"
bst3.print_in_order
puts "----------------- print pre order"
bst3.print_pre_order
puts "-----------------"
puts "the number of nodes in bst3 is: #{bst3.node_counter}"
