;Nave : 
;	- Move diversos objetos com Delays diferentes
;	- Nao apaga o cenario
;	- Le teclado para movimentar a Nave
;	- Declara Tabela de nr. Randoicos
;	- Le Tabela de nr. Randomico para calcular a posicao inicial do(s) alien(s)
;	- Caso o alien encostar na nave do jogador, o jogador perde
;	- Nao fica piscando, pois so' redezenha se pos != posAnt
;   - Cenario colorido
;	- O jogador vence se o contador chegar a 999 + 1
;   - Loop principal segue estrutura abaixo:

jmp main
Msn0: string "V O C E   V E N C E U !!!"
Msn1: string "Quer jogar novamente? <s/n>"
Msn3: string "V O C E   P E R D E U ..."

Letra: var #1		; Contem a letra que foi digitada

posNave: var #1			; Contem a posicao atual da Nave
posAntNave: var #1		; Contem a posicao anterior da Nave

contador1: var #1		; Contem o numero do contador (unidade)
contador2: var #1		; Contem o numero do contador (dezena)
contador3: var #1		; Contem o numero do contador (centena)
contaux: var #1			; Auxiliar que vai de 0 ate MAX_CONTADOR
MAX_CONTADOR: var #1	; Maximo que o auxiliar chega. Define a velocidade do contador (quanto maior seu valor, mais lento o contador)

NumAleatorio: var #1 	; Guarda um numero aleatorio de 0 a 4

posAlien: var #1		; Contem a posicao atual do Alien
posAntAlien: var #1		; Contem a posicao anterior do Alien
posAlien2: var #1		; Contem a posicao atual do Alien2
posAntAlien2: var #1	; Contem a posicao anterior do Alien2
posAlien3: var #1		; Contem a posicao atual do Alien3
posAntAlien3: var #1	; Contem a posicao anterior do Alien3
posAlien4: var #1		; Contem a posicao atual do Alien4
posAntAlien4: var #1	; Contem a posicao anterior do Alien4
posAlien5: var #1		; Contem a posicao atual do Alien5
posAntAlien5: var #1	; Contem a posicao anterior do Alien5
posAlien6: var #1		; Contem a posicao atual do Alien6
posAntAlien6: var #1	; Contem a posicao anterior do Alien6


IncRand: var #1			; Incremento para circular na Tabela de nr. Randomicos
Rand : var #30			; Tabela de nr. Randomicos entre 0 - 4
	static Rand + #0, #0
	static Rand + #1, #3
	static Rand + #2, #4
	static Rand + #3, #1
	static Rand + #4, #3
	static Rand + #5, #1
	static Rand + #6, #4
	static Rand + #7, #1
	static Rand + #8, #0
	static Rand + #9, #2
	static Rand + #10, #2
	static Rand + #11, #1
	static Rand + #12, #0
	static Rand + #13, #1
	static Rand + #14, #4
	static Rand + #15, #2
	static Rand + #16, #3
	static Rand + #17, #3
	static Rand + #18, #4
	static Rand + #19, #1
	static Rand + #20, #0
	static Rand + #20, #3
	static Rand + #21, #2
	static Rand + #22, #2
	static Rand + #23, #3
	static Rand + #24, #4
	static Rand + #25, #4
	static Rand + #26, #0
	static Rand + #27, #2
	static Rand + #28, #0
	static Rand + #29, #2


