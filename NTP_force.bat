@echo off
::20200618 - Diasdm

::SCRIPT DE SINCRONIZAÇÃO FORÇADA DO NTP

::PARA O SERVIÇO DE HORÁRIO
	net stop w32time

::CANCELA AS CONFIGURAÇÕES PARA GARANTIR O FUNCIONAMENTO
	w32tm /unregister
	echo .

::REGISTRA O SERVIÇO DE HORA NOVAMENTE
	w32tm /register

::INICIA O CMD E ATRIBUI O SERVIÇO DE HORÁRIO A UM PROCESSO SEPARADO DO SVCHOST :x
::	cmd /c sc config w32time type= own

::INICIA O SERVIÇO DE HORÁRIO
	net start w32time

::VERIFICA O SERVIDOR ATUAL DE SINCRONIZAÇÃO
	w32tm /query /source
	echo .

::HABILITA DEBUG GRAVANDO LOG NO DIRETÓRIO TEMP
	w32tm /debug /enable /file:%TEMP%\w32tmdebug.log /size:10485760 /entries:0-300
	echo .

::CONFIGURA O SERVIDOR NTP
	w32tm /config /manualpeerlist:pool.ntp.br,0x8 /syncfromflags:MANUAL
	echo .

::REINÍCIO DO SERVIÇO DE HORA
	net stop w32time
	net start w32time

::RESINCRONIZAÇÃO DA HORA
	w32tm /resync /nowait
	echo .

::DESABILITAR DEBUG
	w32tm /debug /disable
	echo .

::CONSULTA PARA VISUALIZAR SE AS CONFIGURAÇÕES SURTIRAM EFEITO
	w32tm /query /status /verbose

::PAUSA DO SCRIPT PARA VERIFICAÇÃO DAS MENSAGENS
	pause



::OBS: para alterar o servidor de NTP, altere o valor "pool.ntp.br" por outro de sua escolha.