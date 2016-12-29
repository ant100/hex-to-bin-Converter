# TO DO: validate that correct format is entered (only 0's and 1's for binary, hex format)

def main
	puts "#############################"
	puts "Welcome to HEX/BIN converter!"
	puts "#############################"
	puts ""
	puts "Hex to bin..........[1]"
	puts "Bin to hex..........[2]"
	puts "Exit................[3]"
	type = gets().to_i
	call_to_converter(type)
end

## handle menu ##
def call_to_converter(type)
	clear_screen
	if type == 1
		puts "Please enter a number in hexadecimal"
		num = gets().chomp()
		puts "The number is: " + convert_to_bin(num)
		puts "Try again? [Y/N]"
		answer = gets().chomp()
		if answer.upcase == "Y"
			call_to_converter(1)
		else
			puts "Do you want to exit the program? [Y/N]"
			quit = gets().chomp()
			if quit.upcase == "Y"
				exit
			else
				clear_screen
				main
			end
		end
	elsif type == 2
		puts "Please enter a number in binary"
		num = gets().to_i
		puts "The number is: " + convert_to_hex(num)
		puts "Try again? [Y/N]"
		answer = gets().chomp()
		if answer.upcase == "Y"
			call_to_converter(2)
		else
			puts "Do you want to exit the program? [Y/N]"
			quit = gets().chomp()
			if quit.upcase == "Y"
				exit
			else
				clear_screen
				main
			end
		end
	elsif type == 3
		exit
	else
		puts "Wrong option"
		main
	end
end

## core ##
def convert_to_hex(binary)
	# first we get the value of each group of 4 in binary and store it in an array
	hex_array = []
	while binary > 0
		# reset on each iteration
		counter = 0 
		pow = 0
		total = 0

		while counter < 4
			counter += 1
			digit = binary % 10
			total += digit * 2 ** pow
			pow += 1
			if counter == 4 # end of group, time to safe into array
				hex_array.push(total)
			end
			binary /= 10
		end
	end

	# now it's time to convert each value stored in the array to hex
	# note: I don't do it before because even though ruby allows for arrays of different types, I wanted to keep hex_array as an int array
	final = ""
	array_len = hex_array.length - 1
	
	for i in 0..array_len
		num = hex_array[i]
		
		if num <= 9
			final.prepend(num.to_s)
		else
			case num
				when 10
					final.prepend('A')
				when 11
					final.prepend('B')
				when 12
					final.prepend('C')
				when 13
					final.prepend('D')
				when 14
					final.prepend('E')
				when 15
					final.prepend('F')
			end
		end
	end
	
	final.prepend('x0')
	return final
end

def convert_to_bin(hex)
	bin = ""
	# hex has characters so we treat it as a string
	hex_len = hex.length-1
	for i in 0..hex_len
		case hex[i].upcase
			when 'A'
				bin += aux_bin_converter(10)
			when 'B'
				bin += aux_bin_converter(11)
			when 'C'
				bin += aux_bin_converter(12)
			when 'D'
				bin += aux_bin_converter(13)
			when 'E'
				bin += aux_bin_converter(14)
			when 'F'
				bin += aux_bin_converter(15)
			else # any other case it should be numeric
				bin += aux_bin_converter(hex[i].to_i)
		end
	end 
	return bin
end

def aux_bin_converter(num)
	final = ""
	num = num.to_i
	while num > 0
		if num % 2 == 1
			final.prepend("1")
			num = (num - 1) / 2
		else
			final.prepend("0")
			num = num / 2
		end
	end
	# check that final has 4 characters, else complete with 0's
	if final.length != 4
		while final.length < 4
			final.prepend("0")
		end
	end
	return final
end

## tools ##
def clear_screen
	system "cls"
end

main