;Codigo principal
main:
	call ApagaTela
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1212  			; cor ciano!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela3Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	loadn R1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #256   			; cor vermelha!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	Loadn R0, #1139			
	store posNave, R0		; Zera Posicao Atual da Nave
	store posAntNave, R0	; Zera Posicao Anterior da Nave
	
	loadn R0, #1200
	store posAlien, R0		; Zera Posicao Atual do Alien
	store posAntAlien, R0		; Zera Posicao Atual do Alien
	store posAlien2, R0		; Zera Posicao Atual do Alien2
	store posAntAlien2, R0		; Zera Posicao Atual do Alien2
	store posAlien3, R0		; Zera Posicao Atual do Alien3
	store posAntAlien3, R0		; Zera Posicao Atual do Alien3
	store posAlien4, R0		; Zera Posicao Atual do Alien4
	store posAntAlien4, R0		; Zera Posicao Atual do Alien4
	store posAlien5, R0		; Zera Posicao Atual do Alien5
	store posAntAlien5, R0		; Zera Posicao Atual do Alien5
	store posAlien6, R0		; Zera Posicao Atual do Alien6
	store posAntAlien6, R0		; Zera Posicao Atual do Alien6
		
	Loadn R0, #0			; Contador para os Mods	= 0
	loadn R2, #0			; Para verificar se (mod(c/10)==0
	;---------------------------------------------------------------------------------------------------------
	loadn R3, #1			; Para o MAX_CONTADOR	
	;---------------------------------------------------------------------------------------------------------
	store MAX_CONTADOR, R3	; Adiciona o valor de R3 na variavel que regula a velocidade do contador
	store contador1, R0		; Zera a unidade do contador de tempo
	store contador2, R0		; Zera a dezena do contador de tempo
	store contador3, R0		; Zera a centena do contador de tempo
	store contaux, R0		; Zera o auxiliar que controla o tempo de acrescimo do contador no loop abaixo
	
	; Cada Loop determina uma dificuldade para o jogador
	; Quanto maior for o contador, maior a quantidade e velocidade das naves
	Loop:	
		call MoveNave	; Chama Rotina de movimentacao da Nave
		
		loadn R1, #20
		mod R1, R0, R1
		cmp R1, R2		
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien
		;call MoveAlien  ; Chama Rotina de movimentacao do Alien
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		load R3, contador3	; Testa se o contador chegou a uma unidade na casa da centena
		cmp R3, R1
		jeq Loop2			; caso sim, pula para a dificuldade 2
		
		jmp Loop
			
	Loop2:
		call MoveNave	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien

		loadn R1, #20
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		loadn R1, #3		; Testa se o contador chegou a terceira unidade na casa da centena
		load R3, contador3
		cmp R3, R1
		jeq Loop3			; caso sim, pula para a dificuldade 3
		
		jmp Loop2	
		
	Loop3:
		call MoveNave	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #5
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien

		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien

		loadn R1, #20
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		loadn R1, #5			; Testa se o contador chegou a quinta unidade na casa da centena
		load R3, contador3
		cmp R3, R1
		jeq Loop4				; caso sim, pula para a dificuldade 4
		
		jmp Loop3
		
	Loop4:
		call MoveNave	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien

		loadn R1, #5
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien

		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien

		loadn R1, #20
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien4	; Chama Rotina de movimentacao do Alien		
		
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
			
		loadn R1, #6			; Testa se o contador chegou a sexta unidade na casa da centena
		load R3, contador3
		cmp R3, R1
		jeq Loop5				; caso sim, pula para a dificuldade 5
		
		jmp Loop4	
		
	Loop5:
		call MoveNave	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien		

		loadn R1, #4
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien

		loadn R1, #2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien

		loadn R1, #5
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien4	; Chama Rotina de movimentacao do Alien	

		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien5	; Chama Rotina de movimentacao do Alien	
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		loadn R1, #7			; Testa se o contador chegou a setima unidade na casa da centena
		load R3, contador3
		cmp R3, R1
		jeq Loop6				; caso sim, pula para a dificuldade 6
		
		jmp Loop5
		
	Loop6:
		call MoveNave	; Chama Rotina de movimentacao da Nave
		
		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien	

		loadn R1, #4
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien	

		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien			

		loadn R1, #2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien4	; Chama Rotina de movimentacao do Alien	

		loadn R1, #5
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien5	; Chama Rotina de movimentacao do Alien	

		loadn R1, #9
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien6	; Chama Rotina de movimentacao do Alien	
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		loadn R1, #8			; Testa se o contador chegou a oitava unidade na casa da centena
		load R3, contador3
		cmp R3, R1
		jeq Loop7				; caso sim, pula para a dificuldade 7
		
		jmp Loop6
		
	Loop7:
		call MoveNave	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien	

		loadn R1, #3
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien	

		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien			

		loadn R1, #2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien4	; Chama Rotina de movimentacao do Alien	

		loadn R1, #3
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien5	; Chama Rotina de movimentacao do Alien	

		loadn R1, #1
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien6	; Chama Rotina de movimentacao do Alien	
		
		load R3, contaux	; Carrega em R3 o valor do auxiliar
		load R1, MAX_CONTADOR	; Carrega em R1 o valor maximo que contaux pode chegar
		cmp R1, R3				; Caso contaux tenha chegado no valor maximo
		ceq ContadorAdiciona	; Adiciona em 1 o contador
		
		load R3, contaux	; Soma 1 no valor do auxiliar contaux
		loadn R1, #1
		add R3, R3, R1
		store contaux, R3
		
		;call ContadorAdiciona		
		call Delay
		inc R0 	;c++
		
		jmp Loop7
		


;Funcoes
;--------------------------

