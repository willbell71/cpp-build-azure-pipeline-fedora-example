# Defines, Config
NAME = main
OUTPUTFOLDER = build
PROGRAM = $(OUTPUTFOLDER)/$(NAME)

CC = g++
CCFLAGS = -Wall -Werror -std=c++2a -g
FILES = src/main.cpp
OBJS = $(foreach var, $(FILES), $(subst .cpp,.o,$(subst src/,$(OUTPUTFOLDER)/,$(var))))
OUTPUTPATHS = $(foreach var, $(FILES), $(dir $(subst src/,$(OUTPUTFOLDER)/,$(var))))

# Main target and build step
all: $(PROGRAM)

$(PROGRAM): .depend $(OBJS)
	$(CC) $(CCFLAGS) $(OBJS) $(LDFLAGS) -o $(PROGRAM) $(LDLIBS)

# Handle dependancy generation and usage
depend: .depend

.depend: cmd = gcc -MT $(subst .cpp,.o,$(subst src/,build/,$(var))) -MM -MF depend $(var); cat depend >> .depend;
.depend: $(FILES)
	@echo "Generating dependencies..."
	@$(foreach var, $(FILES), $(cmd))
	@rm -f depend

-include .depend

# Rule for generate .o from .cpp
$(OUTPUTFOLDER)/%.o: src/%.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

# Delete output, any intermediate files plus and any build files
clean:
	rm -f .depend $(OBJS) $(PROGRAM)

# Generate output folder structure based on source structure
make_dir = mkdir -p $(var);
generatebuild:
	@rm -rf $(OUTPUTFOLDER)
	@$(foreach var, $(OUTPUTPATHS), $(make_dir))

# Generate documentation config
newdoc:
	cd src; doxygen -g

# Generate documentation
doc:
	cd src; doxygen

# Generate GTAGS for intellisense
gtags:
	gtags

.PHONY: clean depend
