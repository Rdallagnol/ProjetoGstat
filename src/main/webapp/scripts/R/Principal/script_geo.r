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
nro_lags<-as.numeric(args[9])
estimador<-args[10]
cutoff<-as.numeric(args[11])
tam_pixel_x<-as.numeric(args[12])
tam_pixel_y<-as.numeric(args[13])
nro_intervalos_alc<-as.numeric(args[14])
nro_intervalos_contr<-as.numeric(args[15])
nro_pares<-as.numeric(args[16])
min_seq_contr<-as.numeric(args[17]) 
min_seq_alc<-as.numeric(args[18])  

if (ISI == "true") {
   ISI <- TRUE
} else {
   ISI <- FALSE
}
if (auto_lags == "true") {
   auto_lags <- TRUE
} else {
   auto_lags <- FALSE
}

#### FIM BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS ####

#### INICIO BIBLIOTECAS UTILIZADAS #####
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

options(encoding="ISO-8859-1")

#### FIM BIBLIOTECAS UTILIZADAS #####

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
###### INICIO CONFIGURAÇÕES DO SEMIVARIOGRAMA E INICIO DO PROCESSO GEOESTATÍSTICO #############

t_cor_linha_ols = data.table(rbind("GOLD", "PURPLE", "VIOLET", "YELLOW", "BLACK", "GREEN", "ORANGE", "PINK", "GRAY", "BROWN", "BLUE", "RED", "MAGENTA"))
t_modelos = data.table(rbind("matern", "matern", "matern", "exp", "sph", "matern", "matern", "matern", "exp", "sph", "gaus", "gaus"))
t_kappa = data.table(rbind(1.0, 1.5, 2.0, 0.5, 0.5, 1.0, 1.5, 2.0, 0.5, 0.5, 0.5, 0.5))
t_metodo = data.table(rbind("ols", "ols", "ols", "ols", "ols", "wl", "wl", "wl", "wl", "wl", "wl", "ols"))
nro_modelo=12
vlr_kappa=0

#Constante para gráfico Semivariograma
legenda_x_semiv = "Distância"
legenda_y_semiv = "Semivariância"
titulo_semiv = "Semivariograma experimental"

#Constante do gráfico Mapa de dispersão dos pontos amostrais
titulo_pamostrais = "Mapa de dispersão dos pontos amostrais"
fonte_pamostrais = 3
leg_x_pamostrais ="O - L"
leg_y_pamostrais ="S - N"

titulo_BoxPlot = "Gráfico Boxplot"
titulo_PostPlot = "Gráfico Postplot"

classes = 4  	#número de classe no mapa (intervalos) - só no R

###### FIM CONFIGURAÇÕES DO SEMIVARIOGRAMA E INICIO DO PROCESSO GEOESTATÍSTICO #############

###### INICIO CONFIGURAÇÕES DE CONEXÃO E BUSCA DE DADOS  #############	
atributo = "D:/ProjetoGstat/src/main/webapp/scripts/dados/elevacao.txt"
local = 29182

dados= read.geodata(atributo,head=T,coords.col=1:2,data.col=3) 
dados$coords
dados$data



###### FIM CONFIGURAÇÕES DE CONEXÃO E BUSCA DE DADOS  #############