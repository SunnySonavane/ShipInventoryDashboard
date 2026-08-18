# Import our ship dataset logic
. "$PSScriptRoot/ShipData.ps1"

function Show-DashboardMenu {
    Clear-Host
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "     MARITIME FLEET INVENTORY DASHBOARD   " -ForegroundColor Yellow
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "1. View Active Fleet Status"
    Write-Host "2. Check Fuel Levels Alert"
    Write-Host "3. Exit System"
    Write-Host "=========================================" -ForegroundColor Cyan
}

# Main Application Execution Loop
do {
    Show-DashboardMenu
    $Selection = Read-Host "Select a bridge option (1-3)"
    
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
    }
} while ($Selection -ne "3")

Write-Host "Powering down dashboard navigation console. Smooth sailing!" -ForegroundColor Green
