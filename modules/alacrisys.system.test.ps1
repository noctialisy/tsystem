$date = Get-Date -UFormat "%Y_%m_%d_%H%M";
$assessmentName = "Assessment_$($date).xml";

WinSat formal -restart clean -v -xml "C:\Users\Seph\Assessments\$($assessmentName)";