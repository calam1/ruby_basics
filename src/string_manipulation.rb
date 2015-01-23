class String
	#got this from stackoverflow, interesting, need to disect it more
	def reverse_inplace!
		half_length = self.length / 2
		half_length.times {|i| self[i], self[-i-1] = self[-i-1], self[i] }
	end

end

class StringManipulation

	def self.reverse_using_built_in_method(str)
		str.reverse
	end

	def self.reverse_iteratively(str)
		str_char = str.chars
		length = str.length
		ctr = length/ 2

		for x in 0...ctr
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

		#back = reverse_recursively(str.slice(1, str.length - 1))
		back = reverse_recursively(str[1..-1])#.. is inclusive of the last 
		#beg = str.slice(0, 1)
		beg = str[0]

		back + beg
	end

	#very similar to above - just swapped and the commented line is a very short syntactic version
	def self.reverse_recursively_2(s)
		#s.size <= 1 ? s : "#{s[-1]}#{reverse_recursively_2(s[0...-1])}"
		if s.size <= 1 
	   		return s  
		end
			prefix = "#{reverse_recursively_2(s[0...-1])}"#... not inclusive of the last
			suffix =  "#{s[-1]}"

			suffix + prefix
	end

	def self.palindrome?(str)
		if str.nil? || str.empty?
			return true 
		end
		
		if str[0] == str[-1]
			palindrome?(str[1...-1])
		else
			return false
		end
	end

	def self.first_non_repeating_character(str)
		chars = str.chars
		length = str.length

		for x in 0...length
			ctr = 0
			for y in 0...length
				if chars[x] == chars[y]
					ctr = ctr + 1
				end
			end	
			if ctr == 1
				return chars[x]
			end
		end
	end

	def self.delete_provided_letters(str, delete_str)
		chars_str = str.chars
		chars_delete_str = delete_str.chars
		chars_length = str.length
		chars_delete_length = delete_str.length
		new_chars = Array.new

		for x in 0...chars_length
			delete_it = false
			for y in 0...chars_delete_length
				if chars_str[x] == chars_delete_str[y]
					delete_it = true	
				end		
			end

			new_chars.push(chars_str[x]) if !delete_it
		end

		new_chars.join
	end

	#delete provided letters
	#delete provided letters in place
	#build number from string
	#delete duplicate letters
	#is rotated string
	#return the longeset palindrome

end

puts "reverse a string using the built in method:  #{StringManipulation.reverse_using_built_in_method("tester")}"
puts "reverse a string iteratively:  #{StringManipulation.reverse_iteratively("tester")}"
#you cant call "tester".reverse_inplace! - that just returns half length
a = "tester"
a.reverse_inplace!
puts "reverse string by reopening a class #{a}"
puts "reverse recursively: #{StringManipulation.reverse_recursively("tester")}"
puts "reverse recursively 2: #{StringManipulation.reverse_recursively_2("tester")}"
puts "palindrome? should be false: #{StringManipulation.palindrome?("tester")}"
puts "palindrome? should be true: #{StringManipulation.palindrome?("racecar")}"
puts "first nonrepeating character in string should be z and it is: #{StringManipulation.first_non_repeating_character("tfttfzaab")}"
puts "delete provided chars from string: #{StringManipulation.delete_provided_letters("christopher", "cr")}"
