$footerContent = @"
    <footer>
      <div style="margin-bottom: 12px; font-size: 14px;">
        <a href="/about-us.html">About Us</a> | 
        <a href="/contact-us.html">Contact Us</a> | 
        <a href="/dmca.html">DMCA</a> | 
        <a href="/privacy-policy.html">Privacy Policy</a> | 
        <a href="/terms-of-service.html">Terms of Service</a>
      </div>
      <p>© 2026 FNF Game 24 — Fan-made project for Friday Night Funkin'.</p>
    </footer>
"@

$regex = [regex] '(?s)<footer>.*?</footer>'

Get-ChildItem -Path "d:\game clone\fnf-github\fnfgame24.github.io-main- đã cóleection" -Filter "*.html" -Recurse | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match '(?s)<footer>.*?</footer>') {
        $newContent = $regex.Replace($content, $footerContent)
        [System.IO.File]::WriteAllText($_.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "Updated footer in $($_.FullName)"
    }
}
