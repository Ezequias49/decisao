programa
{
    funcao inicio()
    {
        inteiro opcao, quantum, num_processos, tempo_total
        cadeia nomes[15]
        inteiro tempos_uso[15], tempos_chegada[15]
        
        escreva("Escolha o algoritmo:\n1. Algoritmo SRT\n2. Algoritmo Round-Robin\n")
        leia(opcao)
        
        se (opcao == 2)
        {
            escreva("Digite o numero de processos : ")
            leia(num_processos)
            
            para (inteiro i = 0; i < num_processos; i++)
            {
                escreva("Digite o nome do processo ", i + 1, ": ")
                leia(nomes[i])
                escreva("Digite o tempo de uso da CPU do processo ", i + 1, ": ")
                leia(tempos_uso[i])
                escreva("Digite o tempo de chegada do processo ", i + 1, ": ")
                leia(tempos_chegada[i])
            }
            
            escreva("Digite o tempo de quantum: ")
            leia(quantum)
            
            // Implementa��o do algoritmo Round-Robin
            roundRobin(nomes, tempos_uso, tempos_chegada, num_processos, quantum)
        }
        senao se (opcao == 1)
        {
            escreva("Digite o numero de processos : ")
            leia(num_processos)
            
            para (inteiro i = 0; i < num_processos; i++)
            {
                escreva("Digite o nome do processo ", i + 1, ": ")
                leia(nomes[i])
                escreva("Digite o tempo de uso da CPU do processo ", i + 1, ": ")
                leia(tempos_uso[i])
                escreva("Digite o tempo de chegada do processo ", i + 1, ": ")
                leia(tempos_chegada[i])
            }
            
            // Implementa��o do algoritmo SRT
            srt(nomes, tempos_uso, tempos_chegada, num_processos)
        }
        senao
        {
            escreva("Op�oo invalida!")
        }
    }
    
    funcao roundRobin(cadeia nomes[], inteiro tempos_uso[], inteiro tempos_chegada[], inteiro num_processos, inteiro quantum)
    {
        inteiro tempo_atual = 0
        inteiro tempos_restantes[15]
        inteiro processos_na_fila[15]
        inteiro num_na_fila = 0
        logico processo_executando = falso
        
        // Inicializa tempos restantes
        para (inteiro i = 0; i < num_processos; i++)
        {
            tempos_restantes[i] = tempos_uso[i]
        }
        
        enquanto (existeProcessoNaoFinalizado(tempos_restantes, num_processos))
        {
            // Adiciona processos que chegaram na fila
            para (inteiro i = 0; i < num_processos; i++)
            {
                se (tempos_chegada[i] <= tempo_atual e tempos_restantes[i] > 0)
                {
                    // Verifica se o processo j� est� na fila
                    logico na_fila = falso
                    para (inteiro j = 0; j < num_na_fila; j++)
                    {
                        se (processos_na_fila[j] == i)
                        {
                            na_fila = verdadeiro
                            pare
                        }
                    }
                    se (na_fila == falso)
                    {
                        processos_na_fila[num_na_fila] = i
                        num_na_fila++
                    }
                }
            }        
            
            // Processa a fila
            se (num_na_fila > 0)
            {
                inteiro processo_atual = processos_na_fila[0]
                
                escreva("Tempo ", tempo_atual, ": Processo ", nomes[processo_atual], " esta na CPU\n")
                
                se (tempos_restantes[processo_atual] > quantum)
                {
                    tempos_restantes[processo_atual] -= quantum
                    tempo_atual += quantum
                }
                senao
                {
                    tempo_atual += tempos_restantes[processo_atual]
                    tempos_restantes[processo_atual] = 0
                }
                
                // Atualiza a fila
                para (inteiro j = 0; j < num_na_fila - 1; j++)
                {
                    processos_na_fila[j] = processos_na_fila[j + 1]
                }
                num_na_fila--
                
                // Recoloca o processo na fila se ele n�o terminou
                se (tempos_restantes[processo_atual] > 0)
                {
                    processos_na_fila[num_na_fila] = processo_atual
                    num_na_fila++
                }
            }
            senao
            {
                tempo_atual++
            }
            
            // Imprime o estado dos processos
            para (inteiro i = 0; i < num_processos; i++)
            {
                se (tempos_chegada[i] <= tempo_atual)
                {
                    escreva("Processo ", nomes[i], ": Tempo restante ", tempos_restantes[i], "\n")
                }
            }
            escreva("\n")
        }
    }
    
    funcao logico existeProcessoNaoFinalizado(inteiro tempos_restantes[], inteiro num_processos)
    {
        para (inteiro i = 0; i < num_processos; i++)
        {
            se (tempos_restantes[i] > 0)
            {
                retorne verdadeiro
            }
        }
        retorne falso
    }
    
    funcao srt(cadeia nomes[], inteiro tempos_uso[], inteiro tempos_chegada[], inteiro num_processos)
    {
        inteiro tempo_atual = 0
        inteiro tempos_restantes[15]
        
        // Inicializa tempos restantes
        para (inteiro i = 0; i < num_processos; i++)
        {
            tempos_restantes[i] = tempos_uso[i]
        }
        
        enquanto (existeProcessoNaoFinalizado(tempos_restantes, num_processos))
        {
            // Encontra o processo com o menor tempo restante que ja chegou
            inteiro processo_atual = -1
            inteiro menor_tempo = 99999
            
            para (inteiro i = 0; i < num_processos; i++)
            {
                se (tempos_chegada[i] <= tempo_atual e tempos_restantes[i] > 0 e tempos_restantes[i] < menor_tempo)
                {
                    processo_atual = i
                    menor_tempo = tempos_restantes[i]
                }
            }
            
            se (processo_atual != -1)
            {
                escreva("Tempo ", tempo_atual, ": Processo ", nomes[processo_atual], " esta na CPU\n")
                
                // Processa o tempo de um ciclo (1 unidade de tempo)
                tempos_restantes[processo_atual] -= 1
                tempo_atual += 1
            }
            senao
            {
                tempo_atual++
            }
            
            // Imprime o estado dos processos
            para (inteiro i = 0; i < num_processos; i++)
            {
                se (tempos_chegada[i] <= tempo_atual)
                {
                    escreva("Processo ", nomes[i], ": Tempo restante ", tempos_restantes[i], "\n")
                }
            }
            escreva("\n")
        }
    }
}