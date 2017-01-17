module Menu
	def self.menu
		puts "Welcome and select menu option
		1) add
		2) show
		3) write to a file
		Q) quit"
	end

	def self.show
		menu
	end
end

module Promptable
	def prompt (message='What would you like to do?', symbol=':>')
		puts message
		puts symbol
		gets.chomp
	end
end



class List #list class
	
	attr_accessor :all_tasks
	
	def initialize ()
		@all_tasks = []
	end
	
	def add (task)
		@all_tasks << task
	end

	def show
		all_tasks.each do |task| puts task.description end
	end
	
	def to_s(description)
		puts description
	end

	def write_to_file(filename)
		IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
	end

end

class Task #task class
	attr_accessor :description
	def initialize(description)
		@description =description
	end

end

if __FILE__ == $PROGRAM_NAME
	
	include Promptable

	my_list = List.new
	puts "Please choose from the following list of options:"
	until ['q'].include?(user_input = prompt(Menu.show).downcase)
		case user_input
		when "1"
			my_list.add(Task.new(prompt("What is the task?")))
		when "2"
			my_list.show
		when "3"
			my_list.write_to_file(Task.new(prompt("What is the filename to write to?")))
		else
			puts "Sorry, I did not understand"
		end
		prompt("Press enter to continue", " ")
	end
	puts "Outro-Thanks for using the menu system"
end	

