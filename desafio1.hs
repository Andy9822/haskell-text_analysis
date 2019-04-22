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

-- Função intermediária que recebe uma lista* de strings e chamará a função countOccurrences 
-- passando como segundo parametro uma funçao que retorna os elementos únicos da lista*
-- Retorna uma lista de ocorrencias dos elementos unicos da lista*
listOccurrences :: [String] -> [Float]
listOccurrences phrase = countOccurrences phrase (rmvDuplicates phrase)

-- Função principal que faz um zip dos elementos únicos da lista, que se recebe como parametro, com uma lista das ocorrencias desses mesmos elementos
pesosPalavras :: [String] -> [(String,Float)]
pesosPalavras list = zip unicElements elemOccurences
                     where unicElements = rmvDuplicates list
                           elemOccurences = listOccurrences list