;-------------- INICIO DAS FUNCOES QUE IMPRIMEM NA TELA O VALOR DO CONTADOR --------------
ContadorAdiciona:
	push R0	; Adiciona na pilha para recuperar o valor original dos registradores
	push R1
	push R2
	push R3
	
	loadn R0, #0		; Zera o valor do auxiliar do contador
	store contaux, R0
	
	load R0, contador1			; Carrega em R0 o valor atual da unidade do contador
	loadn R1, #9	
	cmp R1, R0					; Testa se o valor atual da unidade igual a 9
	ceq ContadorAdicionaDecimal ; caso sim, chama o label de adiçao na dezena
	
	cmp R1, R0					; caso nao, chama o label de adiçao na unidade
	cne ContadorAdicionaUnidade
	
	;load R0, contador1
	load R1, contador2			; Carrega em R1 o valor da dezena do contador
	load R3, contador3			; Carrega em R3 o valor da centena do contador
	
	loadn R2, #0					; Compara com cada digito decimal o valor do contador
	cmp R2, R0						; e chama a funcao que imprime esse valor
	ceq ContadorImprimeZeroUnidade	
	cmp R2, R1
	ceq ContadorImprimeZeroDezena
	cmp R2, R3
	ceq ContadorImprimeZeroCentena
	
	loadn R2, #1
	cmp R2, R0
	ceq ContadorImprimeUmUnidade	
	cmp R2, R1
	ceq ContadorImprimeUmDezena
	cmp R2, R3
	ceq ContadorImprimeUmCentena
	
	loadn R2, #2
	cmp R2, R0
	ceq ContadorImprimeDoisUnidade	
	cmp R2, R1
	ceq ContadorImprimeDoisDezena
	cmp R2, R3
	ceq ContadorImprimeDoisCentena
	
	loadn R2, #3
	cmp R2, R0
	ceq ContadorImprimeTresUnidade	
	cmp R2, R1
	ceq ContadorImprimeTresDezena
	cmp R2, R3
	ceq ContadorImprimeTresCentena
	
	loadn R2, #4
	cmp R2, R0
	ceq ContadorImprimeQuatroUnidade	
	cmp R2, R1
	ceq ContadorImprimeQuatroDezena
	cmp R2, R3
	ceq ContadorImprimeQuatroCentena
	
	loadn R2, #5
	cmp R2, R0
	ceq ContadorImprimeCincoUnidade	
	cmp R2, R1
	ceq ContadorImprimeCincoDezena
	cmp R2, R3
	ceq ContadorImprimeCincoCentena
	
	loadn R2, #6
	cmp R2, R0
	ceq ContadorImprimeSeisUnidade	
	cmp R2, R1
	ceq ContadorImprimeSeisDezena
	cmp R2, R3
	ceq ContadorImprimeSeisCentena
	
	loadn R2, #7
	cmp R2, R0
	ceq ContadorImprimeSeteUnidade	
	cmp R2, R1
	ceq ContadorImprimeSeteDezena
	cmp R2, R3
	ceq ContadorImprimeSeteCentena
	
	loadn R2, #8
	cmp R2, R0
	ceq ContadorImprimeOitoUnidade	
	cmp R2, R1
	ceq ContadorImprimeOitoDezena
	cmp R2, R3
	ceq ContadorImprimeOitoCentena
	
	loadn R2, #9
	cmp R2, R0
	ceq ContadorImprimeNoveUnidade	
	cmp R2, R1
	ceq ContadorImprimeNoveDezena	
	cmp R2, R3
	ceq ContadorImprimeNoveCentena
	
	pop R3
	pop R2
	pop R1
	pop R0
	rts

	ContadorAdicionaUnidade:	; Label de adicao na casa da unidade
		push R0					; Adiciona na pilha p/ nao perder o conteudo dos registradores usados
		push R1
		
		load R0, contador1		; Adiciona 1 no valor do contador1
		loadn R1, #1		
		add R0, R0, R1	
		store contador1, R0
		
		pop R1
		pop R0					; Devolve o conteudo original aos registradores
		rts	
		
	ContadorAdicionaDecimal:	; Label de adicao na casa da dezena
		push R0					; Adiciona na pilha p/ nao perder o conteudo dos registradores usados
		push R1
		push R2
			
		load R1, contador2
		loadn R2, #9
		
		cmp R2, R1					; Testa se o valor atual da unidade igual a 9
		ceq ContadorAdicionaCentena ; caso sim, chama o Label de adicao na Centena
		
		cmp R2, R1						; caso nao, chama o Label para adicao de 1 unidade na dezena 
		cne ContadorAdicionaDecimalAux
		
		pop R2
		pop R1
		pop R0					; Devolve o conteudo original aos registradores
		rts

	ContadorAdicionaDecimalAux: ; Label que adiciona uma unidade na casa da dezena
		push R0					; Adiciona na pilha p/ nao perder o conteudo dos registradores usados
		push R1
		push R2
			
		load R1, contador2
		
		loadn R0, #0
		loadn R2, #1
		add R1, R1, R2
		
		store contador1, R0	; Zera a casa da unidade
		store contador2, R1 ; Adiciona o valor da dezena com uma unidade a mais
		
		pop R2
		pop R1
		pop R0					; Devolve o conteudo original aos registradores
		rts

	ContadorAdicionaCentena:	; Label de adicao na casa da Centena
	push R0					; Adiciona na pilha p/ nao perder o conteudo dos registradores usados
	push R1
	push R2
		
	load R1, contador3
	loadn R2, #9
	
	cmp R2, R1						; Compara se o valor atual da centena igual a 9
	ceq MoveTiro_RecalculaPos_Boom	; caso sim, indica vitoria do jogador
	
	loadn R0, #0					; caso nao, soma em 1 o valor da centena
	loadn R2, #1
	add R1, R1, R2
	
	store contador1, R0		; Zera a casa da unidade
	store contador2, R0		; Zera a casa da dezena
	store contador3, R1		; Adiciona o valor da centena atualizado
	
	pop R2
	pop R1
	pop R0					; Devolve o conteudo original aos registradores
	rts

	;----------	Inicio das funcoes de impressao na tela do valor do contador ----------	
	ContadorImprimeZeroUnidade:
		push R0
		push R1
		loadn R1, #'0'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeZeroDezena:
		push R0
		push R1
		loadn R1, #'0'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeZeroCentena:
		push R0
		push R1
		loadn R1, #'0'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeUmUnidade:
		push R0
		push R1
		loadn R1, #'1'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeUmDezena:
		push R0
		push R1
		loadn R1, #'1'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeUmCentena:
		push R0
		push R1
		loadn R1, #'1'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeDoisUnidade:
		push R0
		push R1
		loadn R1, #'2'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeDoisDezena:
		push R0
		push R1
		loadn R1, #'2'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeDoisCentena:
		push R0
		push R1
		loadn R1, #'2'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeTresUnidade:
		push R0
		push R1
		loadn R1, #'3'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeTresDezena:
		push R0
		push R1
		loadn R1, #'3'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeTresCentena:
		push R0
		push R1
		loadn R1, #'3'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeQuatroUnidade:
		push R0
		push R1
		loadn R1, #'4'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeQuatroDezena:
		push R0
		push R1
		loadn R1, #'4'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeQuatroCentena:
		push R0
		push R1
		loadn R1, #'4'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeCincoUnidade:
		push R0
		push R1
		loadn R1, #'5'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeCincoDezena:
		push R0
		push R1
		loadn R1, #'5'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeCincoCentena:
		push R0
		push R1
		loadn R1, #'5'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts
		
	ContadorImprimeSeisUnidade:
		push R0
		push R1
		loadn R1, #'6'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeSeisDezena:
		push R0
		push R1
		loadn R1, #'6'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeSeisCentena:
		push R0
		push R1
		loadn R1, #'6'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeSeteUnidade:
		push R0
		push R1
		loadn R1, #'7'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeSeteDezena:
		push R0
		push R1
		loadn R1, #'7'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeSeteCentena:
		push R0
		push R1
		loadn R1, #'7'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts
		
	ContadorImprimeOitoUnidade:
		push R0
		push R1
		loadn R1, #'8'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeOitoDezena:
		push R0
		push R1
		loadn R1, #'8'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeOitoCentena:
		push R0
		push R1
		loadn R1, #'8'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeNoveUnidade:
		push R0
		push R1
		loadn R1, #'9'
		loadn R0, #30
		outchar R1, R0
		pop R1
		pop R0
		rts	

	ContadorImprimeNoveDezena:
		push R0
		push R1
		loadn R1, #'9'
		loadn R0, #29
		outchar R1, R0
		pop R1
		pop R0
		rts

	ContadorImprimeNoveCentena:
		push R0
		push R1
		loadn R1, #'9'
		loadn R0, #28
		outchar R1, R0
		pop R1
		pop R0
		rts
	;---------- Fim das funcoes de impressao na tela do valor do contador ----------
