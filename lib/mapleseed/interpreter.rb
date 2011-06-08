require File.expand_path(File.join(File.dirname(__FILE__), "memory.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "ring.rb"))

module Mapleseed
	#interprets Whirl code
	class Interpreter
		attr_reader :memory
		attr_accessor :memory_position, :program_position
		
		# initializes the interpreter
		def initialize
			@memory = Memory.new
			@op_ring = OpRing.new
			@math_ring = MathRing.new
			@memory_position = 0
			@program_position = 0
		end
		
		def run(code)
			
		end
	end
end