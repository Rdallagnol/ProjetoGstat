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

