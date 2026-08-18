# Maritime Fleet Dashboard README File
## Maritime Fleet Inventory Dashboard
A modular, file-persistent PowerShell terminal application designed for real-time maritime vessel logistics management, route adjustments, and predictive financial analytics.
## 🚀 System Architecture & Key Features
This application models an enterprise command console using professional-grade scripting best practices, split across a clean multi-layer data structure:

* Data Persistence Engine (ShipData.ps1): Completely decoupled memory architecture that transitions from flat system arrays to a local table infrastructure (FleetDatabase.csv).
* Dynamic Routing Control: Real-time routing order adjustments that persist changes straight to disk immediately upon verification.
* Cargo Hold Threshold Sanitization: Interactive loading and unloading operations built with safe structural guardrails (0% to 100%) to protect hull structural buoyancy.
* Critical Fuel Level Alert Systems: Scans live records and flags low-fuel vessels (< 50%) with conditional red console warning indicators.
* Financial Projections & Efficiency Analytics: Automated maritime mathematical model computing estimated port fees, variable fuel burn-rate modifiers, and currency-formatted financial streams.

------------------------------
## 🛠️ Project File Manifest

| File Name | Purpose / Responsibility |
|---|---|
| Dashboard.ps1 | The main execution loop containing user menus, layout generation, and sanitized router logic. |
| ShipData.ps1 | The data access layer containing CSV read/write functions and file setup logic. |
| FleetDatabase.csv | The persistent file database keeping track of all vessel IDs, names, cargo, fuel, and routing orders. |

------------------------------
## 💻 Installation & Local Execution## Prerequisites

* Windows: PowerShell 5.1 or PowerShell Core 7+
* macOS / Linux: PowerShell Core 7+ installed via Homebrew or system package managers.

## Running the App

   1. Clone this repository to your local folder:
   
   git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
   
   2. Navigate directly into your project repository directory:
   
   cd ShipInventoryDashboard
   
   3. Open your terminal or VS Code, and launch the core bridge environment execution loop script:
   
   ./Dashboard.ps1
   
   
------------------------------
## 🔧 Core Code Snippet Showcase

This snippet showcases the robust **Cargo Hold Adjustment** routine with type validation and disk save integration:

```powershell
$Adjustment = Read-Host "Enter new cargo percentage (0 to 100)"

# Type validation guardrail ensures input is within a safe threshold
if ($Adjustment -as [int] -and [int]$Adjustment -ge 0 -and [int]$Adjustment -le 100) {
    $Vessel.CargoLoad = [int]$Adjustment
    # Instantly saves data state to file database
    Save-ShipFleet -UpdatedFleet $Fleet
    Write-Host "`nSUCCESS: Cargo manifest persisted to database!" -ForegroundColor Green
} else {
    Write-Host "ERROR: Invalid cargo parameters." -ForegroundColor Red
}
```

---

## 🧑‍💻 Development Workflow & Branch Hygiene

This project strictly utilizes the **Git Feature Branch Workflow** to guarantee that the `main` production branch remains stable during feature development cycles:

1. **Isolate:** Work inside isolated feature dry-docks (`git checkout -b feature-name`).
2. **Commit:** Log modular, standard semantic commits (`git commit -m "feat: description"`).
3. **Merge:** Switch back to `main`, pull the tested branch (`git merge feature-name`), and push live (`git push origin main`).

