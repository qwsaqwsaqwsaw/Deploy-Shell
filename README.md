# Universal Shell Engine (USE) v1.0.2 "Legacy-Hybrid"


## Executive Summary
**Universal Shell Engine (USE)** is a robust system utility designed to hot-swap the standard Windows Shell (`explorer.exe`) with any targeted executable. By re-engineering the user's session environment, USE transforms a standard Windows OS into a dedicated, high-performance kiosk, gaming console, or workstation without the overhead of the traditional desktop environment.

---

## Core Technical Enhancements in v1.0.2

### 🔍 Adaptive Tiered Discovery (ATD)
Introduced an intelligent 3-stage binary resolution engine. The utility prioritizes high-speed lookups via **System Environment Variables** and **Registry App Paths** before optionally escalating to an exhaustive recursive volume scan. This prevents unnecessary disk I/O and provides immediate feedback.

### ⚙️ Legacy-Hybrid Core Compatibility
Engineered for absolute versatility, the core logic maintains full functional parity across **Windows 7 (PowerShell 2.0)**, **Windows 10**, and **Windows 11 (including native ARM64 support)**. By utilizing low-level .NET calls instead of version-specific cmdlets, the engine ensures stability across a decade of Windows builds.

### 🖥️ Non-Blocking UI & Responsive UX
The integration of a WinForms-based GUI features asynchronous-like behavior using system event processing. This prevents the interface from hanging during deep-scan operations on legacy HDD-based systems, providing a smooth user experience even under heavy load.

### ⌨️ Automatic Input Service Provisioning
The deployment engine automatically injects `CTFMON.exe` initialization into the boot sequence. This critical fix ensures that text input services, IME, and hardware keyboard mappings remain functional within the target application when the standard shell is absent.

### 🛡️ SID-Isolated Sandboxing
Deployment paths are dynamically generated using the **Security Identifier (SID)** of the current user. This allows for absolute isolation on multi-user systems, preventing configuration leakage between different user accounts on the same machine.

---

## Technical Specifications
*   **Target Architectures:** x86, x64, ARM64.
*   **Environment:** PowerShell 2.0 - 5.1+ / .NET Framework (WinForms).
*   **Redirection Method:** User-Level Registry Redirection (HKCU).
*   **Safety Mechanism:** Integrated Rollback Engine & Desktop Recovery Scripts.

## Primary Deployment Scenarios
1.  **Gaming Handhelds & HTPCs:** Boot directly into Steam Big Picture, Playnite, or Kodi with zero desktop interference.
2.  **Kiosk & Digital Signage:** Lock down public-facing terminals to a single application with automated recovery.
3.  **Performance Tuning:** Reduce background process overhead by bypassing the Explorer shell environment entirely.

---
> **Disclaimer:** *USE v1.0.2 represents the pinnacle of shell redirection stability, balancing legacy compatibility with modern hardware awareness. Use with administrative privileges.*
