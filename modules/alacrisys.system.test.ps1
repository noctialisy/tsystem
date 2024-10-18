$date = Get-Date -UFormat "%Y_%m_%d_%H%M";
$assessmentName = "Assessment_$($date).xml";
$logFolder = "$($PSScriptRoot)\..\logs";

WinSat formal -restart clean -v -xml "$($logFolder)\$($assessmentName)";