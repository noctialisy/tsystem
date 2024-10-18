ifeq ($(OS),Windows_NT)
	target := win
	py_libs := ./venv/win/Lib/site-packages
    python := ./venv/win/Scripts/python.exe
	pip := ./venv/win/Scripts/pip.exe
	pyinstaller := ./venv/win/Scripts/pyinstaller.exe

else
	target := lin
	py_libs := ./venv/lin/Lib/site-packages
    python := ./venv/lin/bin/python3
	pip := ./venv/lin/bin/pip
	pyinstaller := ./venv/lin/bin/pyinstaller

endif


all:
	compile

prepare_venv:
	python -m venv ./venv/$(target)
	$(pip) install -r ./requirements.txt

install_requirements:
	$(pip) install -r ./requirements.txt

compile:
	$(pyinstaller) --onefile --paths $(py_libs) --distpath . tsystem.py

run:
	$(python) ./tsystem.py $(ARGS)