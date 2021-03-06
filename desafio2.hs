--Compara 2 strings e retorna 1.0 em caso de True e 0.0 em caso de False
cmpStr :: String -> String -> Float
cmpStr str1 str2
    | str1 == str2 = 1.0
    | otherwise = 0.0


--Conta ocorrencias de uma string numa lista de strings
countStr :: String -> [String] -> Float
countStr _ [] = 0
countStr str (h:t) = (cmpStr h str) + countStr str t


--Retorna se uma lista de strings contem ou nao uma determinada string
containStr :: [String] -> String -> Bool
containStr [] str = False
containStr (h:t) str
    | (h == str) = True
    | otherwise = containStr t str


--Função intermediária só para seguir um cabeçalho padrao de (removerDuplicados lista), sendo assim mais intuitivo de ler e usar
--Retorna um Set da lista original apenas contendo elementos unicos, devolvidos na funcao rmvDups e essa aqui só propaga para a chamada desta funcao
rmvDuplicates :: [String] -> [String]
rmvDuplicates list = rmvDups list []

--Função que recebe 2 listas onde a segunda lista receberá todos os elementos únicos da primeira lista
--Esta segunda lista de elementos será retornada
rmvDups :: [String] -> [String] -> [String]
rmvDups [] _ = []
rmvDups (h:t) list
    | (containStr list h) = rmvDups t list -- Se a list já tem o elemento h então continua recursao e não se adiciona o h
    | otherwise = h : (rmvDups t (h:list) ) -- Se h não estiver em list então se faz h : list e segue recursao da funcao com a list contendo h


-- Função que recebe uma lista* de strings e uma lista contendo os elementos unicos da lista de strings
-- Será retornada uma lista contando quantas vezes aparece na lista* cada elemento
countOccurrences :: [String] -> [String] -> [Float]
countOccurrences phrase [] = []
countOccurrences phrase (h:t) = (countStr h phrase) : (countOccurrences phrase t)
--countOccurrences phrase (h:t) = countStr h phrase

-- Função intermediária que recebe uma lista* de strings e uma lista dos elementos únicos dessa lista* e chamará a função countOccurrences
-- Retorna uma lista de ocorrencias dos elementos unicos da lista*
listOccurrences :: [String] -> [String] -> [Float]
listOccurrences phrase unicElements = countOccurrences phrase unicElements

relativeMean :: Int -> Float -> Float
relativeMean numWords element = element / fromIntegral  numWords

-- Função principal que faz um zip dos elementos únicos da lista, que se recebe como parametro, com uma lista das ocorrencias desses mesmos elementos
pesosPalavras :: [String] -> [(String,Float)]
pesosPalavras list = zip unicElements weightedOccurences
                     where unicElements = rmvDuplicates list
                           numWords = length list
                           elemOccurences = listOccurrences list unicElements
                           weightedOccurences = map(relativeMean numWords) elemOccurences


--Funcao dummy so para depois poder exemplificar como passar uma funcao de calculo de peso por parametro
foo :: Float -> Float
foo num =  num / fromIntegral 19

-- Função que calcula os pesos das palavras no texto e usa uma funcao para esse calculo recebida como parametro
-- Exemplo de chamada:
-- pesosPalavrasFlex foo ["joao", "amava", "teresa", "que", "amava", "raimundo", "que", "amava", "maria", "que", "amava", "joaquim", "que", "amava", "Lili", "que", "nao", "amava", "ninguem"]
-- pesosPalavrasFlex (relativeMean 19) ["joao", "amava", "teresa", "que", "amava", "raimundo", "que", "amava", "maria", "que", "amava", "joaquim", "que", "amava", "Lili", "que", "nao", "amava", "ninguem"]
-- pesosPalavrasFlex (relativeMean (length list) ) list
-- P.S. minha funcao relativeMean precisa de um parametro, logo precisaria se passar a funcao como parametro juntamente com seu argumento (relativeMean 19) ou (relativeMean tamanhoDaListaPassada)
pesosPalavrasFlex :: (Float ->  Float) -> [String] -> [(String,Float)]
pesosPalavrasFlex func list = zip unicElements weightedOccurences
                     where unicElements = rmvDuplicates list
                           numWords = length list
                           elemOccurences = listOccurrences list unicElements
                           weightedOccurences = map func elemOccurences
