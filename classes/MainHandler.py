import sys, os, subprocess, datetime, csv, json

class MainHandler:
    commands = []
    date = datetime.datetime.now()

    # Main constructor and command initializer
    def __init__(self, commands):
        self.commands = commands
