module Menu
	def menu
		puts "Welcome and select menu option
		1) add
		2) show
		3) delete
		4) update
		5) write to a file
		6) read from a file
		7) toggle status
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
		all_tasks.each_with_index do |task, index| 
			index +=1
			puts "#{index}: #{task}"
		end
	end

	def delete(task_number)
		if task_number <1 || task_number > all_tasks.length
			raise "No such task number."
		end
		all_tasks.delete_at(task_number - 1)
	end

	def update(task_number, task)
		if task_number <1 || task_number > all_tasks.length
			raise "No such task number"
		end
		all_tasks[task_number -1] = task
	end

	def write_to_file(filename)
		machine_file = @all_tasks.map(&:to_s).join("\n")
		IO.write(filename, machine_file)
	end

	def read_from_file(filename)
		IO.readlines(filename).each do |line|
			status, *description = line.split(":")
			status = status.include?("X")	
			add(Task.new(description.join(":").strip, status))
		end
	end

	def toggle(task_number)
		if task_number <1 || task_number > all_tasks.length
			raise "No such task number"
		end
		all_tasks[task_number -1].toggle_status
	end

end

class Task #task class
	attr_accessor :description
	attr_accessor :status
	def initialize(description, status = false)
		@description =description
		@status =status
	end

	def to_s
		"#{represent_status} : #{description}"
	end

	def completed?
		status
	end

	def toggle_status
		@status = !completed?
	end

	private

	def represent_status
		"#{completed? ? '[X]' : '[ ]'}"
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
			begin
				my_list.show
				my_list.delete(prompt("What do you want to delete?").to_i)
			rescue
				puts "that task index does not exist!" 
			end
		when "4"
			begin 
				my_list.show
				my_list.update(prompt("What do you want to update?").to_i, Task.new(prompt("What is the new task?")))
			rescue
				puts "that task index does not exist!"
			end
		when "5"
			my_list.write_to_file(prompt("What is the filename to write to?"))
		when "6"
			begin
				my_list.read_from_file(prompt("What is the filename to read from?"))
			rescue Errno::ENOENT
				puts "That filename does not exist, try again."
			end
		when "7"
			begin 
				my_list.show
				my_list.toggle(prompt("Which task status do you want to change?").to_i)
			rescue
				puts "that task index does not exist!"
			end
		else
			puts "Sorry, I did not understand"
		end
	prompt("Press enter to continue", " ")
	end
	puts "Outro-Thanks for using the menu system"

end	