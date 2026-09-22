# Publica o checklist: pega o pecas.js baixado, substitui no repositorio e envia.
$ErrorActionPreference = "Stop"
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repo

Write-Host ""
Write-Host "  Publicando o checklist da festa de 8 anos" -ForegroundColor Cyan
Write-Host ""

# 1. Acha o pecas.js mais recente na pasta Downloads (o navegador pode nomear "pecas (1).js")
$downloads = Join-Path $env:USERPROFILE "Downloads"
$baixado = Get-ChildItem -Path $downloads -Filter "pecas*.js" -ErrorAction SilentlyContinue |
           Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $baixado) {
  Write-Host "  Nao achei nenhum pecas.js em $downloads." -ForegroundColor Yellow
  Write-Host "  Abra o index.html, clique em 'Salvar alteracoes' e rode este arquivo de novo."
  Write-Host ""
  Read-Host "  Enter para fechar" | Out-Null
  exit 1
}

$idade = [int]((Get-Date) - $baixado.LastWriteTime).TotalMinutes
Write-Host ("  Arquivo encontrado: {0}  (baixado ha {1} min)" -f $baixado.Name, $idade)

# 2. Confere se e mesmo um pecas.js valido antes de sobrescrever
$conteudo = Get-Content $baixado.FullName -Raw
if ($conteudo -notmatch "window\.PECAS\s*=") {
  Write-Host "  Esse arquivo nao parece o pecas.js do checklist. Nada foi alterado." -ForegroundColor Red
  Read-Host "  Enter para fechar" | Out-Null
  exit 1
}

# 3. Substitui e mostra o que mudou
Copy-Item $baixado.FullName (Join-Path $repo "pecas.js") -Force

$mudou = git status --porcelain pecas.js
if (-not $mudou) {
  Write-Host "  O checklist ja esta igual ao publicado. Nada a enviar." -ForegroundColor Yellow
  Write-Host ""
  Read-Host "  Enter para fechar" | Out-Null
  exit 0
}

Write-Host ""
Write-Host "  Mudancas:" -ForegroundColor Cyan
git --no-pager diff --stat pecas.js
Write-Host ""

# 4. Commit e push
$quando = Get-Date -Format "dd/MM HH:mm"
git add pecas.js | Out-Null
git commit -q -m "checklist: atualiza andamento ($quando)"
git push -q origin main

Write-Host "  Publicado." -ForegroundColor Green
Write-Host "  O time ve a versao nova em ate 2 minutos:"
Write-Host "  https://johnyamaral-labseazone.github.io/festa-8-anos/"
Write-Host ""

# 5. Tira o arquivo baixado do caminho, para nao republicar o mesmo depois
Remove-Item $baixado.FullName -Force -ErrorAction SilentlyContinue

Read-Host "  Enter para fechar" | Out-Null
