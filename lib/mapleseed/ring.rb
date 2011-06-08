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
			if @position == 12
				@position = 0
			elsif @position == -1
				@position = 11
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
		end
		
		# exit the program
		def exit
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
			pos = 0
			if @value > 0
				pos = @value - 1
			end
			@interpreter.program_position = pos
		end
		
		# change location in memory
		def d_add
			pos = 0
			if @value > 0
				pos = @value
			end
			@interpreter.memory_position = pos
		end
		
		# logical AND
		def logic
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
			else
			end
		end
		
		# if ring value is 0, set memory value to character input, otherwise
		# print memory value as an character
		def asc_io
			if @value == 0
			else
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
		end
		
		# set the ring value to the current memory value
		def load
		end
		
		# set the current value in memory to the ring value
		def store
		end
		
		# set ring value += memory value
		def add
		end
		
		# set ring value *= memory value
		def mult
		end
		
		# set ring value /= memory value
		def div
		end
		
		# set ring value to 0
		def zero
		end
		
		# if ring value is less than memory value, set value to 1, otherwise 0
		def lt
		end
		
		# if ring value is greater than memory value, set value to 1, otherwise 0
		def gt
		end
		
		# if ring value is equal to memory value, set value to 1, otherwise 0
		def equal
		end
		
		# if ring value is not 0, set value to 1, otherwise 0
		def not
		end
		
		# inverse ring value
		def neg
		end
	end
end