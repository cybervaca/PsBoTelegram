# PsBoTelegram
Backdoor using Telegram and Powershell  

        ____  _____ ____      ______     __
       / __ \/ ___// __ )____/_  __/__  / /__   ____ __________ _____ __
      / /_/ /\__ \/ __  / __ \/ / / _ \/ / _ \/ __  / ___/ __  / __  __ \
     / ____/___/ / /_/ / /_/ / / /  __/ /  __/ /_/ / /  / /_/ / / / / / /
    /_/    /____/_____/\____/_/  \___/_/\___/\__, /_/   \__,_/_/ /_/ /_/
                                        /____/

                                                     v0.2 by CyberVaca @ Luis Vacas

PSBotTelegram es un script escrito en Powershell que nos crea una backdoor que se conecta a Telegram y se gestiona desde Telegram.  
Al ejecutar el script nos va a pedir tres datos necesarios para crear el shellcode.  

Los datos que nos pide son los siguientes:  

# Parametros
**[+] Introduzca el Token del Bot de Telegram:** "Aquí deberemos poner el Token del bot que hayamos creado."  
**[+] Introduzca su Chat ID:** "Aquí deberemos poner nuestro ID de Telegram."  
**[+] Introduzca el delay para la conexión:** "En este campo seteamos el delay(retardo) entre en pc con el backdoor y nuestro chat de telegram"   

Una vez introducido estos datos, nos creará un shellcode en BASE64 para ejecutarlo en el equipo objetivo.  

# Funciones del backdoor.

[1] **/Help**  
[2] **/Info**    
[3] **/Shell**  
[4] **/Whoami**   
[5] **/Ippublic**  
[6] **/Kill**  
[7] **/Scriptimport**  
[8] **/Shell nc (netcat)**  
[9] **/Download**  
[10] **/Screenshot**   
