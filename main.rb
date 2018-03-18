#!/usr/bin/env ruby
# NoSQL with Redis
# Tyler Radabaugh

require 'redis'
require 'json'

$REDIS = Redis.new

# prints the value associated with the given key if it exists
def find(key)
	if ($REDIS.exists key)
		dog = JSON.parse($REDIS.get(key))
		name = dog[0]
		breed = dog[1]
		age = dog[2]
		color = dog[3]
		puts "#{key} is a #{age} year old, #{color} #{breed}."
	else
		puts "Key #{key}, not found."
	end
end

# Adds the given key and associated value to the cashe
def add(key, name, breed, age, color)
	$REDIS.set key, [name, breed, age, color].to_json
	puts "Added #{key}"
end

# Deletes the given key and associated value from the cashe
def delete(key)
	$REDIS.del(key)
	puts "Deleted #{key}."
end

# updates the value of the given key if the key exists in the cashe
def updateValue(key, name, breed, age, color)
	if (!$REDIS.exists key)
		puts "Cannot update nonexistant key #{key}."
	else
		$REDIS.set key, [name, breed, age, color].to_json
		puts "Updated #{key} to #{name}, #{breed}, #{age}, #{color}."
	end
end

# renames an existing key if the key exists in the cashe
def renameKey(oldKey, newKey)
	if (!$REDIS.exists oldKey)
		puts "Cannot update nonexistant key #{oldKey}."
	else
		$REDIS.rename(oldKey, newKey)
		puts "Renamed #{oldKey} to #{newKey}."
	end
end

class Dog
	def initialize(name, breed, age, color)
		@name = name
		@breed = breed
		@age = age
		@color = color
	end

	def getBreed
		"#{@breed}"
	end

	def getName
		"#{@name}"
	end

	def getAge
		"#{@age}"
	end

	def getColor
		"#{@color}"
	end
end

todd = Dog.new('Todd', 'Beagle', '5', 'Tri-color')

add(todd.getName, todd.getName, todd.getBreed, todd.getAge, todd.getColor)
find(todd.getName)
updateValue(todd.getName, todd.getName, 'Tree Hound', todd.getAge, todd.getColor)
find(todd.getName)
renameKey(todd.getName, "Kyle")
find(todd.getName)
find('Kyle')
delete('Kyle')
