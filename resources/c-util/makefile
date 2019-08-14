PROGRAM_NAME    =  "@@PROJECT@@"
RESOURCES_DIR   =  $(HOME)/.resources
BIN_INSTALL_DIR =  $(HOME)/bin

compile_main:
	gcc -Wall -Wextra main.c -o $(PROGRAM_NAME)

clean:
	rm -rf @@PROJECT@@

install:
	mkdir -p $(RESOURCES_DIR)/$(PROGRAM_NAME)
	cp -r resources/* $(RESOURCES_DIR)/$(PROGRAM_NAME) 
	cp -r $(PROGRAM_NAME) $(BIN_INSTALL_DIR)/$(PROGRAM_NAME)

uninstall:
	rm -rf $(RESOURCES_DIR)/$(PROGRAM_NAME)
	rm $(BIN_INSTALL_DIR)/$(PROGRAM_NAME)

document:
	autodoc main.c
