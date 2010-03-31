#!/usr/bin/env ruby
require 'find'

def getPos (val)
	if val == 0
		return 0
	end
	i = 1
	while i <= 10 do
		if val <= (i/10.0) 
			return i
		end
		i = i + 1
	end
	return -1
end

def getIndex(val)
	return (val*11).to_i
end

def getHeader(str)
	str = str.strip
	while str.index(" ") != nil do
		str = str.sub(" ", "_")
	end
	return str.downcase
end
=begin
dirPath   = ARGV[0]
files	  = Array.new
Find.find("#{dirPath}") do |path|
	if FileTest.directory?(path)
		next		
	else
		endIndex   = path.rindex(".")  - 1
		name	   = path[0..endIndex]
		if !files.include?(name)
			files << name
		end
	end
end
=end
file = ARGV[0]
#for file in files do
	f = File.open("#{file}")
	hea_array = Array.new
	while !f.eof do
		hea_array.push(f.gets.chomp.strip)
	end
	f.close

	#process feature for each file
	index = 0
	while index < hea_array.length do
		pos = getPos(index*1.0/(hea_array.length - 1))	
		currHeader = getHeader(hea_array.at(index))
		tmp = hea_array.at(index).split(" ")
		len = tmp.length
		if  len > 3
			len = 3
		end
		firstWord = "null"
		secondWord = "null"
		
		if /[0-9].?/.match(tmp.at(0))
			if len > 2
				firstWord = tmp.at(1).downcase
			end
			if len >=3
				secondWord = tmp.at(2).downcase
			end
		else
			if len > 1
				firstWord = tmp.at(0).downcase
			end
			if len >= 2
				secondWord = tmp.at(1).downcase
			end
		end

		tmpIndex = getIndex(index*1.0/(hea_array.length - 1))
		puts "index=#{index} pos=#{pos}/10 firstWord=#{firstWord} secondWord=#{secondWord}  currHeader=#{currHeader} ?"
		index = index + 1
	end
#end
