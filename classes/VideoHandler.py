import sys, os, subprocess, datetime, csv, json
from . import MainHandler

class VideoHandler(MainHandler.MainHandler):
    
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

