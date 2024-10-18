import sys, os, subprocess, datetime, csv, json

class MainHandler:
    version = '0.24.08.12'
    commands = []
    date = datetime.datetime.now()

    # Main constructor and command initializer
    def __init__(self, commands):
        self.commands = commands

    def help(self):
        print('===========================================')
        print('||                                       ||')
        print('||    Tsystem Lib version ' + self.version + '     ||')
        print('||                                       ||')
        print('===========================================')
        print('This help section illustrates the functionality present in this software')
        print('To call these functions append them to the program name without prefixes like the following "tsystem system_clean"')
        print('In addition, this software can run multiple commands in sequence, example: "tsystem system_clean system_scan"')
        print('')
        print('System functions:')
        print('  system_clean')
        print('    Calls cleanmgr on all drives following the setting specified with system_clean_set')
        print('  system_clean_set')
        print('    Calls cleanmgr to set the default clean profile')
        print('  system_clean_full')
        print('    Same as system_clean but also calls cleanEventLog.bat from the bat folder')
        print('  system_scan')
        print('    Scans the system using DISM and SFC to find errors and repair them')
        print('  system_test')
        print('    Runs WinSat and writes the results in the log folder')
        print('  netframework_install')
        print('    Deploys a complete setup of the .NET runtimes to allow the system to run any .NET content')
        print('  netframework_build')
        print('    Precompiles the .NET runtimes for better execution and performances in apps that use .NET features')
        print('')
        print('Video functions:')
        print('  video_merge')
        print('    Quickly merges two or more mp4 or mkv files from the specified folder')
        print('  stream_markers_convert')
        print('    Converts a Twitch.tv csv file containing stream markers to a default kdenlive json format for easy import')
        print('')
