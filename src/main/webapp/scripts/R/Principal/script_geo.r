args<-commandArgs(TRUE) 
#### INICIO BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS#####
#ENDERECO DA PASTA DE ARQUIVOS
mainDir<-args[1]
usuario<-as.numeric(args[2])
area<-as.numeric(args[3])
amostra<-as.numeric(args[4])
desc<-args[5]

ISI<-args[6]
v_lambda<-as.numeric(args[7])
auto_lags<-args[8]
estimador<-args[9]
cutoff<-as.numeric(args[10])
tam_pixel_x<-as.numeric(args[11])
tam_pixel_y<-as.numeric(args[12])

#### FIM BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS ####

###### INICIO ETAPA DE DEFINIÇÃO DE CONFIGURAÇÃO #############
#MAPEAR O LUGAR NO SERVIDOR AONDE VÃO FICAR AS PASTAS COM AS ANALISES
subDir <- usuario
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

#AQUI SERA CRIADO A PASTA DE CADA ANALISE DENTRO DA PASTA DE CADA USUÁRIO CUIDAR COM AS INFORMAÇÕES
mainDir <- paste(paste(mainDir,"/",sep = ""),usuario,sep = "")
subDir <- desc
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

#AQUI DEFINE A PASTA QUE DEVE SER ARMAZENADO OS GRÁFICOS
setwd(paste(paste(mainDir,"/",sep = ""),subDir,sep = ""))
############ FIM ETAPA DE DEFINIÇÃO DE CONFIGURAÇÃO #############################

mainDir
usuario
area
amostra
desc

ISI
v_lambda
auto_lags
estimador
cutoff
tam_pixel_x
tam_pixel_y


require(geoR)
require(splancs)
require(classInt)
require (sp)
library(stats)
require(MASS)
library(e1071)
require(gstat)
library(ade4)
library(spdep)
library(RPostgreSQL)
library(data.table)
require (gstat)
require (nortest)

#############################################################################################
######## INICIO 1° ETAPA - VARIAVEIS ############

## ESCOLHA DO INDICE DE (PEDIR DETALHES ????) PARA ESCOLHA DO MELHOR MODELO (ISI OU ICE)
# PARAMETRO DE TELA = ? (SIM,NÃO)
ISI = TRUE	#ISI = FALSE	

## VARIAVEIS PARA SEMIVARIOGRAMA	 
v_lambda = 1 # 1 = dados NÃO transformados,
	     # 0 = dados transformados

auto_lags= TRUE		# parametro que define automaticamente o nro de lags

nro_lags = 11 		# parametro semivariograma KO que estipula o nro de lags arbitrariamente

estimador = "classical" #parametro semivariograma KO = Matheron
#estimador = "modulus"	#parametro semivariograma OK = Cressie

# PARAMETRO SEMIVARIOGRAMA KO
cutoff = 50		# porcentagem da distancia maxima entre os pontos

nro_pares = 30 

nro_intervalos_alc= 5 	#parametro Alcance parametros do semivariograma (KO)

nro_intervalos_contr= 5 #parametro Contribuição parametros do semivariograma (KO)

#parâmetros adicionados em 13/07/2016 (bt) # par
#parâmetros do expand.grid para criar vals da matriz de contribuição/alcance
min_seq_contr = 0  	# por padrão = 0 e receberá o valor de min_var mais adiante, ou usuário informa valor
min_seq_alc = 0 	# por padrão=0 e e receberá o valor de cutoff/4 ou min_dist_var mais adiante, ou usuário informa valor

