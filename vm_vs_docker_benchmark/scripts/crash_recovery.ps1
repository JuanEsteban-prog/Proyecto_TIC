$LOG_FILE = "results\recovery.log"
$SERVER_SCRIPT = "server\simple_http_server.py"

if (-not (Test-Path "results")) {
  New-Item -ItemType Directory -Path "results" | Out-Null
}

"$(Get-Date) - 💀 Simulando fallo del servidor..." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8

$processes = Get-CimInstance Win32_Process | Where-Object {
  $_.CommandLine -and $_.CommandLine -match $SERVER_SCRIPT -and $_.Name -match "python"
}

if ($processes.Count -eq 0) {
  "$(Get-Date) - ⚠️ Servidor no está activo. No se puede simular fallo." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 1
}

foreach ($proc in $processes) {
  "$(Get-Date) - ☠️ Matando proceso PID $($proc.ProcessId)..." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  Stop-Process -Id $proc.ProcessId -Force
}

Start-Sleep -Seconds 2

"$(Get-Date) - 🔁 Reiniciando servidor..." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8

Start-Process -NoNewWindow -FilePath "python" -ArgumentList $SERVER_SCRIPT `
  -WorkingDirectory "$PSScriptRoot\.." `
  -RedirectStandardOutput "$PSScriptRoot\..\results\server_out.log" `
  -RedirectStandardError "$PSScriptRoot\..\results\server_err.log"

Start-Sleep -Seconds 2

$newProcesses = Get-CimInstance Win32_Process | Where-Object {
  $_.CommandLine -and $_.CommandLine -match $SERVER_SCRIPT -and $_.Name -match "python"
}

if ($newProcesses.Count -eq 0) {
  "$(Get-Date) - ❌ El servidor no se reinició correctamente." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 1
}
else {
  $pids = $newProcesses | ForEach-Object { $_.ProcessId } | Sort-Object
  "$(Get-Date) - ✅ Servidor reiniciado con PID(s): $($pids -join ', ')" | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 0
}
