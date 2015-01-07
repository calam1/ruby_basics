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

	def depth
		depthOfNode(self.root)	
	end

	def depthOfNode(node)
		if node.nil? 
			return 0
		end

		return [depthOfNode(node.left), depthOfNode(node.right)].max + 1
	end

	def printInOrder
		self.root.printInOrder
	end


end

bst = BinarySearchTree.new
bst.insert(5)
bst.insert(15)
bst.insert(2)
bst.insert(25)

puts bst.root.value
puts "-----------------"
bst.printInOrder
puts "-----------------"
puts bst.depth
