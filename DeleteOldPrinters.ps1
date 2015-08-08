$OldPrintServerPrinters = get-wmiobject -class win32_printer | where {$_.SystemName -eq "\\OldPrintServer" -or $_.SystemName -eq "\\OldPrintServer.domain.com"}

Write-Host "Checking for printers located on server OldPrintServer" -ForegroundColor "yellow"

if($OldPrintServerPrinters -ne $NULL){
	$NumberPrinters=0
	
	foreach ($printer in $OldPrintServerPrinters){
		$NumberPrinters++
	}

	Write-Host "`$NumberPrinters printers located on server OldPrintServer found" -ForegroundColor "red"
	Write-Host "Beginning removal of OldPrintServer printers`n" -ForegroundColor "yellow"

	foreach ($printer in $OldPrintServerPrinters){

		$share=$printer.ShareName
		$system=$printer.SystemName -replace "\\",""
		$system=$system.ToUpper()
		
		write-host "Removing $share $system printer..." -ForegroundColor "yellow"
		$printer.Delete()
		sleep 2
			
	}
	write-host "`nAll OldPrintServer printers removed" -ForegroundColor "green"
}
else{
	write-host "`nNo Printers located on server OldPrintServer found" -ForegroundColor "green"
	sleep 2
}