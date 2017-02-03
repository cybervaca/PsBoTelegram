# PsBoTelegram
Backdoor using Telegram and Powershell

PSBotTelegram es un script escrito en Powershell que nos crea una backdoor que se conecta a Telegram y se gestiona desde Telegram.

Al ejecutar el script nos va a pedir tres datos necesarios para crear el shellcode.

Los datos que nos pide son los siguientes:

# Parametros
[+] Introduzca el Token del Bot de Telegram: "Aquí debermos poner el Token del bot que hayamos creado."
[+] Introduzca su Chat ID: "Aquí deberemos poner nuestro ID de Telegram."
[+] Introduzca el delay para la conexión: "En este campo seteamos el delay(retardo) entre en pc con el backdoor y nuestro chat de telegram" 

Una vez introducido estos datos, nos creará un shellcode en BASE64 para ejecutarlo en el equipo objetivo.

# Funciones del backdoor.

[1] **/Help**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[2] **/Info**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[3] /Shell
[4] /Whoami
[5] /Ippublic
[6] /Kill
[7] /Scriptimport
[8] /Shell nc (netcat)
[9] /Download
[10] /Screenshot
