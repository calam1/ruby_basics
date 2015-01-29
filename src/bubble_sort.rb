class BubbleSort

	def self.sort(arr)
		length = arr.length

		for i in 0...length
			for j in 0...length
				if (j > i)
					if arr[i] > arr[j]
						temp = arr[i]
						arr[i] = arr[j]
						arr[j] = temp
					end
				end
			end
		end

		arr
	end

end

puts "bubble sort of array: #{BubbleSort.sort([1, 9, 4, 6, 3])}"
