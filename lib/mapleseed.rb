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
		def load_file(path)
			code = File.open(file_path) { |f| f.read }
			run(code)
		end
		
		# interactive read-evaluate-print loop
		def repl
		end
	end
end