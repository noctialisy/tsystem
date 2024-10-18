import sys, os, subprocess, datetime, csv, json
from . import MainHandler

class SystemHandler(MainHandler.MainHandler):
    
    # Module definition
    def system_clean(self):
        subprocess.run(['cleanmgr', '/sagerun:1'])

    def system_clean_set(self):
        subprocess.run(['cleanmgr', '/sageset:1'])
    
    def system_clean_full(self):
        subprocess.run(['cleanmgr', '/sagerun:1'])
        subprocess.run('.\\bat\\cleanEventLog.bat')

    def system_scan(self):
        subprocess.run('DISM /Online /Cleanup-Image /AnalyzeComponentStore')
        subprocess.run('DISM /Online /Cleanup-Image /StartComponentCleanup')
        subprocess.run('DISM /Online /Cleanup-Image /RestoreHealth')
        subprocess.run('SFC /ScanNow')

    def system_test(self):
        log_file = './logs/Assessment_' + str(self.date.timestamp()) + '.xml'
        subprocess.run(['WinSat', 'formal', '-restart', 'clean', '-v', '-xml ' + log_file])


    def netframework_install(self):
        netframework_folder = './vcredist'
        netframework_content = os.scandir(os.fspath(netframework_folder))

        for netframework_app in netframework_content:
            subprocess.run([netframework_app, '/q'])
    
    def netframework_build(self):
        netframework_folder = 'C:\\Windows\\Microsoft.NET\\'
        framework86 = 'Framework'
        framework64 = 'Framework64'

        for root, dirs, files in os.walk(netframework_folder + framework86):
            for file in files:
                if file.endswith('ngen.exe'):
                    subprocess.run([os.path.join(root, file), 'update'])

        for root, dirs, files in os.walk(netframework_folder + framework64):
            for file in files:
                if file.endswith('ngen.exe'):
                    subprocess.run([os.path.join(root, file), 'update'])
