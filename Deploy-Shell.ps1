<#
 =========================================================================
 Project:    Universal Shell Engine (USE) v1.0.2 "Legacy-Hybrid"
 Deployment: SID-Based Ultra-Compatible Redirection & GUI Manager
 Compatibility: Windows 7/10/11 (x86, x64, ARM64) | PS 2.0 - 5.1+
 =========================================================================
#>

[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

$UserSID = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
$RegPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Global:FoundPath = ""

if ($PSVersionTable.PSVersion.Major -ge 3) { [System.Windows.Forms.Application]::EnableVisualStyles() }

$form = New-Object System.Windows.Forms.Form
$form.Text = "USE v1.0.3 | Universal Shell Engine"
$form.Size = New-Object System.Drawing.Size(520, 500)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 20)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = "FixedSingle"

# Professional Font Stack
$GlobalFont = New-Object System.Drawing.Font("Segoe UI", 9)
if (-not $GlobalFont) { $GlobalFont = New-Object System.Drawing.Font("Tahoma", 9) }
$form.Font = $GlobalFont

# UI Components
$lblInput = New-Object System.Windows.Forms.Label
$lblInput.Text = "Target Binary (e.g., app.exe):"
$lblInput.Location = New-Object System.Drawing.Point(25, 20)
$lblInput.AutoSize = $true
$form.Controls.Add($lblInput)

$txtExe = New-Object System.Windows.Forms.TextBox
$txtExe.Text = "app.exe"
$txtExe.Location = New-Object System.Drawing.Point(25, 45)
$txtExe.Size = New-Object System.Drawing.Size(320, 25)
$txtExe.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
$txtExe.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($txtExe)

# Checkbox for Deep Scan
$chkDeep = New-Object System.Windows.Forms.CheckBox
$chkDeep.Text = "Enable Exhaustive Deep Scan (Slow on HDD)"
$chkDeep.Location = New-Object System.Drawing.Point(25, 75)
$chkDeep.Size = New-Object System.Drawing.Size(320, 20)
$chkDeep.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($chkDeep)

$btnSearch = New-Object System.Windows.Forms.Button
$btnSearch.Text = "RESOLVE"
$btnSearch.Location = New-Object System.Drawing.Point(360, 43)
$btnSearch.Size = New-Object System.Drawing.Size(115, 28)
$btnSearch.FlatStyle = "Flat"
$btnSearch.BackColor = [System.Drawing.Color]::FromArgb(63, 63, 70)
$form.Controls.Add($btnSearch)

$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.Location = New-Object System.Drawing.Point(25, 110)
$logBox.Size = New-Object System.Drawing.Size(450, 160)
$logBox.ReadOnly = $true
$logBox.BackColor = [System.Drawing.Color]::Black
$logBox.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 128)
$logBox.Text = "[*] Engine initialized. Awaiting target resolution...`n"
$form.Controls.Add($logBox)

$btnDeploy = New-Object System.Windows.Forms.Button
$btnDeploy.Text = "EXECUTE DEPLOYMENT"
$btnDeploy.Enabled = $false
$btnDeploy.Location = New-Object System.Drawing.Point(25, 290)
$btnDeploy.Size = New-Object System.Drawing.Size(450, 45)
$btnDeploy.FlatStyle = "Flat"
$btnDeploy.Font = New-Object System.Drawing.Font($form.Font.FontFamily, 10, [System.Drawing.FontStyle]::Bold)
$btnDeploy.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$form.Controls.Add($btnDeploy)

$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Text = "REVERT TO EXPLORER SHELL"
$btnRestore.Location = New-Object System.Drawing.Point(25, 350)
$btnRestore.Size = New-Object System.Drawing.Size(450, 35)
$btnRestore.FlatStyle = "Flat"
$btnRestore.ForeColor = [System.Drawing.Color]::Tomato
$form.Controls.Add($btnRestore)

# Logic: Tiered Discovery
$btnSearch.Add_Click({
    $target = $txtExe.Text
    $Global:FoundPath = ""
    $logBox.AppendText("[>] Resolving: $target`n")
    
    # Tier 1 & 2: Instant lookup
    $cmd = Get-Command $target -ErrorAction SilentlyContinue
    if ($cmd) { $Global:FoundPath = $cmd.Definition }

    if (-not $Global:FoundPath) {
        $scopes = @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:AppData)
        foreach ($s in $scopes) {
            $check = Join-Path $s $target
            if (Test-Path $check) { $Global:FoundPath = $check; break }
        }
    }

    # Tier 3: Optional Deep Scan
    if (-not $Global:FoundPath -and $chkDeep.Checked) {
        $logBox.AppendText("[!] Deep scan active. Checking volumes...`n")
        $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -gt 0 }
        foreach ($d in $drives) {
            # Keep UI partially responsive
            [System.Windows.Forms.Application]::DoEvents()
            $Global:FoundPath = Get-ChildItem -Path "$($d.Root)" -Include $target -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName -First 1
            if ($Global:FoundPath) { break }
        }
    }

    if ($Global:FoundPath) {
        $logBox.AppendText("[SUCCESS] Target resolved: $Global:FoundPath`n")
        $btnDeploy.Enabled = $true
        $btnDeploy.BackColor = [System.Drawing.Color]::DarkGreen
    } else {
        $msg = if($chkDeep.Checked){"Not found."}else{"Not found. Try enabling Deep Scan."}
        $logBox.SelectionColor = [System.Drawing.Color]::Red
        $logBox.AppendText("[FAILURE] $msg`n")
    }
})

# Deployment & Restore Logic (Same as v1.0.2)
$btnDeploy.Add_Click({
    try {
        $AppTarget = $txtExe.Text.Split(".")[0]
        $EngineDir = [System.IO.Path]::Combine($env:ProgramData, "ShellEngine\$UserSID\$AppTarget")
        $BootScript = [System.IO.Path]::Combine($EngineDir, "BootManager.ps1")
        if (-not [System.IO.Directory]::Exists($EngineDir)) { [System.IO.Directory]::CreateDirectory($EngineDir) | Out-Null }
        
        $BootContent = "try { if (!(Get-Process 'ctfmon' -ErrorAction SilentlyContinue)) { Start-Process 'C:\Windows\System32\ctfmon.exe' }; Start-Process '$Global:FoundPath' -Wait } finally { Start-Process 'explorer.exe' }"
        [System.IO.File]::WriteAllText($BootScript, $BootContent, [System.Text.Encoding]::UTF8)

        $ShellCmd = "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$BootScript`""
        Set-ItemProperty -Path $RegPath -Name "Shell" -Value $ShellCmd -Force

        $logBox.AppendText("[*] Deployment finalized.`n")
        [System.Windows.Forms.MessageBox]::Show("Success. System reboot recommended.", "USE Core")
    } catch { $logBox.AppendText("[FATAL] Error: $($_.Exception.Message)`n") }
})

$btnRestore.Add_Click({
    Remove-ItemProperty -Path $RegPath -Name "Shell" -Force -ErrorAction SilentlyContinue
    $logBox.AppendText("[RESTORE] Explorer shell restored.`n")
})

$form.ShowDialog()
