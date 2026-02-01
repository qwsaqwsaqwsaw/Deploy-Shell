# 🚀 Universal Shell Engine (USE) v1.0.1

### 🎮 Turn your Windows PC into a dedicated Gaming Console!

**Universal Shell Engine (USE)** is a lightweight tool that replaces the boring Windows desktop with your favorite gaming interface (like Steam Big Picture). No icons, no taskbar, no distractions—just your games, right from the boot.

---

## ✨ Why use this instead of "Auto-start"?

Normally, Windows loads the entire Desktop (Explorer) before starting Steam. This wastes RAM and looks messy. 

**USE does it differently:**
*   **True Console Experience:** It "cuts out" the Windows Desktop. Your PC boots straight into Steam/Playnite.
*   **More Resources for Games:** By not loading the Taskbar and Start Menu, you free up system resources.
*   **Seamless Exit:** When you close Steam, the Windows Desktop (Explorer) automatically pops back up. It’s magic!
*   **Multi-User Ready:** Give your kid a "Steam-only" account while keeping your "Admin" account for work. Each user gets their own dedicated shell!
---

## 🎭 The "Multiverse" Feature: Infinite Shells

The true power of **USE** lies in its absolute isolation. Since the injection happens at the user level (HKCU), your Windows becomes a multi-interface powerhouse:

*   **Zero Interference:** Setting up a "Console Mode" for one user **does not affect** any other user. Your main Admin account stays untouched with its classic desktop and icons.
*   **Infinite Customization:** You can create 10 different users, and each will have a unique experience:
    *   *User 1:* Boots directly into **Steam** (Console Mode).
    *   *User 2:* Boots into **Playnite** (Universal Game Hub).
    *   *User 3:* Boots into **Kodi** (Home Theater PC).
    *   *User 4:* Keeps the standard **Windows Desktop** for work.
*   **Complete Privacy:** Every user has their own "Sandbox" folder in `%ProgramData%`. Logs, boot scripts, and settings never get mixed up.

It’s like having multiple specialized computers inside one single box! 📦✨

---

## 🖥️ Compatibility: Will it run on my machine?

One of the biggest strengths of **USE** is its "Legacy-Hybrid" engine. It’s designed to be nearly universal:

*   **Windows Versions:** Fully supports **Windows 11, 10, 8.1, 8**, and even **Windows 7** (SP1 with PowerShell 5.1).
*   **Hardware:** Works on standard **Intel/AMD** PCs and laptops.
*   **ARM Support:** Fully compatible with **ARM-based devices** (like Surface Pro X or new Snapdragon laptops). Perfect for Windows-based handhelds!
*   **Any Drive:** It doesn't matter if your games are on `C:`, `D:`, or an external SSD—the engine will track them down.
*   **Any App:** While optimized for **Steam**, it works perfectly with **Playnite**, **RetroArch**, **Kodi**, or any other full-screen application.

---

## 🛠 Pro Features (Inside the Engine)

*   **SID Isolation:** Uses unique system IDs to keep user settings separated. No more "Wait, whose login is this?" issues.
*   **Legacy-Hybrid:** Works on everything from old-school **Windows 7** to the latest **Windows 11**.
*   **Smart Search:** Found Steam on your `D:` or `E:` drive? No problem. The engine will find it automatically.
*   **Cyrillic Support:** Fixed all those "weird characters" bugs in usernames. It just works.

---
## 🔒 Pro Security Tip: "Set and Forget"
Once the script is deployed, you can **downgrade your account to a "Standard User"**. 

*   **Child-Proof:** Perfect for kids! They can play their games, but they won't be able to mess up system settings, delete important files, or install unwanted software.
*   **Bulletproof Console:** Since our engine lives in the protected `%ProgramData%` folder, a standard user can't break the boot logic. It’s a "hardened" gaming station.
*   **Total Peace of Mind:** Your OS stays clean and stable while the user enjoys a pure console experience.

---

## 🚀 Quick Start Guide

1.  **Download** the `USE_v1.0.1.ps1` script.
2.  **Right-click** and select **"Run with PowerShell"**.
3.  **Approve Admin rights** (the engine needs them to set up the "sandbox" for you).
4.  **Follow the prompts.** The script will find your Steam and set everything up.
5.  **Reboot** and enjoy your new console!

---

## 🛡 Failsafe (Don't Panic!)

What if you want your regular Windows back? 
Easy. We put a **"Restore_Explorer"** script right on your Desktop. Run it, and your PC is back to normal. No system files are ever harmed!

---

## 📂 Where are my logs?
If you're a pro and want to see what's happening under the hood, check:
`%ProgramData%\ShellEngine\<Your_ID>\<App_Name>\`

---
## 📜 License
MIT License. Free to use, tweak, and share.

> **Surgical Precision. Gaming Focus. Made for Players.**
