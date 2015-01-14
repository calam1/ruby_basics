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

	def delete(value, node)
		if value < self.value
			if (left.nil?)
				return false
			else
				return left.delete(value, self)
			end
		elsif value > self.value
			if (right.nil?)
				return false
			else
				return right.delete(value, self)
			end
		else
			if left.nil? && right.nil?
				self.value = right.find_minimum()
				return delete(self.value, self)
			else
				if node.left == self
					node.left = left.nil?  ? right : left
				end	
				if node.right == self
					node.right = right.nil? ? left : right
				end	
			end
		end
	end

	def find_minimum()
		if !left.nil?
			left.find_minimum
		end

		return node.value
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
	attr_accessor :root, :max

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

	def breadth_of_tree(node)
		queue = Queue.new

		queue.push(node)

		while !queue.empty?
			temp_node = queue.pop
			puts temp_node.value

			if !temp_node.left.nil?
				queue.push(temp_node.left)
			end

			if !temp_node.right.nil?
				queue.push(temp_node.right)
			end
		end
	end

	def breadth
		breadth_of_tree(self.root)
	end

	def find(value, node)
		if node.nil?
			return false
		end

		if value == node.value
			return true
		end

		if value < node.value
			return find(value, node.left)
		end

		if value > node.value
			return find(value, node.right)
		end

		return false
	end

	def find_value(value)
		return find(value, self.root)
	end

	def lca(node, node_1, node_2)
		if node.nil?
			return false
		end

		if node_1.value < node.value && node_2.value < node.value
			return lca(node.left, node_1, node_2)
		end

		if node_1.value > node.value && node_2.value > node.value
			return lca(node.right, node_1, node_2)
		end

		return node.value

	end

	def lowest_common_ancestor(node_1, node_2)
		return lca(self.root, node_1, node_2)
	end

	def put_each_value_per_level_in_array(node, base_array, level)
		if !node.nil?
			if (level >= base_array.size)
				base_array.push(Array.new)
			end

			base_array.at(level).push(node.value)

			put_each_value_per_level_in_array(node.left, base_array, level + 1)
			put_each_value_per_level_in_array(node.right, base_array, level + 1)
		end

		return base_array;
	end

	def place_each_node_value_for_each_level_in_own_array
		base_array =  Array.new
		put_each_value_per_level_in_array(self.root, base_array, 0)
	end

	def self.nodes_equal?(node_a, node_b)
		if node_a.nil? && node_b.nil?
			return true
		end

		if node_a.nil? || node_b.nil?
			return false
		end

		return node_a.value == node_b.value  &&
			nodes_equal?(node_a.left, node_b.left) &&
			nodes_equal?(node_a.right, node_b.right)
	end

	def self.is_subtree?(node_a, node_b)
		if node_b.nil?
			return true
		end

		if node_a.nil?
			return false
		end

		if nodes_equal?(node_a, node_b)
			return true
		end

		return is_subtree?(node_a.left, node_b) || self.is_subtree?(node_a.right, node_b)

	end

	def max_sum
		max = self.root.value
		return max_sum_node(self.root)
	end

	def max_sum_node(node)
		if node.nil?
			return 0
		end

		left = max_sum_node(node.left)
		right = max_sum_node(node.right)

		max = node.value + [left, right].max
		return max
	end

	def delete(value)
		return self.root.delete(value, nil)
	end

	def print_in_order
		self.root.print_in_order
	end

	def print_pre_order
		self.root.print_pre_order
	end

	private :insert_value_recursively, :max_depth_of_node, :min_depth_of_node, :diameter_of_node, :node_has_path_sum?, :node_count, :node_leaves, :breadth_of_tree, :find, :lca, :put_each_value_per_level_in_array

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
puts "breadth of bst is -----------------"
bst.breadth
puts "-----------------"
bst2 = BinarySearchTree.new
bst2.insert_recursively(3)
bst2.insert_recursively(19)
bst2.insert_recursively(2)
bst2.insert_recursively(46)
bst2.insert_recursively(5)
bst2.insert_recursively(55)
bst2.insert_recursively(15)
bst2.insert_recursively(59)
bst2.insert_recursively(1)
bst2.insert_recursively(75)
puts "breadth of bst2 is -----------------"
bst2.breadth
puts "-----------------"
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
puts "find value 59 in bst2, does it exist? #{bst2.find_value(59)}"
puts "find value 51 in bst2, does it exist? #{bst2.find_value(51)}"
puts "-----------------"
node_1 = Node.new(15)
node_2 = Node.new(55)
puts "is the lowest common ancestor 19 for node 15 and 55 #{bst2.lowest_common_ancestor(node_1, node_2)}"
node_1 = Node.new(75)
node_2 = Node.new(55)
puts "is the lowest common ancestor 55 for node 55 and 75 #{bst2.lowest_common_ancestor(node_1, node_2)}"
node_1 = Node.new(75)
node_2 = Node.new(1)
puts "is the lowest common ancestor 3 for node 1 and 75 #{bst2.lowest_common_ancestor(node_1, node_2)}"
puts "-----------------"
puts "put each level of bst2 in own array -----------------"
return_array = bst2.place_each_node_value_for_each_level_in_own_array
return_array.each do |array|
	puts array
	puts "-------"
end
puts "place_each_node_value_for_each_level_in_own_array return value #{return_array}"
puts "delete bst2 value test and print the tree --------------"
bst2.delete(2)
bst2.print_in_order
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
puts "breadth of bst3 is-----------------"
bst3.breadth
puts "bst4 values -----------------"
bst4 = BinarySearchTree.new
bst4.insert_recursively(8);
bst4.insert_recursively(15);
bst4.insert_recursively(5);
bst4.insert_recursively(7);
bst4.insert_recursively(1);
bst4.insert_recursively(12);
bst4.insert_recursively(3);
bst4.print_in_order
puts "bst5 values -----------------"
bst5 = BinarySearchTree.new       
bst5.insert_recursively(5);
bst5.insert_recursively(7);
bst5.insert_recursively(1);
bst5.insert_recursively(3);
bst5.print_in_order
puts "-----------------"
puts "Is bst5 a subtree of bst4?  Should be true: #{BinarySearchTree.is_subtree?(bst4.root, bst5.root)}"
puts "bst6 values -----------------"
bst6 = BinarySearchTree.new
bst6.insert_recursively(8);
bst6.insert_recursively(15);
bst6.insert_recursively(5);
bst6.insert_recursively(7);
bst6.insert_recursively(1);
bst6.insert_recursively(12);
bst6.insert_recursively(3);
bst6.print_in_order
puts "bst7 values -----------------"
bst7 = BinarySearchTree.new
bst7.insert_recursively(18);
bst7.insert_recursively(1);
bst7.insert_recursively(51);
bst7.insert_recursively(13);
bst7.insert_recursively(9);
bst7.print_in_order
puts "Is bst7 a subtree of bst6?  Should be false: #{BinarySearchTree.is_subtree?(bst6.root, bst7.root)}"
puts "-----------------"
puts "The max sum of bst6 is #{bst6.max_sum}"
puts "The max sum of bst7 is #{bst7.max_sum}"
