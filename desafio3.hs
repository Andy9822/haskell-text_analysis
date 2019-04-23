-- analyseDocuments  ["joao","jukera","joice","janjam","joao","abababa","jukera","aiueauihea"] ["jukera","joao","oi","falou","oi","abababa","jukera"]
--Conteúdo reaproveitado do CATP2 somatorio lst = foldr (+) 0 lst

somatorio lst = foldr (+) 0 lst
pow x = x * x
mapsq lst = map pow lst
norma lst = sqrt (somatorio (mapsq lst))

mult (x, y)= x * y
mapmult lst = map mult lst
multlst lst = (somatorio (mapmult lst))
prod_int lst1 lst2 = multlst(zip lst1 lst2)

similarity list1 list2 = (prod_int list1 list2) / (norma list1 * norma list2)
-- Fim conteúdo reaproveitado do CATP 4


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


-- Função que recebe uma lista* de strings e uma segunda lista de strings
-- Retornara uma lista de quantas vezes cada elemento da segunda lista aparece na primeira lista
countOccurrences :: [String] -> [String] -> [Float]
countOccurrences phrase [] = []
countOccurrences phrase (h:t) = (countStr h phrase) : (countOccurrences phrase t)

-- Função intermediária que recebe uma lista* de strings e chamará a função countOccurrences
-- passando como segundo parametro uma funçao que retorna os elementos únicos da lista*
-- Por isso retornará uma lista de ocorrencias dos elementos unicos da lista*
listOccurrences :: [String] -> [String] -> [Float]
listOccurrences phrase elementsToCount = countOccurrences phrase elementsToCount

relativeMean :: Int -> Float -> Float
relativeMean numWords element = element
-- relativeMean numWords element = element / fromIntegral  numWords

-- Função principal que faz um zip dos elementos únicos da lista, que se recebe como parametro, com uma lista das ocorrencias desses mesmos elementos
pesosPalavras :: [String] -> [(String,Float)]
pesosPalavras list = zip unicElements weightedOccurences
                     where unicElements = rmvDuplicates list
                           numWords = length list
                           elemOccurences = listOccurrences list unicElements
                           weightedOccurences = map(relativeMean numWords) elemOccurences


-- Função que recebe 2 listas de strings e retorna todas as palavras unicas considerando todos os elementos das 2 listas
extractAllWords :: [String] -> [String] -> [String]
extractAllWords list1 list2 = rmvDuplicates(rmvDuplicates list1 ++ rmvDuplicates list2)


-- Função que recebe 2 listas de strings e calcula similaridade entre elas usando a função de similaridade por cosseno
analyseDocuments list1 list2 = similarity scoreL1 scoreL2
                               --zip allWords (zip scoreL1 scoreL2)
                   where allWords = extractAllWords list1 list2
                         scoreL1 = listOccurrences list1 allWords
                         scoreL2 = listOccurrences list2 allWords
