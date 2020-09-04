@echo off
::20200618 - Diasdm

::SCRIPT DE SINCRONIZA��O FOR�ADA DO NTP

::PARA O SERVI�O DE HOR�RIO
	net stop w32time

::CANCELA AS CONFIGURA��ES PARA GARANTIR O FUNCIONAMENTO
	w32tm /unregister
	echo .

::REGISTRA O SERVI�O DE HORA NOVAMENTE
	w32tm /register

::INICIA O CMD E ATRIBUI O SERVI�O DE HOR�RIO A UM PROCESSO SEPARADO DO SVCHOST :x
::	cmd /c sc config w32time type= own

::INICIA O SERVI�O DE HOR�RIO
	net start w32time

::VERIFICA O SERVIDOR ATUAL DE SINCRONIZA��O
	w32tm /query /source
	echo .

::HABILITA DEBUG GRAVANDO LOG NO DIRET�RIO TEMP
	w32tm /debug /enable /file:%TEMP%\w32tmdebug.log /size:10485760 /entries:0-300
	echo .

::CONFIGURA O SERVIDOR NTP
	w32tm /config /manualpeerlist:pool.ntp.br,0x8 /syncfromflags:MANUAL
	echo .

::REIN�CIO DO SERVI�O DE HORA
	net stop w32time
	net start w32time

::RESINCRONIZA��O DA HORA
	w32tm /resync /nowait
	echo .

::DESABILITAR DEBUG
	w32tm /debug /disable
	echo .

::CONSULTA PARA VISUALIZAR SE AS CONFIGURA��ES SURTIRAM EFEITO
	w32tm /query /status /verbose

::PAUSA DO SCRIPT PARA VERIFICA��O DAS MENSAGENS
	pause



::OBS: para alterar o servidor de NTP, altere o valor "pool.ntp.br" por outro de sua escolha.