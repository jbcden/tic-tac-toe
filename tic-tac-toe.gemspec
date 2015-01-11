Gem::Specification.new do |gem|
	gem.name = "tic-tac-toe"
	gem.version = "0.0.0"
	gem.author = "Jacob Chae"
	gem.email = "jbcden@gmail.com"
	gem.summary = "A command line based game of tic-tac-toe"
	gem.add_development_dependency "minitest"
	gem.add_development_dependency "rake"
	gem.test_files = Dir["test/*_test.rb"]
	gem.files = Dir["lib/**/*.rb"]
	gem.executables << "game"
end