;--------------   FIM DAS FUNCOES QUE IMPRIMEM NA TELA O VALOR DO CONTADOR  --------------	
	
MoveNave:
	push r0
	push r1
	
	call MoveNave_RecalculaPos		; Recalcula Posicao da Nave

; So' Apaga e Redesenha se (pos != posAnt)
;	If (posNave != posAntNave)	{	
	load r0, posNave
	load r1, posAntNave
	cmp r0, r1
	jeq MoveNave_Skip
	call MoveNave_Apaga
	call MoveNave_Desenha		;}
    MoveNave_Skip:
		pop r1
		pop r0
		rts

;--------------------------------
	
	MoveNave_Apaga:		; Apaga a Nave preservando o Cenario!
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntNave	; R0 = posAnt
		
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
		
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveNave_RecalculaPos:		; Recalcula posicao da Nave em funcao das Teclas pressionadas
		push R0
		push R1
		push R2
		push R3

		load R0, posNave
		
		inchar R1				; Le Teclado para controlar a Nave
		loadn R2, #'a'
		cmp R1, R2
		jeq MoveNave_RecalculaPos_A
		
		loadn R2, #'d'
		cmp R1, R2
		jeq MoveNave_RecalculaPos_D
			
		;loadn R2, #'w'
		;cmp R1, R2
		;jeq MoveNave_RecalculaPos_W
			
		;loadn R2, #'s'
		;cmp R1, R2
		;jeq MoveNave_RecalculaPos_S
		
		
	  MoveNave_RecalculaPos_Fim:	; Se nao for nenhuma tecla valida, vai embora
		store posNave, R0
		pop R3
		pop R2
		pop R1
		pop R0
		rts

	  MoveNave_RecalculaPos_A:	; Move Nave para Esquerda
		loadn R1, #1138
		loadn R2, #1137
		mod R1, R0, R1		; Testa condicoes de Contorno 
		cmp R1, R2
		jeq MoveNave_RecalculaPos_Fim
		dec R0	; pos = pos -1
		jmp MoveNave_RecalculaPos_Fim
			
	  MoveNave_RecalculaPos_D:	; Move Nave para Direita	
		loadn R1, #1142
		loadn R2, #1141
		mod R1, R0, R1		; Testa condicoes de Contorno 
		cmp R1, R2
		jeq MoveNave_RecalculaPos_Fim
		inc R0	; pos = pos + 1
		jmp MoveNave_RecalculaPos_Fim
		
	  ;MoveNave_RecalculaPos_W:	; Move Nave para Cima
		;loadn R1, #40
		;cmp R0, R1		; Testa condicoes de Contorno 
		;jle MoveNave_RecalculaPos_Fim
		;sub R0, R0, R1	; pos = pos - 40
		;jmp MoveNave_RecalculaPos_Fim

	  ;MoveNave_RecalculaPos_S:	; Move Nave para Baixo
		;loadn R1, #1159
		;cmp R0, R1		; Testa condicoes de Contorno 
		;jgr MoveNave_RecalculaPos_Fim
		;loadn R1, #40
		;add R0, R0, R1	; pos = pos + 40
		;jmp MoveNave_RecalculaPos_Fim	

	;----------------------------------
	MoveNave_Desenha:	; Desenha caractere da Nave
		push R0
		push R1
		
		Loadn R1, #'X'	; Nave
		load R0, posNave
		outchar R1, R0
		store posAntNave, R0	; Atualiza Posicao Anterior da Nave = Posicao Atual
				
		pop R1
		pop R0
		rts

