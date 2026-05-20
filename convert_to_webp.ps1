$imagesDir = "d:\game clone\fnfgame24.github.io-main\assets\images"
$ffmpeg = "D:\game clone\fnf\ffmpeg\ffmpeg\bin\ffmpeg.exe"

$files = Get-ChildItem -Path $imagesDir -Include *.png, *.jpg, *.jpeg -Recurse
$count = 0
foreach ($file in $files) {
    $outPath = Join-Path $file.DirectoryName "$($file.BaseName).webp"
    
    if (-not (Test-Path $outPath)) {
        Write-Host "Converting $($file.Name) to webp..."
        & $ffmpeg -y -v quiet -i $file.FullName -c:v libwebp -lossless 0 -q:v 80 $outPath
    }
    
    if (Test-Path $outPath) {
        $outItem = Get-Item $outPath
        if ($outItem.Length -gt 0) {
            Write-Host "Deleting original $($file.Name)..."
            Remove-Item $file.FullName -Force
            $count++
        }
    }
}
Write-Host "Successfully converted and deleted $count files."
