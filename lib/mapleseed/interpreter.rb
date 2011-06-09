require File.expand_path(File.join(File.dirname(__FILE__), "memory.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "ring.rb"))

module Mapleseed
	#interprets Whirl code
	class Interpreter
		attr_reader :memory
		attr_accessor :memory_position, :program_position,
							:input_stream, :output_stream
		
		# initializes the interpreter
		def initialize
			@memory = Memory.new
			@input_stream = $stdin
			@output_stream = $stdout
			initialize_environment
		end
		
		def initialize_environment
			@memory.clear
			@op_ring = OpRing.new(self)
			@math_ring = MathRing.new(self)
			@memory_position = 0
			@program_position = 0
			@code = ""
			@execute = false
			@current_ring = @op_ring
		end
		
		# run a given piece of code
		def run(code)
			@code += code.delete "^01"
			catch :quit do
				evaluate_code
			end
		end
		
		# evaluate each instruction in the current code
		def evaluate_code
			while ((0 <= @program_position) and (@program_position < @code.length))
				evaluate_instruction(@code[@program_position])
			end
		end
		
		# evaluate an individual instruction
		def evaluate_instruction(instruction)
			if instruction == "0"
				@current_ring.switch_direction
				if @execute
					@current_ring.execute
					@current_ring == @op_ring ? @current_ring = @math_ring : @current_ring = @op_ring
					@execute = false
				else
					@execute = true
				end
			elsif instruction == "1"
				@current_ring.rotate
				@execute = false
			end
			@program_position += 1
		end
	end
end