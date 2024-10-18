$driveVolumeLetter = Get-Volume -FileSystemLabel "Data_Unit" | Select-Object -Property "DriveLetter" | Select -ExpandProperty "DriveLetter";

#Lists custom modules present on the system

dir "$($driveVolumeLetter):\WorkSpace_Global\Tools\TSystem\Modules"