;----------------------------------
;----------------------------------
;----------------------------------
	
ResetaPosAlien:					; Label que a posicao do Alien
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos	; Chama a funcao para gerar um novo numero aleatorio
	
	loadn R0, #17				; Carrega a posicao 17, a primeira posicao da primeira linha dentro do retangulo que limita o game
	load R1, NumAleatorio
	add R0, R0, R1				; Soma o numero aleatorio no valor da posicao 0 (17) da nave
		
	store posAlien, R0			; Adiciona esse valor na posicao e na posicao anterior do alien
	store posAntAlien, R0		
	
	pop R1
	pop R0	
	rts
	
    MoveAlien:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien		
		cmp R1, R0				; Testa se o Alien chegou na linha mais inferior da tela
		ceg ResetaPosAlien		; caso sim, reseta a posicao
		
		load R1, posAlien		; Soma em 40 (tamanho de uma linha) no valor atual da posicao do alien
		loadi R3, R1		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien
		load r1, posAntAlien
		cmp r0, r1
		jeq MoveAlien_Skip
		call MoveAlien_Apaga
		call MoveAlien_Desenha		;}		
		
	MoveAlien_Skip:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien	; R0 == posAnt
		load R1, posAntNave		; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim

	MoveAlien_Apaga_Skip:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip:
			store IncRand, r1	; Salva incremento ++
		
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4
		
		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha:
		push R0
		push R1
		push R2
		
		loadn R2, #1536				; Cor ciano		
		loadn R1, #'A'	; Alien
		load R0, posAlien
		add R1, R1, R2				; Adiciona a cor na nave do alienigena
		outchar R1, R0
		store posAntAlien, R0
		
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts
;----------------------------------
ResetaPosAlien2:	
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos2
	
	loadn R0, #17
	load R1, NumAleatorio
	add R0, R0, R1
		
	store posAlien2, R0		; Zera Posicao Atual do Alien
	store posAntAlien2, R0		; Zera Posicao Atual do Alien
	
	pop R1
	pop R0	
	rts
	
    MoveAlien2:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien2
		
		cmp R1, R0
		ceg ResetaPosAlien2
		
		load R1, posAlien2
		loadi R3, R1
		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien2, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien2
		load r1, posAntAlien2
		cmp r0, r1
		jeq MoveAlien_Skip2
		call MoveAlien_Apaga2
		call MoveAlien_Desenha2	;}		
		
	MoveAlien_Skip2:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga2:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien2	; R0 == posAnt
		load R1, posAntNave		; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip2
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim2

	MoveAlien_Apaga_Skip2:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim2:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos2:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip2
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip2:
			store IncRand, r1	; Salva incremento ++
			
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4

		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha2:
		push R0
		push R1
		push R2
		
		loadn R2, #256
		loadn R1, #'$'	; Alien
		load R0, posAlien2
		add R1, R1, R2 
		outchar R1, R0
		store posAntAlien2, R0
		
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts
;----------------------------------
ResetaPosAlien3:	
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos3
	
	loadn R0, #17
	load R1, NumAleatorio
	add R0, R0, R1
		
	store posAlien3, R0		; Zera Posicao Atual do Alien
	store posAntAlien3, R0		; Zera Posicao Atual do Alien
	
	pop R1
	pop R0	
	rts
	
    MoveAlien3:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien3
		
		cmp R1, R0
		ceg ResetaPosAlien3
		
		load R1, posAlien3
		loadi R3, R1
		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien3, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien3
		load r1, posAntAlien3
		cmp r0, r1
		jeq MoveAlien_Skip3
		call MoveAlien_Apaga3
		call MoveAlien_Desenha3		;}		
		
	MoveAlien_Skip3:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga3:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien3	; R0 == posAnt
		load R1, posAntNave	; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip3
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim3

	MoveAlien_Apaga_Skip3:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim3:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos3:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip3
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip3:
			store IncRand, r1	; Salva incremento ++
			
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4
		
		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha3:
		push R0
		push R1
		push R2
		
		loadn R2, #512				; Cor VERDE
		loadn R1, #'%'	; Alien
		load R0, posAlien3
		add R1, R1, R2				; Adiciona a cor verde na nave do alienigena
		outchar R1, R0
		store posAntAlien3, R0
		
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts
;----------------------------------
ResetaPosAlien4:	
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos4
	
	loadn R0, #17
	load R1, NumAleatorio
	add R0, R0, R1
		
	store posAlien4, R0		; Zera Posicao Atual do Alien
	store posAntAlien4, R0		; Zera Posicao Atual do Alien
	
	pop R1
	pop R0	
	rts
	
    MoveAlien4:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien4
		
		cmp R1, R0
		ceg ResetaPosAlien4
		
		load R1, posAlien4
		loadi R3, R1
		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien4, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien4
		load r1, posAntAlien4
		cmp r0, r1
		jeq MoveAlien_Skip4
		call MoveAlien_Apaga4
		call MoveAlien_Desenha4		;}		
		
	MoveAlien_Skip4:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga4:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien4	; R0 == posAnt
		load R1, posAntNave	; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip4
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim4

	MoveAlien_Apaga_Skip4:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim4:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos4:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip4
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip4:
			store IncRand, r1	; Salva incremento ++
			
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4

		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha4:
		push R0
		push R1
		push R2
		
		loadn R2, #1536				; Cor ciano
		loadn R1, #'&'	; Alien
		load R0, posAlien4
		add R1, R1, R2				; Adiciona a cor ciano na nave do alienigena
		outchar R1, R0
		store posAntAlien4, R0
		
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts
;----------------------------------
ResetaPosAlien5:	
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos5
	
	loadn R0, #17
	load R1, NumAleatorio
	add R0, R0, R1
		
	store posAlien5, R0		; Zera Posicao Atual do Alien
	store posAntAlien5, R0		; Zera Posicao Atual do Alien
	
	pop R1
	pop R0	
	rts
	
    MoveAlien5:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien5
		
		cmp R1, R0
		ceg ResetaPosAlien5
		
		load R1, posAlien5
		loadi R3, R1
		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien5, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien5
		load r1, posAntAlien5
		cmp r0, r1
		jeq MoveAlien_Skip5
		call MoveAlien_Apaga5
		call MoveAlien_Desenha5		;}		
		
	MoveAlien_Skip5:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga5:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien5	; R0 == posAnt
		load R1, posAntNave	; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip5
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim5

	MoveAlien_Apaga_Skip5:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim5:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos5:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip5
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip5:
			store IncRand, r1	; Salva incremento ++
			
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4
		
		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha5:
		push R0
		push R1
		push R2
		
		loadn R2, #256				; Cor VERMELHA
		loadn R1, #'+'	; Alien
		load R0, posAlien5
		add R1, R1, R2				; Adiciona a cor vermelha
		outchar R1, R0
		store posAntAlien5, R0
		
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts
;----------------------------------
ResetaPosAlien6:	
	push R0	
	push R1
	 
	call MoveAlien_RecalculaPos6
	
	loadn R0, #17
	load R1, NumAleatorio
	add R0, R0, R1
		
	store posAlien6, R0		; Zera Posicao Atual do Alien
	store posAntAlien6, R0		; Zera Posicao Atual do Alien
	
	pop R1
	pop R0	
	rts
	
    MoveAlien6:
		push r0
		push r1	
		push R2
		push R3
		
		loadn R0, #1160
		load R1, posAlien6
		
		cmp R1, R0
		ceg ResetaPosAlien6
		
		load R1, posAlien6
		loadi R3, R1
		
		loadn R0, #40	
		add R1, R0, R1	
		store posAlien6, R1
			
		pop R3
		pop R2
		
	; So' Apaga e Redesenha se (pos != posAnt)
	;	If (pos != posAnt)	{	
		load r0, posAlien6
		load r1, posAntAlien6
		cmp r0, r1
		jeq MoveAlien_Skip6
		call MoveAlien_Apaga6
		call MoveAlien_Desenha6		;}		
		
	MoveAlien_Skip6:  	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien_Apaga6:
		push R0
		push R1
		push R2
		push R3
		push R4
		push R5

		load R0, posAntAlien6	; R0 == posAnt
		load R1, posAntNave	; R1 = posAnt
		cmp r0, r1
		jne MoveAlien_Apaga_Skip6
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim6

	MoveAlien_Apaga_Skip6:	
	  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
	  
	MoveAlien_Apaga_Fim6:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
	;----------------------------------	
		
	MoveAlien_RecalculaPos6:
		push R0
		push R1
		push R2
		push R3

	; sorteia nr. randomico entre 0 - 4
		loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
		load R1, IncRand	; Pega Incremento da tabela Rand
		add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
							; R2 = Rand + IncRand
		loadi R3, R2 		; busca nr. randomico da memoria em R3
							; R3 = Rand(IncRand)				
		inc r1				; Incremento ++
		
		loadn r2, #30
		cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
		jne MoveAlien_RecalculaPos_Skip6
			loadn r1, #0		; re-estarta a Tabela Rand em 0
	  	MoveAlien_RecalculaPos_Skip6:
			store IncRand, r1	; Salva incremento ++
			
		store NumAleatorio, R3	; Armazena o numero aleatorio na variavel de numero aleatorio de 0 a 4
		
		pop R3
		pop R2
		pop R1
		pop R0
		rts	
	;----------------------------------
	MoveAlien_Desenha6:
		push R0
		push R1
		push R2
		
		loadn R2, #2816   		; Cor AMARELA
		loadn R1, #'w'	; Alien
		load R0, posAlien6
		add R1, R1, R2 			; Adiciona a cor (amarela) na nave do alien
		outchar R1, R0
		store posAntAlien6, R0
		
	
		load R1, posNave	; Testa se a posicao da nave do jogador igual a posicao da nave do alien
		cmp R1, R0
		ceq ImprimeDerrota	; Caso sim, indica colisao 
		
		pop R2
		pop R1
		pop R0	
		rts

