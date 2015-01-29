class InsertionSort

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
