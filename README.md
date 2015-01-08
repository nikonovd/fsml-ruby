FSML-Ruby
=========

This is an implementation of the so called Finite State Machine Language (FSML) using the ruby language.

Prerequisites
=========

This project depends on several gems that are used within the project. We use [antlr4ruby](http://antlr.ohboyohboyohboy.org/GettingStarted.html) aswell as [ruby-graphviz](https://github.com/glejeune/Ruby-Graphviz/). Please make sure you have installed both gems via

```bash
sudo gem install ruby-graphviz
sudo gem install antlr3
```

At least ruby 2.x is required for project execution.

General usage
=========
Make sure you are in the root folder of this project.
```bash
ruby main.rb [inputfile.fsml]
```

A concrete example that is used within this project is
```bash
ruby main.rb sample.fsml
```

Makefile
=========

The project contains a Makefile that provides several commands.

Use `make build` to generate required project files, e.g. antlr creates Lexer and Parser for the provided grammar file.
`make clean` removes generated project files like images, generated source code and the Lexer and Parser mentioned above.
The command `make run` executes the main project file with the sample.fsml as the input stream. Hence, the project reads the input file, parses the provide fsm source code, checks constraints, runs the semantics simulator, generates source code and visualizes the state machine via graphviz.
