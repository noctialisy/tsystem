$fileDirectory = "$($PSScriptRoot)\..\vcredist"
$fileList = Get-ChildItem -File $fileDirectory;

foreach ($f in $fileList) {
    cmd /c "$($fileDirectory)\$($f) /q";
}