build:
	make clean
	@antlr4ruby FSML.g
#	mv FSMLLexer.rb fsml_lexer.rb
#	mv FSMLParser.rb fsml_parser.rb

run:
	@ruby main.rb sample.fsml	
	

clean:
	@rm -rf FSMLParser.rb
	@rm -rf FSMLLexer.rb
	@rm -rf fsml_lexer.rb
	@rm -rf fsml_parser.rb
	@rm -rf FSML.tokens
	@rm -rf *.png
	@rm -rf DefaultHandler.rb
	@rm -rf DefaultStepper.rb