;----------------------------------
  MoveTiro_RecalculaPos_Boom:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	loadn r0, #526
	loadn r1, #Msn0
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #605
	loadn r1, #Msn1
	loadn r2, #0
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop	; tecla nao e' 's'	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 MoveTiro_RecalculaPos_Boom_FimJogo:
	call ApagaTela
	halt

  ImprimeDerrota:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Perdeu ...
	loadn r0, #526
	loadn r1, #Msn3
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #605
	loadn r1, #Msn1
	loadn r2, #0
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop	; tecla nao e' 's'	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0
	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main
;----------------------------------



;********************************************************
;                       DELAY
;********************************************************

Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #50  ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;-------------------------------


;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;------------------------	
	

;-------------------------------


;********************************************************
;                       IMPRIME TELA2
;********************************************************	

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING2
;********************************************************
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
   		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;********************************************************
;                   DIGITE UMA LETRA
;********************************************************

DigLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   DigLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq DigLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"

	pop r1
	pop r0
	rts

;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
	
;------------------------	
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "	

; Declara e preenche tela linha por linha (40 caracteres):
;					   0123456789012345678901234567890123456789
tela1Linha0  : string "                @     @                 "
tela1Linha1  : string "                @     @                 "
tela1Linha2  : string "                @     @                 "
tela1Linha3  : string "                @     @                 "
tela1Linha4  : string "                @     @           *     "
tela1Linha5  : string "                @     @                 "
tela1Linha6  : string "                @     @                 "
tela1Linha7  : string "                @     @                 "
tela1Linha8  : string "                @     @                 "
tela1Linha9  : string "        *       @     @                 "
tela1Linha10 : string "                @     @                 "
tela1Linha11 : string "                @     @                 "
tela1Linha12 : string "                @     @                 "
tela1Linha13 : string "                @     @                 "
tela1Linha14 : string "                @     @                 "
tela1Linha15 : string "                @     @                 "
tela1Linha16 : string "                @     @                 "
tela1Linha17 : string "                @     @                 "
tela1Linha18 : string "                @     @                 "
tela1Linha19 : string "                @     @          *      "
tela1Linha20 : string "                @     @                 "
tela1Linha21 : string "                @     @                 "
tela1Linha22 : string "                @     @                 "
tela1Linha23 : string "                @     @                 "
tela1Linha24 : string "                @     @                 "
tela1Linha25 : string "                @     @                 "
tela1Linha26 : string "                @     @            *    "
tela1Linha27 : string "   *            @     @                 "
tela1Linha28 : string "                @     @                 "
tela1Linha29 : string "                @     @                 "



