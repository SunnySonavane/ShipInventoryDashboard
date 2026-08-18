function Get-ShipFleet {
    $Fleet = @(
        [PSCustomObject]@{
            VesselID    = "MS-001"
            Name        = "Pacific Horizon"
            Type        = "Container"
            CargoLoad   = 85 
            FuelLevel   = 92 
            Destination = "Singapore"
        },
        [PSCustomObject]@{
            VesselID    = "MS-002"
            Name        = "Atlantic Titan"
            Type        = "Oil Tanker"
            CargoLoad   = 40
            FuelLevel   = 78
            Destination = "Rotterdam"
        }
    )
    return $Fleet
}
