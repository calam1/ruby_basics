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
				self.left = Node.new(value)
			elsif value > self.value
				puts "value to insert is greater than node value"
				self.right = Node.new(value)
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

	def printInOrder
		self.root.printInOrder
	end
end

bst = BinarySearchTree.new
bst.insert(5)
bst.insert(15)

puts bst.root.value
puts "-----------------"
bst.printInOrder
