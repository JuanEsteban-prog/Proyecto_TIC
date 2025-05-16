$LOG_DIR = "recovery_logs"
$LOG_FILE = "$LOG_DIR\recovery.log"
$SERVER_SCRIPT = "simple_http_server.py"

# Crear carpeta de logs si no existe
if (-not (Test-Path $LOG_DIR)) {
  New-Item -ItemType Directory -Path $LOG_DIR | Out-Null
}

"--- Simulando fallo del servidor ---" | Out-File -FilePath $LOG_FILE -Encoding UTF8

# Normaliza el nombre del script para comparación
$normalizedScript = $SERVER_SCRIPT.ToLower()

# Buscar procesos de Python que contengan el nombre del script
$processes = Get-CimInstance Win32_Process | Where-Object {
  $_.Name -like "python*" -and $_.CommandLine -and $_.CommandLine.ToLower().Contains($normalizedScript)
}

if ($processes.Count -eq 0) {
  "$(Get-Date) -  Servidor no está activo. No se puede simular fallo." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 1
}

# Matar procesos encontrados
foreach ($proc in $processes) {
  "$(Get-Date) -  Matando proceso PID $($proc.ProcessId)..." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  Stop-Process -Id $proc.ProcessId -Force
}

Start-Sleep -Seconds 2

# Reiniciar servidor
"$(Get-Date) -  Reiniciando servidor..." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8

$logOut = "$LOG_DIR\server_out.log"
$logErr = "$LOG_DIR\server_err.log"

Start-Process -NoNewWindow -FilePath "python" -ArgumentList $SERVER_SCRIPT `
  -RedirectStandardOutput $logOut -RedirectStandardError $logErr

Start-Sleep -Seconds 2

# Verificar que se haya reiniciado
$newProcesses = Get-CimInstance Win32_Process | Where-Object {
  $_.Name -like "python*" -and $_.CommandLine -and $_.CommandLine.ToLower().Contains($normalizedScript)
}

if ($newProcesses.Count -eq 0) {
  "$(Get-Date) -  El servidor no se reinició correctamente." | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 1
}
else {
  $pids = $newProcesses | ForEach-Object { $_.ProcessId } | Sort-Object
  "$(Get-Date) -  Servidor reiniciado con PID(s): $($pids -join ', ')" | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
  exit 0
}
