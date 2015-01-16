class String
	#got this from stackoverflow, interesting, need to disect it more
	def reverse_inplace!
		half_length = self.length / 2
		half_length.times {|i| self[i], self[-i-1] = self[-i-1], self[i] }
	end

end

class StringManupulation

	def self.reverse_using_built_in_method(str)
		str.reverse
	end

	def self.reverse_iteratively(str)
		str_char = str.chars
		length = str.length
		ctr = length/ 2

		#ruby tests to ctr number i need to test up to, thus the - 1 
		for x in 0..ctr - 1
			tmp = str_char[x]
			str_char[x] = str_char[length - 1 - x]
			str_char[length - 1 -x] = tmp
		end

		str_char.join
	end

	def self.reverse_recursively(str)
		if str.nil? || str.empty?
			return str
		end	

		back = reverse_recursively(str.slice!(1, str.length - 1))
		beg = str.slice!(0, 1)

		back + beg
	end

	def self.reverse_recursively_2(s)
		s.size <= 1 ? s : "#{s[-1]}#{reverse_recursively_2(s[0...-1])}"
	end

end

puts "reverse a string using the built in method:  #{StringManupulation.reverse_using_built_in_method("tester")}"
puts "reverse a string iteratively:  #{StringManupulation.reverse_iteratively("tester")}"
#you cant call "tester".reverse_inplace! - that just returns half length
a = "tester"
a.reverse_inplace!
puts "reverse string by reopening a class #{a}"
puts "reverse recursively: #{StringManupulation.reverse_recursively("tester")}"
puts "reverse recursively 2: #{StringManupulation.reverse_recursively_2("tester")}"
