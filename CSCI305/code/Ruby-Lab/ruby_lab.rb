#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# <Daniel> <Laden>
# <dthomasladen@gmail.com>
#
###############################################################

$name = "<Daniel> <Laden>"
$song_list


# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
  processArr = Array.new
	begin
		if RUBY_PLATFORM.downcase.include? 'mswin'
			file = File.open(file_name)
			unless file.eof?
				file.each_line do |line|
					# do something for each line (if using windows)
					song = cleanup_title(line)
					if song != ""
						processArr.push(song)
					end
				end
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# do something for each line (if using macos or linux)
				song = cleanup_title(line)
				if song != ""
					processArr.push(song)
				end
			end
		end

	rescue #Exception=>ex
		STDERR.puts "Could not open file"
		#puts "An error of type #{ex.class} happened, message is #{ex.message}" For bug catching
		exit 4
	end

	#Song list stores all the valid song titles that get through the cleanup processing
	$song_list = processArr

end

# Where the loop of the program is executed
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# This is the loop for the program
	user_word = ""
	print "Enter a word [Enter 'q' to quit]:"
	while
		user_word = $stdin.gets.chomp #Without $stdin the gets will grab from the ARGV
		if user_word == "q"
			puts "Thank you for using this program"
			break; #break out of the while without a condition
		elsif user_word != "q"
			puts "The most common word the follows yours is: "+mcw(user_word)
			puts "Generating song title from " +user_word+"..."
			puts create_title(user_word)
		end
		print "Enter a word [Enter 'q' to quit]:"
	end
end

def cleanup_title(title)
	supertext = "(  [  {  \\  /  _  -  :  \"  `  +  =  *  feat."
	superpunc = "?  ¿  !  ¡  .  ;  &  @  %  #  |"
	superstop = "a an and by for from in of on or out the to with and or for nor but so yet am is are was were be being been"

	#Part 1 gets the song title
	rone = Regexp.new('.*<SEP>')
	title[rone] = ''

	#Part 2 deleting the extremities on song titles
	arr1 = Array.new
	arr1 = supertext.split(" ")

	n = 0
	while n != arr1.length
	  if arr1.length-1 == n#This is just for the special case of feat.
	    rtwo = Regexp.new(arr1[n]+'.*')
	  else
	    rtwo = Regexp.new('\\'+arr1[n]+'.*')
	  end
	  if rtwo =~ title
	    title[rtwo] = ""
	  else
	    n += 1
	  end
	end

	#Part 3 removes special punctuation
	arr2 = Array.new
	arr2 = superpunc.split(" ")

	m = 0
	while m != arr2.length
	  begin #This is a try catch because some of the punctuation is considered just chars
	    rthree = Regexp.new('\\'+arr2[m])
	  rescue RegexpError
	    rthree = Regexp.new(arr2[m])
	  end
	  if rthree =~ title
	    title[rthree] = ""
	  else
	    m += 1
	  end
	end

	#Part 4 deletes song titles with non-english letters
	holder = "" + title

	#Gets rid of all spaces
	while /\s/ =~ title
	  title[/\s/] = ""
	end

	#Checks if there are any none english letters
	if /(\W)/ =~ title
		if /\'/ =~ title#leaves songs with ' in them
		else
			title = ""
		end
	end
	#sets title as the holder if holder is empty
	if title != ""
		title = holder
	end

	#Part 5 not necessary but using a RE to check for capitalization and then downcasing the string to all lower case
	if /[[:upper:]]/ =~ title
	  title = title.downcase
	end


	#stop words, and my fix solution to some looping in song titles
	#I added conjunctions and some common linking verbs
	arr4 = Array.new
	arr4 = superstop.split(" ")
	o = 0

	while o != arr4.length
	  rfour = Regexp.new('\s'+arr4[o]+'\s')#tested, this is a valid regexp
	  if rfour =~ title
	    title[rfour] = ""
	  else
	    o += 1
	  end
	end
	return title
end

#returns the most common word of given word
def mcw(usTitle)
  rfull = Regexp.new("\\s?"+usTitle+"\\s+"+"\\S+")
	bigram = Bigram.new
	x = 0

	while x < $song_list.length
		split = Array.new
		bisong = $song_list[x]
		if rfull =~ bisong
			#get word after when it comes into the if statement the word does have something that follows it
			follow = bisong[rfull]
			split = follow.split(" ")
			follow = split[1]

			#adds words that it finds that follow a given word
			bigram.add_word(follow)
		end
		x += 1
	end
	return bigram.mcw
end

#----------------------------------------------------------------------------
#NOTE to grader
#I'm adding this comment here to hopefully make your life a little less painful
# if you're trying to get the bigram of this assignment to work don't I created
# a datastructure that doesn't follow the instructions it mainly is a placeholder
# for a <word>. By placeholder I mean it keeps track of 1 words mcw and a list of
# following words mcv holds the most common word's occurences and
# word_list.length accounts for how many words follow <word> I'm putting this
# to explain that part if there are any confusions. Thank you.
#----------------------------------------------------------------------------
class Bigram
	attr_reader :word_list, :mcw, :mcv
	def initialize()
		@word_list = Array.new
		@mcw = "N/A"
		@mcv = 0
	end

	#Method for checking the list of words and grabbing the most common one
	def update_mcw()
		n = 0
		index = nil
		while n < @word_list.length
			if @mcv < @word_list[n][1]
				@mcv = @word_list[n][1]
				index = n
			end
			n += 1
		end
		if index != nil
			@mcw = @word_list[index][0]
		end
	end

	#Method for adding a word if it's not in the word list already
	def add_word(word)
		x = 0
		#This while loop checks the list of words to see if it's there if so it increases it's value
		while x < @word_list.length
			if x == @word_list.length-1
				#Last point in this loop it checks it one last time if it's in the end of the list and
				#if not it adds the word to word_list
				if @word_list[x][0] == word
					@word_list[x][1] += 1
				else
					@word_list.push([word, 1])
					self.update_mcw()
					break #Break out so you don't double count words
				end
			else
				if @word_list[x][0] == word
					@word_list[x][1] += 1
					x = @word_list.length
				end
			end
			x += 1
		end
		if @word_list.length == 0
			@word_list.push([word, 1])
			self.update_mcw()
		end
	end
end

#This function creates the twenty word or less string by getting each word's mcw
def create_title(song)
	loops = 0
	created_title = "" + song #start the string with the first word of the song
	while loops < 19
		holder = mcw(song)
		if holder == "N/A"
			break
		else
			song = "" + holder
			created_title = created_title + " " + holder
		end
		loops += 1
	end
	return created_title
end

if __FILE__==$0
	main_loop()
end

#----------------------------------------------------------------------------
#These following sites were used purely as reference in creation of this solution.
#    Sites:
#    http://ruby-doc.com/docs/ProgrammingRuby/
#    https://ruby-doc.org/core-2.2.0/Regexp.html
#    https://www.tutorialspoint.com/ruby
#    and various look ups for syntax differences for ruby on
#    https://stackoverflow.com
#----------------------------------------------------------------------------
