# Universal Shell Engine (USE) v1.0.0

**Universal Shell Engine** is a high-performance deployment tool designed to replace the standard Windows Desktop (explorer.exe) with a custom shell environment. It provides a seamless "Console-Only" experience, turning any PC into a dedicated gaming station.

---

## 🚀 Key Features

* **Adaptive Discovery:** Automatically scans all drives for the target executable (Depth: 3).
* **Universal Compatibility:** Engineered for absolute stability across all Windows versions (7/10/11), editions (Home/Pro), and architectures (x86, x64, ARM).
* **Visual Polish:** Pure console experience—no Taskbar, no icons, no Windows pop-ups. Just your interface.
* **Auto-Recovery:** Built-in logic restores explorer.exe instantly if the application is closed or crashes.
* **Silent Flexibility:** Easily target any GUI-based app (Playnite, RetroArch, etc.) by editing the `$AppExeName` variable.

---

## ⚠️ Pre-Installation 

For a safe and stable experience, please perform these steps **BEFORE** running the script:

1. **Dedicated Account:** Create a NEW local Windows user (e.g., "Gamer").
2. **System Setup:** Log into that new user, pair your Bluetooth devices (Gamepads, etc.), and configure your hardware.
3. **App Setup:** Log into Steam/Playnite and ensure they launch directly to the UI without asking for passwords or updates.
4. **Final Step:** Run the deployment script only after everything is configured.

---

## 📦 Installation & Usage

### 1. Get the files
*   **Option A (Recommended):** [📥 Download Full Release (ZIP)](https://github.com) — includes Script, Instructions, and License.
*   **Option B (Script only):** [📄 Download Deploy-Shell.ps1](https://github.com) — just the standalone script.
*   **Source:** [🔍 View Source Code](Deploy-Shell.ps1) directly on GitHub.

### 2. Execution
1.  Open PowerShell as **Administrator**.
2.  Navigate to the file location and run `Deploy-Shell.ps1`.
3.  Confirm the system reboot when prompted.



---

## 🔄 How to Exit & Uninstall

### 1. Temporary Exit
Simply **close or exit** your application (e.g., Exit Steam). The standard Windows Desktop will launch automatically for the current session.

### 2. Permanent Rollback (Uninstall)
1. Close your shell application to access the Desktop.
2. Right-click `Restore_Explorer.ps1` on your Desktop.
3. Select **Run with PowerShell** (as Admin) and restart.

### 3. Emergency Recovery
If the app freezes, press **Ctrl + Alt + Del** -> **Task Manager** -> File -> Run new task -> type **powershell** (check "Create with admin privileges") -> Execute the restore script from your Desktop folder:
`& "$env:USERPROFILE\Desktop\Restore_Explorer.ps1"`

---

## 🛠 Technical Specifications

* **Injection Method:** Registry Redirection (HKCU\...\Winlogon\Shell)
* **Logic Root:** %ProgramData%\ShellEngine
* **Logging:** %ProgramData%\ShellEngine\engine.log
* **License:** MIT

---
**Author:** Oleksandr Monasturskyi | **Version:** 1.0.0 (Stable)
