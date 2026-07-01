param(
    [string]$OutFile,
    [string]$Title,
    [string]$Description,
    [string]$ContentFile
)

$content = [System.IO.File]::ReadAllText("d:\game clone\fnf-github\fnfgame24.github.io-main- đã cóleection\index.html", [System.Text.Encoding]::UTF8)

# Replace title
$content = $content -replace '(?i)<title>.*?</title>', "<title>$Title | FNF Game</title>"
# Replace description
$content = $content -replace '(?i)<meta name="description" content=".*?" />', "<meta name=`"description`" content=`"$Description`" />"

# Replace canonical
$content = $content -replace '(?i)<link rel="canonical" href="https://fnfgame24.com" />', "<link rel=`"canonical`" href=`"https://fnfgame24.com/$OutFile`" />"

# Replace Player, Mods list, and article with the new ContentBody
$regex = [regex] '(?s)<!-- Player -->.*?</article>'
$newContentBody = "<!-- Content -->`n    <article class=`"content`">`n" + [System.IO.File]::ReadAllText($ContentFile, [System.Text.Encoding]::UTF8) + "`n    </article>"
$content = $regex.Replace($content, $newContentBody)

[System.IO.File]::WriteAllText("d:\game clone\fnf-github\fnfgame24.github.io-main- đã cóleection\$OutFile", $content, [System.Text.Encoding]::UTF8)
Write-Host "Created $OutFile successfully."
