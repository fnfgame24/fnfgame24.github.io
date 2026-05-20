$headerContent = @"
    <header class="top">
      <!-- Logo -->
      <a class="brand" href="/">
        <span class="appicon">
          <img src="https://fnfgame24.github.io/assets/fnf.png" alt="FNF logo">
        </span>
      </a>

      <!-- 4 game nổi bật nằm cùng thanh -->
      <div class="top-games">
        <a class="quick-mod" href="https://fnfgame24.github.io/fnf-doki-doki-takeover">
          FNF: Doki Doki Takeover
        </a>
        <a class="quick-mod" href="https://fnfgame24.github.io/fnf-vs-hypnos-lullaby-v2">
          FNF Vs. Hypno’s Lullaby v2
        </a>
        <a class="quick-mod" href="https://fnfgame24.github.io/fnf-indie-cross-ritual-but-everyone-sings-it">
          FNF Indie Cross Ritual But Everyone Sings It
        </a>
        <a class="quick-mod" href="https://fnfgame24.github.io/fnf-vs-impostor-among-us-v4">
          FNF vs Impostor Among Us V4 
        </a>
      </div>

      <!-- Search ở bên phải -->
      <a href="/fnf-collection" class="collection-btn">🔥 FNF Collection</a>
        <div class="search-container">
        <div class="search-box">
          <span class="search-icon">🔍</span>
          <input type="text" placeholder="Search Games ..." class="search-input">
        </div>
        <div class="search-results" id="search-results"></div>
      </div>
    </header>
"@

$regex = [regex] '(?s)<header class="top">.*?</header>'

Get-ChildItem -Path "d:\game clone\fnfgame24.github.io-main" -Filter "*.html" -Recurse | ForEach-Object {
    if ($_.Name -ne "mods.html" -and $_.FullName -ne "d:\game clone\fnfgame24.github.io-main\index.html") {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        if ($content -match '(?s)<header class="top">.*?</header>') {
            $newContent = $regex.Replace($content, $headerContent)
            [System.IO.File]::WriteAllText($_.FullName, $newContent)
            Write-Host "Updated $($_.FullName)"
        }
    }
}
