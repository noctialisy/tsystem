$fileDirectory = "E:\Restore\SoftwarePKG\VCRedist"
$fileList = Dir -File $fileDirectory;

foreach ($f in $fileList) {
    cmd /c "$($fileDirectory)\$($f) /q";
}