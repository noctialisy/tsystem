all:
	compile

compile:
	pyinstaller --onefile --distpath . tsystem.py