#### INICIO BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS#####

#### FIM BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS ####

###### INICIO ETAPA DE DEFINIÇÃO DE CONFIGURAÇÃO #############
#MAPEAR O LUGAR NO SERVIDOR AONDE VÃO FICAR AS PASTAS COM AS ANALISES

usuario = "TESTE"
desc = "TESTE"

mainDir <- "D:/ProjetoGstat/src/main/webapp/file"
subDir <- usuario
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

#AQUI SERA CRIADO A PASTA DE CADA ANALISE DENTRO DA PASTA DE CADA USUÁRIO CUIDAR COM AS INFORMAÇÕES
mainDir <- paste(paste(mainDir,"/",sep = ""),usuario,sep = "")
subDir <- desc
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

#AQUI DEFINE A PASTA QUE DEVE SER ARMAZENADO OS GRÁFICOS
setwd(paste(paste(mainDir,"/",sep = ""),subDir,sep = ""))
############ FIM ETAPA DE DEFINIÇÃO DE CONFIGURAÇÃO #############################



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
# (PEDIR DETALHES ????)
# PARAMETRO DE TELA = ? (SIM,NÃO)	 
v_lambda = 1 # 1 = dados NÃO transformados,
			 # 0 = dados transformados


# PARAMETROS PARA DEFINIR O NRO DE LAGS AUTOMATICAMENTE
# (PEDIR DETALHES ????)
auto_lags= TRUE		# parametro que define automaticamente o nro de lags

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)	
nro_lags = 11 		# parametro semivariograma KO que estipula o nro de lags arbitrariamente

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)	
estimador = "classical" #parametro semivariograma KO = Matheron
#estimador = "modulus"	#parametro semivariograma OK = Cressie

# PARAMETRO SEMIVARIOGRAMA KO
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)	
cutoff = 50		# porcentagem da distancia maxima entre os pontos
# PARAMETRO DE TELA = ? (SIM,NÃO)	
# (PEDIR DETALHES ????)
nro_pares = 30 	

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
nro_intervalos_alc= 5 	#parametro Alcance parametros do semivariograma (KO)
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
nro_intervalos_contr= 5 #parametro Contribuição parametros do semivariograma (KO)

#parâmetros adicionados em 13/07/2016 (bt) # par
#parâmetros do expand.grid para criar vals da matriz de contribuição/alcance
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
min_seq_contr = 0  	# por padrão = 0 e receberá o valor de min_var mais adiante, ou usuário informa valor
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
min_seq_alc = 0 	# por padrão=0 e e receberá o valor de cutoff/4 ou min_dist_var mais adiante, ou usuário informa valor

## VERIFICAR INFORMAÇÕES SOBRE OS CONJUNTOS ABAIXO #
# (PEDIR DETALHES ????)
t_cor_linha_ols = data.table(rbind("GOLD", "PURPLE", "VIOLET", "YELLOW", "BLACK", "GREEN", "ORANGE", "PINK", "GRAY", "BROWN", "BLUE", "RED", "MAGENTA"))
# (PEDIR DETALHES ????)
t_modelos = data.table(rbind("matern", "matern", "matern", "exp", "sph", "matern", "matern", "matern", "exp", "sph", "gaus", "gaus"))
# (PEDIR DETALHES ????)
t_kappa = data.table(rbind(1.0, 1.5, 2.0, 0.5, 0.5, 1.0, 1.5, 2.0, 0.5, 0.5, 0.5, 0.5))
# (PEDIR DETALHES ????)
t_metodo = data.table(rbind("ols", "ols", "ols", "ols", "ols", "wl", "wl", "wl", "wl", "wl", "wl", "ols"))
#t_modelos = data.table(rbind("exp", "sph", "gaus"))
#t_kappa = data.table(rbind(0.5, 0.5, 0.5))

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
nro_modelo=12

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
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
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
tam_pixel_x = 5 #parametro dos mapas
# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
tam_pixel_y = 5 #parametros dos mapas

# PARAMETRO DE TELA = ? (SIM,NÃO)
# (PEDIR DETALHES ????)
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
