$css = @"
    .collection-btn {
      background: linear-gradient(90deg, #F6A313, #f05454);
      color: #fff;
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: bold;
      box-shadow: 0 4px 12px rgba(246, 163, 19, 0.4);
      transition: transform 0.2s, box-shadow 0.2s;
      white-space: nowrap;
      display: flex;
      align-items: center;
      gap: 6px;
      text-decoration: none;
      border: none;
      margin-right: 8px;
    }
    .collection-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(246, 163, 19, 0.6);
      color: #fff;
    }
  </style>
"@

$html = @"
<a href="/fnf-collection" class="collection-btn">🔥 FNF Collection</a>
        <div class="search-container">
"@

Get-ChildItem -Path "d:\game clone\fnfgame24.github.io-main" -Filter "*.html" -Recurse | ForEach-Object {
    if ($_.Name -ne "mods.html") {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        if (-not ($content -match "collection-btn")) {
            $content = $content.Replace("</style>", $css)
            $content = $content.Replace('<div class="search-container">', $html)
            [System.IO.File]::WriteAllText($_.FullName, $content)
            Write-Host "Updated $($_.FullName)"
        }
    }
}
