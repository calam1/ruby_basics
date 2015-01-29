class InsertionSort
#Insertion sort is a simple sorting algorithm that builds the final sorted array (or list) one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort. 
	def self.sort(arr)
		for i in 1...arr.length
			key = arr[i]
			j = i
			while j > 0 && key < arr[j - 1]
				arr[j] = arr[j - 1]
				j -= 1
			end	

			arr[j] = key
		end

		arr
	end
end

puts "insertions sort: #{InsertionSort.sort([5, 1, 3, 2, 9])}"
