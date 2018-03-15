#!/usr/bin/env ruby
# NoSQL with Redis
# Tyler Radabaugh

require 'redis'

$REDIS = Redis.new

# prints the value associated with the given key if it exists
def find(key)
	if ($REDIS.exists key)
		value = $REDIS.get(key)
		puts "#{key} is a #{value}."
	else
		puts "Key #{key}, not found."
	end
end

# Adds the given key and associated value to the cashe
def add(key, value)
	$REDIS.set(key, value)
	puts "Added #{key}"
end

# Deletes the given key and associated value from the cashe
def delete(key)
	$REDIS.del(key)
	puts "Deleted #{key}."
end

# updates the value of the given key if the key exists in the cashe
def updateValue(key, value)
	if (!$REDIS.exists key)
		puts "Cannot update nonexistant key #{key}."
	else
		$REDIS.set(key, value)
		puts "Updated #{key} to #{value}."
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

	def pedigree
		"#{@breed}"
	end

	def name
		"#{@name}"
	end

	def age
		"#{@age}"
	end

	def color
		"#{@color}"
	end
end

todd = Dog.new('Todd', 'Beagle', '5', 'Tri-color')

add(todd.name, todd.pedigree)
find(todd.name)
updateValue(todd.name, 'Cat')
find(todd.name)
renameKey(todd.name, "Kyle")
find(todd.name)
find('Kyle')
delete('Kyle')
