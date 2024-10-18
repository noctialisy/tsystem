ifeq ($(OS),Windows_NT)
	target := win
    python := ./venv/win/Scripts/python.exe
	pip := ./venv/win/Scripts/pip.exe
	pyinstaller := ./venv/win/Scripts/pyinstaller.exe

else
	target := lin
    python := ./venv/lin/bin/python3
	pip := ./venv/lin/bin/pip
	pyinstaller := ./venv/lin/bin/pyinstaller

endif


all:
	compile

compile:
	$(pyinstaller) --onefile --distpath . tsystem.py

prepare_venv:
	python -m venv ./venv/$(target)
	$(pip) install -r ./requirements.txt