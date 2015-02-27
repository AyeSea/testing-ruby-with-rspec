def caesar_cipher(str, shift_val = 0)
	letters = str.split("")
	shifted_word = []

	letters.each do |letter|
		unless letter.match(/[a-zA-Z]/)
			shifted_word << letter
			next
		end
		
		asc_ii_val = letter.ord
		asc_ii_val += shift_val

		if letter == letter.upcase
			asc_ii_val -= 26 if asc_ii_val > 90
		else
			asc_ii_val -= 26 if asc_ii_val > 122
		end

		shifted_letter = asc_ii_val.chr
		shifted_word << shifted_letter
	end

	shifted_word.join("")
end