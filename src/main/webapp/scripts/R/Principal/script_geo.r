args<-commandArgs(TRUE) 
#### INICIO BLOCO QUE RECEBERA OS ARGUMENTOS DA TELA E REALIZARA OS TRATAMENTOS#####
#ENDERECO DA PASTA DE ARQUIVOS
mainDir<-args[1]
usuario<-as.numeric(args[2])
area<-as.numeric(args[3])
amostra<-as.numeric(args[4])
desc<-args[5]
tam_pixel_x<-as.numeric(args[6])
tam_pixel_y<-as.numeric(args[7])
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


mainDir
usuario
area
amostra
desc
tam_pixel_x
tam_pixel_y
