# Universal Shell Engine (USE) v1.0.0

**Universal Shell Engine** is a minimalist, high-performance deployment tool that transforms your Windows PC into a dedicated gaming console or kiosk. It suppresses the standard Windows Desktop environment (`explorer.exe`) and boots directly into your chosen interface (e.g., Steam Big Picture, Playnite, or any GUI-based app).

---

## 🌟 What is it for?
Windows is a powerful gaming platform, but its interface is cluttered with taskbars, icons, and background pop-ups that break the immersion. 

**USE** eliminates the "PC feel" by acting as a transparent bridge between the hardware and your game library. It provides a "Console-Only" experience: you turn on the PC, and you are immediately in your game library — no distractions, no mouse required.

---

## 🚀 Absolute Compatibility
Unlike many existing scripts, **USE** is engineered for near-universal stability:
*   **Versions:** Full support for Windows 7, 8.1, 10, and 11.
*   **Editions:** Works on **Home**, Pro, and Enterprise editions (bypassing the lack of Group Policy Editor in Home versions).
*   **Architectures:** Native compatibility with **x86, x64, and ARM64** (including Windows on ARM devices).
*   **Agnostic Engine:** While optimized for Steam, it can launch any application that has its own graphical interface.

---

## 🛡️ Why is it Safe?
Security and system integrity were the top priorities during development:
*   **Session-Only (HKCU):** The script modifies the *Current User* registry hive. It does **not** touch system-wide settings (HKLM), meaning administrative accounts remain completely standard and safe.
*   **Non-Invasive:** It does not delete or modify system files. It simply tells Windows what to launch after a successful login.
*   **Zero-Trace Execution:** The engine is human-readable PowerShell. No compiled binaries, no obfuscation, and **0/60 detection rate on VirusTotal**.
*   **Fail-Safe Design:** If your app crashes or you close it, the standard Windows Explorer will automatically launch to prevent you from being "locked out."

---

## ⚠️ Pre-Installation 
For the best "Console Experience," ensure the following before running the script:
1.  **Dedicated User:** Create a NEW local Windows user (e.g., "Gamer").
2.  **Configuration:** Log into that user, pair your gamepads/Bluetooth, and log into your game library (Steam/Playnite).
3.  **Stability:** Ensure the app launches directly to the UI without asking for passwords or updates.

---

## 📦 Installation & Usage
1.  [🔍 View Source Code](Deploy-Shell.ps1) to audit the script.
2.  Run `Deploy-Shell.ps1` as **Administrator** within the target user session.
3.  Confirm the reboot prompt to enter **Shell Mode**.

---

## 🔄 How to Exit & Uninstall
*   **Temporary Exit:** Simply **close your application** (e.g., Exit Steam). The standard Desktop will launch automatically for the current session.
*   **Permanent Rollback:** Run the `Restore_Explorer.ps1` script (found on your Desktop) as Administrator and reboot.
*   **Emergency:** If the app freezes, press `Ctrl + Alt + Del` -> **Task Manager** -> File -> Run new task -> type `powershell` (check "Create with admin privileges") and execute the restore script:
    ```powershell
    & "$env:USERPROFILE\Desktop\Restore_Explorer.ps1"
    ```

---

## 👨‍💻 For System Administrators
The **Universal Shell Engine** is built on a "set and forget" philosophy. 
*   **Discovery:** Uses a multi-volume deep scan (Depth: 3) with registry priority to resolve target paths dynamically.
*   **Logging:** Persistent session logging at `%ProgramData%\ShellEngine\engine.log`.
*   **Cleanliness:** No `AutoAdminLogon` exploits or `Userinit` hijacking (avoids EDR triggers).
*   **Stability:** Built on native Windows APIs that will remain relevant for future Windows releases.

---
**Author:** Oleksandr Monasturskyi  
**Version:** 1.0.0 (Stable) | **License:** MIT
