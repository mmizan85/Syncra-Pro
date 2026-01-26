# This program was written using yt-dlp & ffmpeg tools
# This program will create a local server to communicate with the Xhrome extension so that the program can fully run, saving information received from the Chrome extension.
# AUTHOR: Mohammod Mizanur Rahman Automation & Full Stack Deceloper

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:9000/")
$listener.Start()

Write-Host "[::::::::::::::::::::::::::::::::::::::::::::::::]" -ForegroundColor DarkBlue
Write-Host "PowerShell Downloader Agent running on port 9000" -ForegroundColor DarkGreen
Write-Host "[:::::    Syncra Downloader V-1.2.26    :::::::::]" -ForegroundColor Green
Write-Host "    Authorize : Mohammod Mizanur Rahman         " -ForegroundColor White
Write-Host "[::::::::::::::::::::::::::::::::::::::::::::::::]`n" -ForegroundColor DarkBlue
Write-Host "Waiting for requests..." -ForegroundColor Green

$configFilePath = "download_path.txt"


if (Test-Path $configFilePath) {
    $savedPath = Get-Content $configFilePath

    if([string]::IsNullOrWhiteSpace($savedPath)){
        $basePath = "$home\Downloads"
    }else {
        $basePath = $savedPath
    }
}else {
    $basePath = "$home\Downloads"
}

$downloadDir = Join-Path $basePath "\Downloads"

if (-not(Test-Path $downloadDir)) {
    New-Item -ItemType Directory -Path $downloadDir | Out-Null
}

Write-Host "File Save Folder Path: `"$downloadDir`"" -ForegroundColor Cyan



while ($true) {
    
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    if ($request.HttpMethod -eq "POST" -and $request.Url.AbsolutePath -eq "/download") {

        $reader = New-Object IO.StreamReader($request.InputStream)
        $json = $reader.ReadToEnd()
        
        try {
            $data = $json | ConvertFrom-Json
            $url = $data.url
            $mode = $data.mode
            $quality = $data.quality

            Write-Host "Request Received: Titel `n $url | Mode ($mode =>> $quality)" -ForegroundColor Blue
            
            
            Start-Job -ScriptBlock {
                param($url, $mode, $quality, $downloadDir)


                try {
                    if ($mode -eq "audio") {
                        if ($quality -eq "best") {
                        yt-dlp `
                            -x --audio-format flac `
                            --audio-quality  320k `
                            --embed-thumbnail `
                            --add-metadata `
                            --yes-playlist `
                            -o "$downloadDir\%(title)s.flac" `
                            $url
                        }elseif($quality -eq "320"){
                        yt-dlp `
                            -x --audio-format mp3 `
                            --audio-quality 320k `
                            --embed-thumbnail `
                            --add-metadata `
                            --yes-playlist `
                            -o "$downloadDir\%(title)s.mp3" `
                            $url 
                        
                        }else{
                        yt-dlp `
                            -x --audio-format mp3 `
                            --audio-quality  $quality `
                            --yes-playlist `
                            -o "$downloadDir\%(title)s.mp3" `
                            $url 
                        }
                    }elseif ($mode -eq "butPhone") {
                        
                        if ($quality -eq "best"){
                            yt-dlp `
                              -f "bestvideo[height<=360][ext=mp4]+bestaudio[ext=m4a]/best[height<=360][ext=mp4]" `
                              --postprocessor-args "ffmpeg:-s 320x240 -vcodec libx264 -b:v 300k -b:a 156K -acodec aac -ac 2 -ar 44100" `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s.%(ext)s" `
                              $url
                        }
                        elseif ($quality -eq "144"){
                           yt-dlp `
                              -f "bestvideo[height<=$quality][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=360][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=240][ext=mp4]+bestaudio[ext=m4a]/best[height<=240][ext=mp4]/best[height<=360][ext=mp4]/bast" `
                              --postprocessor-args "ffmpeg:-s 176x144 -vcodec h263 -acodec amr_nb -ar 8000 -ac 1 -ab 12.2k" `
                              --merge-output-format 3gp `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s[$quality].3gp" `
                              $url
                        }
                        else {
                           yt-dlp `
                              -f "bestvideo[height<=$quality][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=360][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=240][ext=mp4]+bestaudio[ext=m4a]/best[height<=240][ext=mp4]/best[height<=360][ext=mp4]/bast" `
                              --postprocessor-args "ffmpeg: -vcodec libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p -acodec aac -ac 1 -ar 22050" `
                              --merge-output-format mp4 `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s[$quality].%(ext)s" `
                              $url
                        }
                    }
                    else {
                        
                        if ($quality -eq "best") {
                            yt-dlp `
                              -f "bestvideo+bestaudio/best" `
				              --embed-thumbnail `
                              --add-metadata `
                              -o "$downloadDir\%(title)s" `
                              $url
                        }elseif ($quality -eq "bestMkv"){
                            yt-dlp `
                            -f "bestvideo+bestaudio/best" `
                            	--merge-output-format mkv `
				                --embed-thumbnail `
                            	--add-metadata `
                              -o "$downloadDir\%(title)s.mkv" `
                              $url
                        }elseif  ($quality -eq "2160"){
                            yt-dlp `
                              -f "bestvideo[height<=2160]+bestaudio/best" `
                              --merge-output-format mkv `
                              --embed-thumbnail `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s.mkv" `
                              $url
                        }elseif  ($quality -eq "1440"){
                            yt-dlp `
                              -f "bestvideo[height<=1440]+bestaudio/best" `
                              --merge-output-format mkv `
                              --embed-thumbnail `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s.mkv" `
                              $url
                        }
                        else {
                            yt-dlp `
                              -f "bestvideo[ext=mp4][height<=$quality]+bestaudio[ext=m4a]/best[ext=mp4]/best" `
                              --yes-playlist `
                              -o "$downloadDir\%(title)s.%(ext)s" `
                              $url
                     
                        }

                    }
                 [System.Media.SystemSounds]::Asterisk.Play()
                 $wshell = New-Object -ComObject WScript.Shell
                 $wshell.Popup("Download Complete- %(title)", 1, "Download Completed", 64)
                    
                    
                }
                catch {

                    Write-Host "Error, Not Download" -ForegroundColor DarkRed
                   
                }

            } -ArgumentList $url, $mode, $quality, $downloadDir | Out-Null

            Write-Host "Download Started in Background..." -ForegroundColor Green

           
            $buffer = [Text.Encoding]::UTF8.GetBytes("Download Started")
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
            $response.Close()
        }
        catch {
            Write-Host "Error parsing JSON" -ForegroundColor DarkRed
            $response.StatusCode = 400
            $response.Close()
        }
    }
}


