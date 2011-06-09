require File.expand_path(File.join(File.dirname(__FILE__), "mapleseed", "interpreter.rb"))

module Mapleseed
	# loads and interprets Whirl code
	class Base
	
		# initialize the interpreter
		def initialize
			@interpreter = Interpreter.new
		end
		
		# run the given code
		def run(code)
			@interpreter.run(code)
		end
		
		# load code from a file and run it
		def load_file(file_path)
			code = File.open(file_path) { |f| f.read }
			run(code)
		end
		
		# interactive read-evaluate-print loop
		def repl
			puts "'exit' or Ctrl-X leaves the REPL"
			puts "'op' gives information about the operation ring position and value"
			puts "'math' gives information about the math ring position and value"
			puts "'mem' gives information about the current cell of memory"
			puts "'reset' clears the memory and resets the rings"
			while true
				puts ""
				print "mapleseed> "
				input = gets.chomp
				case input
				when "exit", 24.chr
					puts "Exiting"
					break
				when "op"
					puts "Operations Ring:" 
					puts "Position: #{@interpreter.op_ring.position} Value: #{@interpreter.op_ring.value}"
					dir = ""
					@interpreter.op_ring.direction == 1 ? dir = "Clockwise" : dir = "Counter-clockwise"
					puts "Direction: #{dir} Current operation: #{@interpreter.op_ring.commands[@interpreter.op_ring.position].to_s}"
				when "math"
					puts "Math Ring:" 
					puts "Position: #{@interpreter.math_ring.position} Value: #{@interpreter.math_ring.value}"
					dir = ""
					@interpreter.math_ring.direction == 1 ? dir = "Clockwise" : dir = "Counter-clockwise"
					puts "Direction: #{dir} Current operation: #{@interpreter.math_ring.commands[@interpreter.math_ring.position].to_s}"
				when "mem"
					puts "Cell: #{@interpreter.memory_position} Value: #{@interpreter.memory.get(@interpreter.memory_position)}"
				when "reset"
					@interpreter.initialize_environment
				else
					@interpreter.run(input)
				end
			end
		end
	end
end