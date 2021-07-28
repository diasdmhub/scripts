<##############################################
# by diasdm                                   #
# 2020/01/29 - Versão 1.0                     #
# 2020/02/04 - Versão 1.1 Uso do Test-connect #
###############################################
# Verificação simples de hosts ativos em uma  #
# sub-rede                                    #
##############################################>


# INFORMAR A FAIXA DE REDE NO FORMATO AAA.BBB.CCC
cls
Write-Host "Digite a faixa de sub-rede que deseja verificar no formato (AAA.BBB.CCC)."
$faixa = Read-Host -Prompt "=>"
#$faixa = $Host.ui.ReadLine()


# VERIFICAÇÃO DOS IPs ATIVOS EM UMA SUB-REDE CLASSE C
cls
Write-Host ""

for ($i = 1 ; $i -lt 255 ; $i++ ){
    if ( Test-Connection -Count 1 -Delay 1 -Quiet -ErrorAction Stop -ComputerName $faixa'.'$i ) {
    
        # RESPOSTA POSITIVA EM BRANCO
        Write-Host -ForegroundColor Black -BackgroundColor White "$faixa`.$i"
        
    }
    
    Else {
        
        # RESPOSTA NEGATIVA EM VERMELHO
        Write-Host -ForegroundColor White -BackgroundColor Red   "$faixa`.$i"
        
    }
}


# LEGENDA
Write-Host "`n`nLEGENDA"
Write-Host -ForegroundColor Black -BackgroundColor White "Host ATIVO"
Write-Host -ForegroundColor White -BackgroundColor Red   "Host NÃO RESPONDE`n"
