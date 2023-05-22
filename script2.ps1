$serverName = Read-Host "Enter the server name:"
$services = Get-Service -ComputerName $serverName

foreach ($service in $services) {
    $serviceName = $service.Name
    $serviceStatus = $service.Status
    Write-Host "Service: $serviceName, Status: $serviceStatus"

    $action = Read-Host "Enter action to perform on the service (start/stop/skip):"
    if ($action -eq "start") {
        Start-Service -Name $serviceName -ComputerName $serverName -ErrorAction SilentlyContinue
        if ($?) {
            Write-Host "Service '$serviceName' started successfully."
        } else {
            Write-Host "Failed to start service '$serviceName'."
        }
    }
    elseif ($action -eq "stop") {
        Stop-Service -Name $serviceName -ComputerName $serverName -ErrorAction SilentlyContinue
        if ($?) {
            Write-Host "Service '$serviceName' stopped successfully."
        } else {
            Write-Host "Failed to stop service '$serviceName'."
        }
    }
    elseif ($action -eq "skip") {
        Write-Host "Skipping service '$serviceName'."
    }
    else {
        Write-Host "Invalid action specified. Skipping service '$serviceName'."
    }

    Write-Host
}
