# TextSimilarity

## The project
The content in this repository was made with the intent of practice the use of the Haskell language and solve some challenge exercises from the Programming Language Models subject from the Computer Science course @ UFRGS related to Information Retrieval System.


## Sistema Recuperação de Informações 
Os motores de busca (como Google, Yahoo, Bing e outros) são baseados em teorias, algoritmos e métodos desenvolvidos em uma área chamada de Recuperação de Informações (Information Retrieval). Nessa área, diversos modelos de representação de documentos foram desenvolvidas. Um dos modelos mais conhecidos é o modelo Espaço-Vetorial, de Gerald Salton.

Nesse modelo, os documentos (ou páginas Web) são representados como pontos em um espaço Euclidiano. As dimensões desse espaço são dadas pelas palavras presentes em todos os documentos (i.e., cada palavra da coleção de documentos é considerada uma dimensão). A representação dos documentos no espaço é feita, portanto, através de um vetor de n dimensões, onde cada dimensão é uma palavra com posição fixa no vetor. Todos os vetores possuem a mesma quantidade de dimensões, cada uma com sua posição (normalmente em ordem alfabética):

                                           [palavra1, palavra2, palavra3, ... palavra_n] 

Para representar um documento, cada dimensão representa a força (ou peso) da palavra naquele documento. Caso a palavra não se encontre no documento, ela recebe o peso 0.0. Caso ela esteja presente, pode-se utilizar uma fórmula de medição de peso. Existem muitas equações que podem ser utilizadas para calcular o peso (ver tf-idf e suas variações), sendo uma das mais simples a frequência relativa (i.e., o número de ocorrências da palavra no documento dividido pelo número de palavras do documento). 

<p align="center">
  <img src="https://github.com/Andy9822/haskell-text_analysis/blob/master/lib/formula.PNG">
</p>

### Desafio I
Conforme visto no último exercício do CATP desta aula, documentos podem ser representados por um vetor de palavras cujos valores representam a sua posição em um espaço cartesiano multi-dimensional (de palavras).

Nesse contexto, elabore uma função que recebe uma lista que contém as palavras de um documento e retorna uma lista de pares ordenados contendo o vetor de representação dos pesos dessas palavras nesse mesmo documento. Considere que a lista original contém todas as palavras do documento, em sua ordem e conteúdo originais (inclusive podendo se repetir). O par ordenado deve possuir a seguinte sintaxe: (palavra, peso), onde palavra é uma string e peso é um número real. 

Por exemplo, para o seguinte trecho do poema "Quadrilha", de Carlos Drumond de Andrade ("Nova reunião". Rio de Janeiro: J. Olympio, 1985):

```
João amava Teresa que amava Raimundo que amava Maria que amava Joaquim que amava Lili que não amava ninguém.
a seguinte lista seria passada:
```

```
["joao", "amava", "teresa", "que", "amava", "raimundo", "que", "amava", "maria", "que", "amava", "joaquim", "que", "amava" "Lili", "que", "nao", "amava", "ninguem"]
```
Já o vetor resultante teria a lista de palavras (sem repetição) e seus respectivos pesos. Inicialmente, os pesos são dados pela frequência absoluta (i.e., o número de vezes que uma palavra ocorre, aparece, no documento). 

Para a lista anterior, o resultado da função deve ser o seguinte:

```
[("joao", 1.0), ("amava", 6.0),("teresa", 1.0), ("que", 5.0), ("raimundo", 1.0), ("maria", 1.0), ("joaquim", 1.0), ("Lili", 1.0), ("nao", 1.0), ("ninguem", 1.0)]
```
Perceba que a lista não está ordenada, mas se desejar, pode ordená-la por ordem alfabética de palavra... 





### Desafio II
Clone o exercício anterior e o modifique de maneira a calcular o peso das palavras utilizando a frequência relativa ao invés da frequência absoluta. A frequência relativa de uma palavra corresponde ao número de ocorrências de uma palavra dividido pelo total de ocorrências de palavras do documento. Perceba que esse valor estará normalizado entre 0.0 e 1.0.

Para o exercício anterior, o vetor resultante seria:
```
[("joao", 0.052632), ("amava", 0.315789),("teresa", 0.052632) ("que", 0.263158), ("raimundo", 0.263158), ("maria", 0.263158), ("joaquim", 0.263158), ("Lili", 0.263158), ("nao", 0.263158), ("ninguem", 0.263158)]
```



### Desafio III
Este desafio combina todos os elementos estudados e desenvolvidos nos exercícios e desafios anteriores, acrescentando mais uma dificuldade. 

O objetivo é ter um programa que recebe 2 strings que representam 2 documentos diferentes e calcular o grau de similaridade entre elas. Para tanto, a função irá receber 2 strings e deve retornar o grau de similaridade entre elas. 

Descubra na Web como você pode separar uma string em uma lista de palavras para passar para a função do desafio II. Com base nisso, calcule os pesos (frequência relativa) e use a função de similaridade por cosseno do CATP. 

Você ganha um plus se modificar a função do desafio II de maneira que ela receba por parâmetro a função de cálculo do peso (assim, qualquer função de peso poderia ser utilizada, desde que devolva pesos normalizados entre 0 e 1). 

