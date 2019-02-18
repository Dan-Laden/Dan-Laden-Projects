#print "This is a test\nI will do my Rubesty\n"

a = "Hello"
b = "I will do my Rubesty\n"
song = "I will do my Rubesty? :By Shiitaki By Ruby feat. Muse"
fake = "Fállen Angle Yoháne"
s = "The neurotoxin, unlike most poisons, targets the nervous system in such a way that the diaphragm is paralyzed, resulting in suffocation."
t = "TRWRJSX12903CD8446<SEP>SOBSFBU12AB018DBE1<SEP>Frank Sinatra<SEP>Everything Happens To Me"
supertext = "(  [  {  \\  /  _  -  :  \"  `  +  =  *  feat."
superpunc = "?  ¿  !  ¡  .  ;  &  @  %  #  |"
superstop = "a an and by for from in of on or out the to with"
a[1] = ''
n = 0
m = 0
arr = Array.new

print "Enter a word [Enter 'q' to quit]:"
while
  word = gets.chomp
  if word == ""
  elsif word != "q"
    puts "The most common word the follows yours is: "+word
    #generate song titles
  else
    puts "Thank you for using this program"
    break;
  end
  print "Enter a word [Enter 'q' to quit]:"
end

=begin
dog = "Cow"
#dog[/\s/] = ""

rega = Regexp.new("\s?"+dog+"\s")
regb = Regexp.new("\\s?"+dog+"\\s+"+"\\w+")
regc = Regexp.new('\\w+')

string = "Cow likes milk"
puts string[regc]

if rega =~ string

	puts "AAAAAAAAAAAAAAA"
	puts string[regb]
	#follow[rega] = ""
	#puts follow

end

=end
=begin
class Bigram
	attr_reader :word_list, :mcw
	def initialize()
		@word_list = Array.new
		@mcw = ""
	end

	def update_mcw()
		n = 0
		mcv = 0
		index = nil
		while n < @word_list.length
			if mcv < @word_list[n][1]
				mcv = @word_list[n][1]
				index = n
			end
			n += 1
		end
		if index != nil
			@mcw = @word_list[index][0]
		end
	end

	def add_word(word)
		hold = [word, 0]
		@word_list.push(hold)
	end

	def update_val(index)
		@word_list[index][1] += 1
	end

end


bigram = Bigram.new

bigram.add_word("Cows")
bigram.add_word("Love")
bigram.add_word("Milk")

bigram.update_val(1)
bigram.update_val(1)
bigram.update_val(1)

bigram.update_val(2)
bigram.update_val(2)
bigram.update_val(2)
bigram.update_val(2)

bigram.update_mcw()

puts bigram.mcw

bigram.update_val(1)
bigram.update_val(1)
bigram.update_val(1)

bigram.update_mcw()

puts bigram.mcw



x = 0
while x < bigram.length
	if x == bigram.length-1
		if bigram[x][0] == #string
			bigram[x][1] += 1
		else
			bigram.push([#string, 0])
		end
	else
		if bigram[x][0] == #string
			bigram[x][1] += 1
			x = bigram.length
		end
	end
	x += 1
end



puts bigram[3][0]

=end
=begin
#Part 2
arr2 = Array.new

arr2 = supertext.split(" ")

while n != arr2.length
  if arr2.length-1 == n
    rtwo = Regexp.new(arr2[n]+'.*')
  else
    rtwo = Regexp.new('\\'+arr2[n]+'.*')
  end

  if rtwo =~ song
    song[rtwo] = ""
  else
    n += 1
  end
end

#Part 1
rone = Regexp.new('.*<SEP>.*<SEP>.*<SEP>')

#Part 3
arr3 = Array.new

arr3 = superpunc.split(" ")

while m != arr3.length
  begin #This is a try catch because some of the punctuation is considered just chars
    rthree = Regexp.new('\\'+arr3[m])
  rescue RegexpError
    rthree = Regexp.new(arr3[m])
  end
  if rthree =~ song
    song[rthree] = ""
  else
    m += 1
  end
end

print song
print "\n"

#Part 4
holder = fake
#Gets rid of all spaces
while /\s/ =~ holder
  holder[/\s/] = ""
end
#Checks if there are any none english letters
if /(\W)/ =~ holder
  fake = ""
end
#sets fake as the holder if holder is empty
if holder == ""
  fake = holder
end
puts fake

#Part 5
if /[[:upper:]]/ =~ song
  song = song.downcase
end

puts song


#Loop this till user enters terminator
def mcw(song)
  usTitle = gets
  rmcw = Regexp('\s'+usTitle+'\s')
  if rmcw =~ song
    #get word after
    common = ""
    return common
  else
    return ""
  end
end

#stop words
arr4 = Array.new
arr4 = superstop.split(" ")
o = 0

while o != arr4.length
  rfour = Regexp.new('\s'+arr4[o]+'\s')#tested, this is a valid regexp
  if rfour =~ song
    song[rfour] = ""
  else
    o += 1
  end
end


=end
=begin
arr = s.split(/\W+/)
t[rone] = ""

title = t

print arr
print "\n"





print title
print "\n"


while s.length != 1
  n = 1
  print s
  print "\n"
  while s.length != (n-1)
    s[n] = ''
    n = n + 1
  end
end

print s
print "\n"

10.times do
  print b
end

print a[0]
print "\n"

=end
=begin

a = "hello"; a[2]       = 96;    a 	» 	"he`lo"
a = "hello"; a[2, 4]    = "xyz"; a 	» 	"hexyz"
a = "hello"; a[-4, 2]   = "xyz"; a 	» 	"hxyzlo"
a = "hello"; a[2..4]    = "xyz"; a 	» 	"hexyz"
a = "hello"; a[-4..-2]  = "xyz"; a 	» 	"hxyzo"
a = "hello"; a[/[el]+/] = "xyz"; a 	» 	"hxyzo"
a = "hello"; a["l"]     = "xyz"; a 	» 	"hexyzlo"
a = "hello"; a["ll"]    = "xyz"; a 	» 	"hexyzo"
a = "hello"; a["bad"]   = "xyz"; a 	» 	"hello"
a = "hello"; a[2, 0]    = "xyz"; a 	» 	"hexyzllo"

a.collect {|x| x + "!" } 	» 	["a!", "b!", "c!", "d!"]
a 	» 	["a", "b", "c", "d"]

=end
