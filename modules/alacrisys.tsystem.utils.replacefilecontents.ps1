#-----------------------------------------------------------------------------------
#  Author: Antonio Martino <TheAlabaster92@hotmail.com>
#  Description:
#    This script is used to search all files in a directory and replace the
#    specified content with a new one.
#-----------------------------------------------------------------------------------
#  Input:
#    (FilePath), (String To Find), (New String)

$filePath          = $args[0];
$string            = $args[1];
$newString         = $args[2];

$fileList = Get-ChildItem -File $filePath;

foreach ($file in $fileList) {
	Write-Output "$($filePath)"+"$($file.Name)";
	
	try {
		$fileContent = [System.IO.File]::ReadAllText("$($filePath)"+"$($file.Name)").Replace($string, $newString);
		[System.IO.File]::WriteAllText("$($filePath)"+"$($file.Name)", $fileContent);
		
	} catch {
		Write-Output "An Error has occurred:";
		Write-Output $Error[0];
		
	}
	
}
