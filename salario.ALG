Algoritmo "semnome"

Var
   salario , novoSalario , reajuste:real

Inicio
      escreva("Digite o seu salario")
      leia(salario)
      se (salario < 500) entao
         reajuste <- salario / 15
         novoSalario <- reajuste + salario
         escreva("Salario com reajuste e" , novoSalario)
      senao
        se (salario > 500) e (salario <= 1000) entao
            reajuste <- salario / 10
            novoSalario <- reajuste + salario
            escreva("Salario com reajuste e" , novoSalario)
        senao
           se (salario > 1000) entao
               reajuste <- salario / 5
               novoSalario <- reajuste + salario
               escreva("Salario com reajuste e" , novoSalario)
           fimse
        fimse
      fimse


Fimalgoritmo