; Declara e preenche tela linha por linha (40 caracteres):
;----------------------0123456789012345678901234567890123456789
tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                                        "
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                                        "
tela2Linha18 : string "                                        "
tela2Linha19 : string "                                        "
tela2Linha20 : string "                                        "
tela2Linha21 : string "                                        "
tela2Linha22 : string "                                        "
tela2Linha23 : string "                                        "
tela2Linha24 : string "                                        "
tela2Linha25 : string "                                        "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "


; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "                                        "
tela3Linha1  : string "           *                            "
tela3Linha2  : string "    |                       *           "
tela3Linha3  : string "   -*-                                  "
tela3Linha4  : string "    |                                   "
tela3Linha5  : string "                                        "
tela3Linha6  : string "                                 |      "
tela3Linha7  : string "                                -*-     "
tela3Linha8  : string "                                 |      "
tela3Linha9  : string "   *                                    "
tela3Linha10 : string "             |                      *   "
tela3Linha11 : string "            -*-                         "
tela3Linha12 : string "             |                          "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                              *         "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "               *                        "
tela3Linha19 : string "      |                                 "
tela3Linha20 : string "     -*-                                "
tela3Linha21 : string "      |                         |       "
tela3Linha22 : string "                               -*-      "
tela3Linha23 : string "                                |       "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "         *                              "
tela3Linha27 : string "                                        "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "



tela4Linha0  : string "      *                                 "
tela4Linha1  : string "                                        "
tela4Linha2  : string "                                        "
tela4Linha3  : string "                                        "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "                                        "
tela4Linha8  : string "                                        "
tela4Linha9  : string "                           @@@          "
tela4Linha10 : string "                          @@@@@         "
tela4Linha11 : string "                          @@@@@         "
tela4Linha12 : string "                           @@@          "
tela4Linha13 : string "                                        "
tela4Linha14 : string "                                        "
tela4Linha15 : string "     *                                  "
tela4Linha16 : string "                                        "
tela4Linha17 : string "                                        "
tela4Linha18 : string "                                        "
tela4Linha19 : string "                                        "
tela4Linha20 : string "                                        "
tela4Linha21 : string "                                        "
tela4Linha22 : string "                                        "
tela4Linha23 : string "                                        "
tela4Linha24 : string "                           *            "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                  	                   "

