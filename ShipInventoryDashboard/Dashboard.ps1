# Import our ship dataset logic
. "$PSScriptRoot/ShipData.ps1"

function Show-DashboardMenu {
    Clear-Host
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "     MARITIME FLEET INVENTORY DASHBOARD   " -ForegroundColor Yellow
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "1. View Active Fleet Status"
    Write-Host "2. Check Fuel Levels Alert"
    Write-Host "3. Update Vessel Destination"
    Write-Host "4. Adjust Cargo Levels (Load/Unload)"
    Write-Host "5. Run Fleet Financial & Efficiency Analytics"
    Write-Host "6. Exit System"
    Write-Host "=========================================" -ForegroundColor Cyan
}

# Main Application Execution Loop
do {
    Show-DashboardMenu
    $Selection = Read-Host "Select a bridge option (1-6)"
    
    switch ($Selection) {
        "1" {
            Clear-Host
            Write-Host "--- Current Fleet Inventory Deployment ---" -ForegroundColor Yellow
            Get-ShipFleet | Format-Table -AutoSize
            Read-Host "`nPress Enter to return to the bridge menu"
        }
        "2" {
            Clear-Host
            Write-Host "--- Critical Fuel Monitoring ---" -ForegroundColor Red
            Get-ShipFleet | Where-Object { $_.FuelLevel -lt 50 } | ForEach-Object {
                Write-Host "WARNING: Vessel [$($_.Name)] is low on fuel! ($($_.FuelLevel)%)" -ForegroundColor Red
            }
            Read-Host "`nPress Enter to return to the bridge menu"
        }
        "3" {
            Clear-Host
            Write-Host "--- Change Shipping Routing Orders ---" -ForegroundColor Yellow
            $Fleet = Get-ShipFleet
            $TargetID = Read-Host "Enter the VesselID you want to reroute (e.g., MS-001)"
            $NewDest  = Read-Host "Enter the new destination port city"
            
            $Vessel = $Fleet | Where-Object { $_.VesselID -eq $TargetID }
            if ($Vessel) {
                $Vessel.Destination = $NewDest
                Write-Host "`nSUCCESS: $($Vessel.Name) routing orders updated to $NewDest!" -ForegroundColor Green
                Write-Host "`nUpdated Fleet Records:" -ForegroundColor Yellow
                $Fleet | Format-Table -AutoSize
            } else {
                Write-Host "ERROR: Vessel ID not found in manifest." -ForegroundColor Red
            }
            Read-Host "`nPress Enter to return to the bridge menu"
        }
        "4" {
            Clear-Host
            Write-Host "--- Cargo Hold Adjustments ---" -ForegroundColor Yellow
            $Fleet = Get-ShipFleet
            $TargetID = Read-Host "Enter the VesselID for loading/unloading (e.g., MS-001)"
            
            $Vessel = $Fleet | Where-Object { $_.VesselID -eq $TargetID }
            if ($Vessel) {
                Write-Host "Current Cargo Load for $($Vessel.Name): $($Vessel.CargoLoad)%" -ForegroundColor Cyan
                $Adjustment = Read-Host "Enter new cargo percentage (0 to 100)"
                
                if ($Adjustment -as [int] -and [int]$Adjustment -ge 0 -and [int]$Adjustment -le 100) {
                    $Vessel.CargoLoad = [int]$Adjustment
                    Write-Host "`nSUCCESS: Cargo manifest updated for $($Vessel.Name)!" -ForegroundColor Green
                    Write-Host "`nUpdated Fleet Records:" -ForegroundColor Yellow
                    $Fleet | Format-Table -AutoSize
                } else {
                    Write-Host "ERROR: Invalid cargo parameters. Must be a number between 0 and 100." -ForegroundColor Red
                }
            } else {
                Write-Host "ERROR: Vessel ID not found in manifest." -ForegroundColor Red
            }
            Read-Host "`nPress Enter to return to the bridge menu"
        }
        "5" {
            Clear-Host
            Write-Host "=== FLEET FINANCIAL & EFFICIENCY PROJECTIONS ===" -ForegroundColor Yellow
            Write-Host "------------------------------------------------" -ForegroundColor Cyan
            
            $Fleet = Get-ShipFleet
            foreach ($Ship in $Fleet) {
                # Base math algorithms for simulation
                $EstimatedPortFee = $Ship.CargoLoad * 150 + 2500
                $BurnRateModifier = 1.0 + ($Ship.CargoLoad / 100)
                $EfficiencyScore  = [Math]::Round((($Ship.FuelLevel) / $BurnRateModifier), 1)
                
                Write-Host "Vessel Name:     " -NoNewline; Write-Host "$($Ship.Name)" -ForegroundColor White
                Write-Host "Vessel ID:       " -NoNewline; Write-Host "[$($Ship.VesselID)]" -ForegroundColor Gray
                Write-Host "Estimated Port Fees: " -NoNewline; Write-Host "$($EstimatedPortFee.ToString('C'))" -ForegroundColor Green
                Write-Host "Efficiency Rating:   " -NoNewline
                
                if ($EfficiencyScore -gt 60) {
                    Write-Host "$EfficiencyScore (Optimal)" -ForegroundColor Green
                } elseif ($EfficiencyScore -ge 30) {
                    Write-Host "$EfficiencyScore (Moderate Burn)" -ForegroundColor DarkYellow
                } else {
                    Write-Host "$EfficiencyScore (Critical Refuel Needed)" -ForegroundColor Red
                }
                Write-Host "------------------------------------------------" -ForegroundColor Cyan
            }
            Read-Host "`nPress Enter to return to the bridge menu"
        }
    }
} while ($Selection -ne "6")

Write-Host "Powering down dashboard navigation console. Smooth sailing!" -ForegroundColor Green
