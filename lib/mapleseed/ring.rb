module Mapleseed
	# base class for whirl command rings
	class Ring
		
		# initialize the ring
		def initialize(interpreter)
			@position = 0
			@value = 0
			@direction = 1
			@commands = []
			@interpreter = interpreter
		end

		# change the direction of the ring
		def switch_direction
			@direction *= -1
		end
		
		# rotate the ring in the given direction
		def rotate
			@position += @direction
			if @position == @commands.length
				@position = 0
			elsif @position == -1
				@position = @commands.length - 1
			end
		end
		
		def execute
			if @position < @commands.length
				send @commands[@position]
			end
		end
	end
	
	# command ring for whirl operations
	class OpRing < Ring
		
		# initialize commands for operation ring
		def initialize(interpreter)
			super(interpreter)
			@commands = [:noop, :exit, :one, :zero, :load, :store, :p_add, :d_add, :logic, :if, :int_io, :asc_io]
		end
		
		# do nothing
		def noop
			#...
		end
		
		# exit the program
		def exit
			throw :quit
		end
		
		# set the ring value to 1
		def one
			@value = 1
		end
		
		# set the ring value to 0
		def zero
			@value = 0
		end
		
		# set the ring value to the current memory value
		def load
			@value = @interpreter.memory.get(@interpreter.memory_position)
		end
		
		# set the current value in memory to the ring value
		def store
			@interpreter.memory.set(@interpreter.memory_position, @value)
		end
		
		# change location in the program
		def p_add
			@interpreter.program_position += @value - 1
			if @interpreter.program_position < 0
				@interpreter.program_position = 0
			end
		end
		
		# change location in memory
		def d_add
			@interpreter.memory_position += @value
		end
		
		# logical AND
		def logic
			if @interpreter.memory.get(@interpreter.memory_position) != 0 and @value != 0
				@value = 1
			else
				@value = 0
			end
		end
		
		# if value in memory is not 0, add ring value to program position
		def if
			if @interpreter.memory.get(@interpreter.memory_position) != 0
				p_add
			end
		end
		
		# if ring value is 0, set memory value to integer input, otherwise
		# print memory value as an integer
		def int_io
			if @value == 0
				str = @interpreter.input_stream.gets.chomp
				@interpreter.memory.set(@interpreter.memory_position, str.to_i)
			else
				@interpreter.output_stream.print @interpreter.memory.get(@interpreter.memory_position)
			end
		end
		
		# if ring value is 0, set memory value to character input, otherwise
		# print memory value as an character
		def asc_io
			if @value == 0
				str = @interpreter.input_stream.getc
				@interpreter.memory.set(@interpreter.memory_position, str)
			else
				@interpreter.output_stream.putc @interpreter.memory.get(@interpreter.memory_position)
			end
		end
	end
	
	# command ring for whirl math operations
	class MathRing < Ring
		
		# initialize commands for math ring
		def initialize(interpreter)
			super(interpreter)
			@commands = [:noop, :load, :store, :add, :mult, :div, :zero, :lt, :gt, :equal, :not, :neg]
		end
		
		# do nothing
		def noop
			#...
		end
		
		# set the ring value to the current memory value
		def load
			@value = @interpreter.memory.get(@interpreter.memory_position)
		end
		
		# set the current value in memory to the ring value
		def store
			@interpreter.memory.set(@interpreter.memory_position, @value)
		end
		
		# set ring value += memory value
		def add
			@value += @interpreter.memory.get(@interpreter.memory_position)
		end
		
		# set ring value *= memory value
		def mult
			@value *= @interpreter.memory.get(@interpreter.memory_position)
		end
		
		# set ring value /= memory value
		def div
			@value /= @interpreter.memory.get(@interpreter.memory_position)
		end
		
		# set ring value to 0
		def zero
			@value = 0
		end
		
		# if ring value is less than memory value, set value to 1, otherwise 0
		def lt
			if @value < @interpreter.memory.get(@interpreter.memory_position) 
				@value = 1
			else
				@value = 0
			end
		end
		
		# if ring value is greater than memory value, set value to 1, otherwise 0
		def gt
			if @value > @interpreter.memory.get(@interpreter.memory_position) 
				@value = 1
			else
				@value = 0
			end
		end
		
		# if ring value is equal to memory value, set value to 1, otherwise 0
		def equal
			if @value == @interpreter.memory.get(@interpreter.memory_position) 
				@value = 1
			else
				@value = 0
			end
		end
		
		# if ring value is not 0, set value to 1, otherwise 0
		def not
			if @value == 0
				@value = 1
			else
				@value = 0
			end
		end
		
		# inverse ring value
		def neg
			@value *= -1
		end
	end
end