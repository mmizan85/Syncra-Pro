# ⚡ Syncra Pro - Ultimate Media Downloader

![Version](https://img.shields.io/badge/version-1.2.0-blue.svg) ![Platform](https://img.shields.io/badge/platform-Windows-0078D6.svg) ![Tech](https://img.shields.io/badge/Built%20With-PowerShell%20%2B%20Chrome-4caf50.svg)

> **Bridge the gap between your browser and your local machine.** > Syncra Pro allows you to download YouTube Videos, Playlists, and Audio directly to your PC using a powerful local PowerShell engine. No ads, no third-party servers, just pure speed.

---

## 🌟 Key Features

### 🎥 High-Quality Video
- Download videos in **4K (2160p)**, **2K (1440p)**, and **1080p (Full HD)**.
- Smart merging of video and audio for the best experience.

### 🎵 Crystal Clear Audio
- Extract audio tracks in high-quality **MP3 (320kbps)**.
- Perfect for building offline music libraries.

### 📂 Playlist Support
- **One-Click Batch Download:** Grab an entire YouTube Playlist instantly.
- Automatically organizes files in your folder.

### 📱 Feature Phone Optimized
- Specialized support for **Low-End Devices**.
- Converts videos to lightweight formats (3GP/Low MP4) compatible with keypad phones.

### 🚀 Privacy & Speed
- **100% Local Processing:** No remote servers see your data.
- **Maximum Speed:** Utilizes your full internet bandwidth via `yt-dlp`.

---

## 🛠️ Architecture

Syncra Pro works using a **Hybrid Architecture**:
1.  **Frontend (Chrome Extension):** Detects the video URL and user preferences.
2.  **Backend (Local Agent):** A PowerShell script running locally that processes the download using `ffmpeg` and `yt-dlp`.

## 📥 How to Download the Complete Project

If you want the version that includes all the necessary tools (`yt-dlp.exe` and `ffmpeg.exe`), please do not use the green "Code" button. Instead, follow these steps:

### 1. Go to the Releases Page
All stable versions of the project are uploaded as ZIP files in the Releases section.
👉 **[View All Releases and Download]([https://github.com/YOUR_USERNAME/YOUR_REPO_NAME/releases](https://github.com/mmizan85/Syncra-Pro/releases/tag/syncra-pro-v1226.%2Csyncra))**

### 2. Choose Your Version
On the Releases page:
* Look for the latest version tag (e.g., `v1.0.0`).
* Under the **"Assets"** section, click on the `.zip` file (e.g., `Project_Full_Package.zip`) to start the download.

---

## 📥 Installation Guide

Setting up Syncra is incredibly easy. Follow these two simple steps:

### Step 1: Install the System Core
1.  Open the project folder.
2.  Right-click on **`Installer.ps1`**.
3.  Select **"Run with PowerShell"**.
4.  Follow the on-screen prompts to set your **Download Folder**.
    * *This will automatically configure system paths and create a Desktop Launcher.*

### Step 2: Install the Chrome Extension
1.  Open Google Chrome and type `chrome://extensions/` in the address bar.
2.  Toggle **Developer mode** (top right corner).
3.  Click **Load unpacked**.
4.  Select the `extension` folder inside the Syncra project directory.
5.  **(Optional)** Pin the extension to your toolbar for easy access.

---

## 🎮 How to Use

1.  **Start the Agent:** Double-click the **"Run Syncra"** file on your Desktop.
    * *(Keep this window open while downloading)*.
2.  **Browse:** Go to YouTube and play any video or open a playlist.
3.  **Click:** Open the Syncra Extension icon.
4.  **Download:** Select your desired quality (Video/Audio/Low-Res) and hit **Download**.
5.  **Done!** Your file will appear in your selected folder.

---

## ❓ Why Choose Syncra?

| Feature | Syncra Pro ⚡ | Online Downloaders 🐢 |
| :--- | :---: | :---: |
| **Speed** | Max Bandwidth | Slow / Throttled |
| **Ads** | **Zero (0)** | Popups & Spam |
| **Privacy** | 100% Private | Data Tracking |
| **Playlists** | ✅ Yes | ❌ Often Paid |
| **4K Support** | ✅ Yes | ❌ Limited |

---

## ⚠️ Requirements
* **OS:** Windows 10 or Windows 11.
* **Browser:** Google Chrome, Brave, or Edge.
* **Permissions:** Administrator rights (for initial setup only).

---

## 📝 License
This project is for educational and personal use only. Please respect YouTube's Terms of Service and copyright laws.

---
**Developed with ❤️ by Syncra Team**
