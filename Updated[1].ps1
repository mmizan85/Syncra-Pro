# আপনার bin ফোল্ডারের পাথ এখানে দিন
$binPath = ".\bin"

# ১. yt-dlp আপডেট করা (এটি নিজের কমান্ড দিয়েই আপডেট হয়)
Write-Host "Updating yt-dlp..." -ForegroundColor Cyan
if (Test-Path "$binPath\yt-dlp.exe") {
    Start-Process -FilePath "$binPath\yt-dlp.exe" -ArgumentList "-U" -Wait
} else {
    Write-Host "yt-dlp.exe not found! Downloading fresh copy..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" -OutFile "$binPath\yt-dlp.exe"
}

# ২. FFmpeg আপডেট করা (এটি জিপ ফাইল ডাউনলোড করে এক্সট্রাক্ট করবে)
Write-Host "Checking for FFmpeg update..." -ForegroundColor Cyan
$ffmpegUrl = "https://github.com/GyanD/codexffmpeg/releases/download/7.1/ffmpeg-7.1-essentials_build.zip" # উদাহরণ লিঙ্ক
$zipFile = "$binPath\ffmpeg.zip"

Write-Host "Downloading latest FFmpeg..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $ffmpegUrl -OutFile $zipFile

# জিপ ফাইল থেকে শুধু ffmpeg.exe বের করে আনা
Expand-Archive -Path $zipFile -DestinationPath "$binPath\temp" -Force
Move-Item -Path "$binPath\temp\*\bin\ffmpeg.exe" -Destination "$binPath\ffmpeg.exe" -Force

# অপ্রয়োজনীয় ফাইল মুছে ফেলা
Remove-Item -Path $zipFile
Remove-Item -Path "$binPath\temp" -Recurse -Force

# কাজ শেষে সাউন্ড এবং মেসেজ
[System.Media.SystemSounds]::Asterisk.Play()
Write-Host "Both tools updated successfully!" -ForegroundColor Green
