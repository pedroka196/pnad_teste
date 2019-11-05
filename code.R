library(survey)
library(xlsx)

# Posicoes para obter o vetor de tamanhos
# Os dados estão em largura fixa, então é necessário pegar o tamanho das variáveis
# Label é o nome de cada variável.Consultar dicionário para obter o que interessar
posicoes <- read.xlsx("Dicionario/Dicionario de variaveis de domicilios - 2002.xls",sheetIndex = 1,colIndex = 2,startRow = 2)
labels <- read.xlsx("Dicionario/Dicionario de variaveis de domicilios - 2002.xls",sheetIndex = 1,colIndex = 3,startRow = 2)
posicoes <- na.exclude(posicoes)
labels <- na.exclude(labels)


domicilios <- read.fwf("Dados/DOM2002.txt",widths = posicoes)
names(domicilios) <- labels$Código.de.variável

pop_types <- data.frame( 
  v4609 = unique( domicilios$V4609 ) , 
  Freq = unique( domicilios$V4609 )
)

prestratified_design <-
  svydesign(
    id = ~V4618 ,
    strata = ~V4617 ,
    data = domicilios ,
    weights = ~pre_wgt ,
    nest = TRUE
  )
