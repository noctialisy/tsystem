import sys, os, subprocess, datetime
import json, csv

class SystemHandler:
    commands = []
    date = datetime.datetime.now()

    # Main constructor and command initializer
    def __init__(self, commands):
        self.commands = []

        if len(commands) <= 1:
            print('Cannot parse command specs')
        else:
            for command in commands:
                if command == 'system_clean':
                    self.system_clean()
                elif command == 'system_clean_set':
                    self.system_clean_set()
                elif command == 'system_clean_full':
                    self.system_clean_full()
                elif command == 'netframework_install':
                    self.netframework_install()
                elif command == 'netframework_build':
                    self.netframework_build()
                elif 'video_merge' in command:
                    if ',' not in command:
                        print('video_merge requires specifications, please use the video_merge,<video_path>,<video_ext> syntax')
                        return
                    
                    command_part = command.split(',')
                    video_path = './'
                    video_ext = 'mkv'

                    if command_part[1] != '':
                        video_path = command_part[1]

                    if command_part[2] != '':
                        video_ext = command_part[2]

                    self.video_merge(video_path, video_ext)

                elif 'stream_markers_convert' in command:
                    if ',' not in command:
                        print('stream_markers_convert requires specifications, please use the stream_markers_convert,<file_path> syntax')
                        return
                    
                    command_part = command.split(',')
                    file_path = './'

                    if command_part[1] != '':
                        file_path = command_part[1]

                    self.stream_markers_convert(file_path)




    # Module definition
    def system_clean(self):
        subprocess.run(['cleanmgr', '/sagerun:1'])

    def system_clean_set(self):
        subprocess.run(['cleanmgr', '/sageset:1'])
    
    def system_clean_full(self):
        subprocess.run(['cleanmgr', '/sagerun:1'])
        subprocess.run(['./modules/bat/cleanEventLot.bat'])

    def system_scan(self):
        subprocess.run(['DISM', '/Online', '/Cleanup-Image', '/AnalyzeComponentStore'])
        subprocess.run(['DISM', '/Online', '/Cleanup-Image', '/StartComponentCleanup'])
        subprocess.run(['DISM', '/Online', '/Cleanup-Image', '/RestoreHealth'])
        subprocess.run(['SFC', '/ScanNow'])

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

    
    # Merges multiple video segments into a single output
    def video_merge(self, path, ext):
        if path == '':
            print('This command requires a path specification')
            return

        if 'mkv' not in ext and 'mp4' not in ext:
            print('Missing or not supported video extention')
            return
        
        print('Merging ' + ext + ' files in ' + path + '...\n')
        
        with open(os.path.realpath(path) + '\\output_video_merges.tmp', 'w+', encoding='utf8') as output_video_merges:
            for root, dirs, files in os.walk(path):
                for file in files:
                    if file.endswith(ext):
                        output_video_merges.write('file \'' + os.path.join(root, file) + '\'\n')

        
        subprocess.run('ffmpeg -f concat -safe 0 -i '+ os.path.realpath(path) + '\\output_video_merges.tmp -map 0 -c copy ' + os.path.realpath(path) + '\\output.' + ext)


    # Used to convert Twitch stream markers to kdenlive usable markers
    def stream_markers_convert(self, path):
        if path == '' or 'csv' not in path:
            print('This command requires a csv path specification')
            return
        
        print('Converting streamer markers from ' + path + '...\n')
        
        output_path = path[:-4] + '.json'
        container = []
        tmp_content = ''

        # Read and parse origin csv file
        with open(path, newline='', encoding='utf-8', mode='r+') as csv_file:
            content = csv_file.read()

            if 'time,a,b,c\n' not in content:
                csv_file.seek(0)
                tmp_content = 'time,a,b,c\n' + content
                csv_file.write(tmp_content)

            csv_file.seek(0)

            reader = csv.DictReader(csv_file)

            for row in reader:
                timer = row['time']
                split_timer = timer.split(':')

                hours = int(split_timer[0])
                minutes = int(split_timer[1])
                seconds = int(split_timer[2])

                pos = (seconds * 60) + (minutes * 60 * 60) + (hours * 60 * 60 * 24)

                item = {
                    'pos': pos,
                    'comment': 'Automatically generated time',
                    'type': 0

                }

                container.append(item)
        
        # outs converted content to json
        with open(output_path, encoding='utf-8', mode='w') as json_file:
            json.dump(container, json_file)






        


# Def Main
commands = sys.argv
system_handler = SystemHandler(commands)


