import sys
import classes.SystemHandler as SystemHandler
import classes.VideoHandler as VideoHandler

# Def Main
def main():
    commands = sys.argv

    system_handler = SystemHandler.SystemHandler(commands)
    video_handler = VideoHandler.VideoHandler(commands)

    if len(commands) <= 1:
        print('No command specified.')
        print('')
        system_handler.help()
                
    else:
        for command in commands:
            if command == 'system_clean':
                system_handler.system_clean()

            elif command == 'system_clean_set':
                system_handler.system_clean_set()

            elif command == 'system_clean_full':
                system_handler.system_clean_full()

            elif command == 'netframework_install':
                system_handler.netframework_install()

            elif command == 'netframework_build':
                system_handler.netframework_build()

            elif 'video_merge' in command:
                if ',' not in command:
                    print('video_merge requires specifications, please use the video_merge,<video_path>,<video_ext> syntax')

                else:
                    command_part = command.split(',')
                    video_path = './'
                    video_ext = 'mkv'

                    if command_part[1] != '':
                        video_path = command_part[1]

                    if command_part[2] != '':
                        video_ext = command_part[2]

                    video_handler.video_merge(video_path, video_ext)

            elif 'stream_markers_convert' in command:
                if ',' not in command:
                    print('stream_markers_convert requires specifications, please use the stream_markers_convert,<file_path> syntax')

                else:
                    command_part = command.split(',')
                    file_path = './'

                    if command_part[1] != '':
                        file_path = command_part[1]

                    video_handler.stream_markers_convert(file_path)
            
            else:
                system_handler.help()


main()