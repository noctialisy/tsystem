:: Created by: Shawn Brink
:: http://www.tenforums.com
:: Tutorial: http://www.tenforums.com/tutorials/16588-event-viewer-clear-all-event-logs-windows.html


for /F "tokens=*" %%a in ('wevtutil.exe el') DO wevtutil.exe cl "%%a"

