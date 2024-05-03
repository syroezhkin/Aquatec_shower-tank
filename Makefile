default: view

TARGET_FILE = ./build/Aquatec_shower-tank.rst
BUILDER = ../RengaSTDLSDK/RstBuilder/RstBuilder.exe
VIEWER = ../RstViewer/RstViewer.exe

ifeq ($(OS),Windows_NT)
build: build-win
view: view-win
else
build: build-linux
view: view-linux
endif

build-win:
	$(BUILDER) ./parameters.json ./main.lua -o $(TARGET_FILE)

build-linux:
	wine $(BUILDER) ./parameters.json ./main.lua -o $(TARGET_FILE)

view-win: build
	$(VIEWER) $(TARGET_FILE)

view-linux: build
	@echo "RstViewer can work on Windows only."