## VERIFICAR INFORMAÇÕES SOBRE OS CONJUNTOS ABAIXO #
t_cor_linha_ols = data.table(rbind("GOLD", "PURPLE", "VIOLET", "YELLOW", "BLACK", "GREEN", "ORANGE", "PINK", "GRAY", "BROWN", "BLUE", "RED", "MAGENTA"))
t_modelos = data.table(rbind("matern", "matern", "matern", "exp", "sph", "matern", "matern", "matern", "exp", "sph", "gaus", "gaus"))
t_kappa = data.table(rbind(1.0, 1.5, 2.0, 0.5, 0.5, 1.0, 1.5, 2.0, 0.5, 0.5, 0.5, 0.5))
t_metodo = data.table(rbind("ols", "ols", "ols", "ols", "ols", "wl", "wl", "wl", "wl", "wl", "wl", "ols"))
#t_modelos = data.table(rbind("exp", "sph", "gaus"))
#t_kappa = data.table(rbind(0.5, 0.5, 0.5))

nro_modelo=12

vlr_kappa=0			#parametro semivariograma KO

#CONSTANTE PARA GRÁFICO SEMIVARIOGRAMA 
legenda_x_semiv = "Distância"
legenda_y_semiv = "Semivariância"
titulo_semiv = "Semivariograma experimental"

#CONSTANTE DO GRÁFICO MAPA DE DISPERSÃO DOS PONTOS AMOSTRAIS
titulo_pamostrais = "Mapa de dispersão dos pontos amostrais"
fonte_pamostrais = 3
leg_x_pamostrais ="O - L"
leg_y_pamostrais ="S - N"

#CONSTANTE DO BOXSPLOT
titulo_BoxPlot = "Gráfico Boxplot"
titulo_PostPlot = "Gráfico Postplot"

#PARAMETROS QUE IDENTIFICAM O TAMANHO DO PIXEL DO MAPA FINAL
tam_pixel_x = tam_pixel_x #parametro dos mapas
tam_pixel_y = tam_pixel_y #parametros dos mapas

classes = 5  	#número de classe no mapa (intervalos) - só no R
## FIM 1° ETAPA ###


########################################################################################

## INICIO 2° ETAPA ###
# Estabelece conexão com o PoststgreSQL usando RPostgreSQL
drv <- dbDriver("PostgreSQL")

# IDENTIFICAÇÃO DA FONTE DE DADOS UTILIZADA
projeto = "db_projeto_schenatto_b"  	#área
atributo = "tb_prod_media_norm_amp"		#amostra
local = 29182

# Configuração completa da conexão com o banco de dados
con <- dbConnect(drv, dbname=projeto,host="localhost",port=5432,user="postgres",password="1")
con

# REALIZAÇÃO DA LEITURA DOS DADOS DA TABELA DE ATRIBUTOS NO BANCO DE DADOS
atrib = paste("select st_x(st_transform(the_geom,", local, ")), st_y(st_transform(the_geom, ", local, ")),amo_medida from ", atributo)
frame_dados <- dbGetQuery(con,atrib)
frame_dados

dados <- as.geodata(frame_dados)
names(dados)
dados

###### ANÁLISE EXPLORATÓRIA DOS DADOS ###############
## VERIFICAR SE SERÁ ARMAZENADO EM ALGUM LUGAR ESSES VALORES ####
summary(dados$data)
mean (dados$data) 
var(dados$data)
sd(dados$data)
CV = sd(dados$data)*100/mean(dados$data)
CV
skewness(dados$data)
kurtosis(dados$data)
length(dados$data)

# GRÁFICOS DESCRITIVOS 
plot(dados) 
hist(dados$data)

#EXIBIR GRÁFICO (ARMAZENAR)
x=paste("boxplot",".png",sep = "")
png(x)
boxplot(dados$data,main=titulo_BoxPlot)
dev.off()

# ANÁLISE EXPLORATÓRIA ESPACIAL # Grafico Post-plot com legenda para o estudo de tendencia direcional.
x=paste("postplot",".png",sep = "")
png(x)
points(dados,pt.div="quartile",col=c("yellow","green","red","blue"),main=titulo_PostPlot, xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)
dev.off()

## FIM 2° ETAPA ###
#########################################################################################################################################

## INICIO 3° ETAPA ###

## FIM 3° ETAPA ###

# Encerra a conexão com o banco de dados
dbDisconnect(con)


