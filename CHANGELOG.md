
# Changelog

All notable changes to the **Syncra Pro** project will be documented in this file.
## [1.2.25] - 2026-01-25
### 🚀 Added
- **Playlist Downloader:** Users can now download entire YouTube playlists in one click.
- **Enhanced Quality Selector:** Added support for 4K (2160p), 2K (1440p), and high-bitrate MP3 (320kbps).
- **Clipboard Integration:** Installer now automatically copies the extension path for faster setup.


### ✨ Improved
- **Modern UI:** Updated the extension popup with a "Glassmorphism" dark theme for a better visual experience.
- **PowerShell Agent:** Optimized the `SyncraAgent.ps1` to handle large file processing more efficiently.
- **Automated Installer:** Improved the `.bat` and `.ps1` installers to handle system path permissions automatically.

### 🛠️ Fixed
- Fixed an issue where the download path was not properly saved in `download_path.txt` on some Windows versions.
- Resolved a bug where certain special characters in video titles caused the download to fail.

---

## [1.1.0] - 2026-01-10
### 🚀 Added
- Support for Single Video download (MP4/WebM).
- Basic Audio extraction (MP3).
- Added a "Run Syncra" shortcut generator for the Desktop.

### ⚙️ Changed
- Migration from Manifest V2 to **Manifest V3** for better Chrome security and performance.

---

## [1.0.0] - 2025-12-20
### 🎉 Initial Release
- Core engine for connecting Chrome extension with local PowerShell Agent.
- Basic YouTube URL detection and fetching.
- Integration with `yt-dlp` and `ffmpeg` for media processing.
## [1.0.0] - 2025-12-20
### 🎉 Initial Release
- Core engine for connecting Chrome extension with local PowerShell Agent.
- Basic YouTube URL detection and fetching.
- Integration with `yt-dlp` and `ffmpeg` for media processing.
