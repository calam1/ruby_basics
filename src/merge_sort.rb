class MergeSort
#An example of merge sort. First divide the list into the smallest unit (1 element), then compare each element with the adjacent list to sort and merge the two adjacent lists. Finally all the elements are sorted and merged.
	#recursive merge sort
	def self.sort(arr)
		return arr if arr.length <= 1

		mid = arr.length/2
		left = arr[0, mid]
		right = arr[mid, arr.length]
		merge(sort(left), sort(right))
	end

	def self.merge(left, right)
		sorted = []
		until left.empty? or right.empty?
			if left.first <= right.first
				sorted << left.shift
			else
				sorted << right.shift
			end
		end
		sorted.concat(left).concat(right)
	end

	#even better recursive solution
	#https://gist.github.com/reinh/3955850
	def self.recursive_sort(arr)
		size = arr.size
		return arr if size < 2
		mid = size/2

		left = arr[0,mid]
	   	right = arr[mid, size]

		merge(recursive_sort(left), recursive_sort(right))
	end

	#iterative merge sort
	#https://gist.github.com/reinh/3955850
	def self.iterative_sort(arr)
		arr = arr.map{|i| [i]}
		arr = pairs(arr) while arr.size > 1
		arr.flatten
	end

	def self.pairs(arr)
		return arr if arr.size < 2

		#destructuring of arr 
		x, y, *xs = arr

		[iterative_merge(x,y)] + pairs(xs)
	end

	def self.iterative_merge(xs, ys)
		return ys if xs.empty?
		return xs if ys.empty?

		x, *xs_ = xs
		y, *ys_ = ys

		if x < y
			[x] + iterative_merge(xs_, ys)
		else
			[y] + iterative_merge(ys_, xs)
		end
	end

end

puts "recursive merge sort array [3, 2, 6, 1, 0, 9] #{MergeSort.sort([3, 2, 6, 1, 0, 9])}"
puts "recursive merge sort array [3, 2, 6, 1, 0, 9] #{MergeSort.recursive_sort([3, 2, 6, 1, 0, 9])}"
puts "iterative merge sort array [3, 2, 6, 1, 0, 9] #{MergeSort.iterative_sort([3, 2, 6, 1, 0, 9])}"
