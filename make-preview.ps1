# Draws og-image.png (1200x630), the picture phones and chat apps show when the site link is shared.
# Run: powershell -ExecutionPolicy Bypass -File make-preview.ps1
Add-Type -AssemblyName System.Drawing
$W = 1200; $H = 630
$bmp = New-Object System.Drawing.Bitmap $W, $H
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'None'; $g.TextRenderingHint = 'AntiAliasGridFit'
function C($hex) { [System.Drawing.ColorTranslator]::FromHtml($hex) }
function B($hex) { New-Object System.Drawing.SolidBrush (C $hex) }
$ink = '#1f1c19'; $paper = '#f8f5ec'; $hazard = '#f2c230'; $orange = '#e5652a'

# concrete background with faint grid
$g.Clear((C '#e2ddd0'))
$gridPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(18, 31, 28, 25))
for ($x = 0; $x -lt $W; $x += 20) { $g.DrawLine($gridPen, $x, 0, $x, $H) }
for ($y = 0; $y -lt $H; $y += 20) { $g.DrawLine($gridPen, 0, $y, $W, $y) }

# hazard stripes top and bottom
function Stripes($y0, $h) {
  $g.FillRectangle((B $ink), 0, $y0, $W, $h)
  for ($x = -$h; $x -lt $W + $h; $x += 56) {
    $pts = [System.Drawing.Point[]]@(
      (New-Object System.Drawing.Point ($x), ($y0 + $h)),
      (New-Object System.Drawing.Point ($x + 28), ($y0 + $h)),
      (New-Object System.Drawing.Point ($x + 28 + $h), ($y0)),
      (New-Object System.Drawing.Point ($x + $h), ($y0)))
    $g.FillPolygon((B $hazard), $pts)
  }
}
Stripes 0 30
Stripes ($H - 30) 30

# dark game-screen panel with orange offset shadow
$g.FillRectangle((B $orange), 72, 86, 1066, 470)
$g.FillRectangle((B $ink), 60, 74, 1066, 470)

# pixel sprites
$PAL = @{ k=$ink; y=$hazard; o=$orange; w='#ffffff'; s='#e9b48a'; b='#2f5d8a'; d='#5b5f5d'; n='#7a4b2a'; g='#9a9e9b' }
function Sprite($rows, $x0, $y0, $px) {
  for ($r = 0; $r -lt $rows.Count; $r++) {
    $row = $rows[$r]
    for ($c = 0; $c -lt $row.Length; $c++) {
      $ch = [string]$row[$c]
      if ($PAL.ContainsKey($ch)) { $g.FillRectangle((B $PAL[$ch]), $x0 + $c * $px, $y0 + $r * $px, $px, $px) }
    }
  }
}
$worker = @("....kkkk....","...kyyyyk...","..kyyyyyyk..",".kkkkkkkkkk.","..kssssssk..","..kskssksk..","..kssssssk..","...kskksk...","..kooooook..",".kooookoook.",".ksoooooosk.","..kbbbbbbk..","..kbbkkbbk..","..kkk..kkk..")
$hammer = @("..kkkkkk....",".kddddddk...",".kdwddddk...",".kddddddk...","..kkknkk....","....knk.....","....knk.....","....knk.....","....knk.....","....knk.....","....kkk.....")
# light plate behind the worker so the black outline reads on the dark panel
$g.FillRectangle((B $paper), 846, 118, 236, 330)
Sprite $worker 856 132 20
Sprite $hammer 760 300 12

# text
$tag = New-Object System.Drawing.Font 'Consolas', 20, ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
$big = New-Object System.Drawing.Font 'Consolas', 84, ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
$sub = New-Object System.Drawing.Font 'Consolas', 30, ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)
$g.FillRectangle((B $hazard), 100, 112, 352, 38)
$g.DrawString('RENOVATION IN PROGRESS', $tag, (B $ink), 110, 119)
$g.DrawString('RENOVATION', $big, (B $orange), 104, 170)
$g.DrawString('RENOVATION', $big, (B $hazard), 98, 164)
$g.DrawString('QUEST', $big, (B $orange), 104, 258)
$g.DrawString('QUEST', $big, (B $hazard), 98, 252)
$g.DrawString('Jobs done, jobs next, the crew', $sub, (B $paper), 102, 366)
$g.DrawString('and the floor plan. 8-bit style.', $sub, (B $paper), 102, 404)

# level bar
$g.FillRectangle((B $paper), 100, 470, 980, 44)
$g.FillRectangle((B $ink), 104, 474, 972, 36)
for ($i = 0; $i -lt 20; $i++) {
  $col = if ($i -lt 7) { if (($i + 1) % 4 -eq 0) { $orange } else { $hazard } } else { '#3a352f' }
  $g.FillRectangle((B $col), 108 + $i * 48.4, 478, 44, 28)
}

$out = Join-Path $PSScriptRoot 'og-image.png'
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
"saved $out"
