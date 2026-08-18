# Set up paths for a persistent local database
$DatabasePath = "$PSScriptRoot/FleetDatabase.csv"

# If the database file does not exist, create it with baseline maritime records
if (-not (Test-Path $DatabasePath)) {
    $InitialData = @"
VesselID,Name,Type,CargoLoad,FuelLevel,Destination
MS-001,Pacific Horizon,Container,85,92,Singapore
MS-002,Atlantic Titan,Oil Tanker,40,78,Rotterdam
"@
    Out-File -FilePath $DatabasePath -InputObject $InitialData -Encoding utf8
}

function Get-ShipFleet {
    # Read live records directly from the persistent file store
    return Import-Csv -Path $DatabasePath
}

function Save-ShipFleet {
    param (
        [Parameter(Mandatory=$true)]
        $UpdatedFleet
    )
    # Persist live bridge changes back into the table infrastructure
    $UpdatedFleet | Export-Csv -Path $DatabasePath -NoTypeInformation -Encoding utf8
}
