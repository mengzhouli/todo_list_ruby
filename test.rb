module Menu
	def menu
		puts "Welcome and select menu option
		1) add
		2) show
		3) write to a file
		4) read from a file
		Q) quit"
	end

	def show
		menu
	end

	def prompt (message='What would you like to do?', symbol=':>')
		puts message
		puts symbol
		gets.chomp
	end
end

class List #list class
	
	attr_accessor :all_tasks
	
	def initialize
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

	def read_from_file(filename)
		IO.read(filename).each do |line|
			add(Task.new(line.chomp))
		end
	end

end

class Task #task class
	attr_accessor :description
	def initialize(description)
		@description =description
	end

	def to_s(description)
		description
	end

end

if __FILE__ == $PROGRAM_NAME
	include Menu

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
		when "4"
			begin
				my_list.read_from_file(Task.new(prompt("What is the filename to read from?")))
			rescue Errno::ENOENT
				puts "That filename does not exist, try again."
			end
		else
			puts "Sorry, I did not understand"
		end
	prompt("Press enter to continue", " ")
	end
	puts "Outro-Thanks for using the menu system"

end	