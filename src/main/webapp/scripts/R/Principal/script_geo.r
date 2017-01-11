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
atributo = "K:/ProjetoGstat/src/main/webapp/scripts/dados/elevacao.txt"
local = 29182
###### FIM CONFIGURAÇÕES DE CONEXÃO E BUSCA DE DADOS  #############

###### INICIO DAS ANALISES  #############	 
dados= read.geodata(atributo,head=T,coords.col=1:2,data.col=3) 
dados$coords
dados$data

min (dados$data)
#Análise exploratória dos dados
summary(dados$data)
mean (dados$data) 
min (dados$data) 
var(dados$data)
sd(dados$data)
CV = sd(dados$data)*100/mean(dados$data)
skewness(dados$data)
kurtosis(dados$data)
length(dados$data)


# Gráfico de probabilidade (QQ)
qqnorm(dados$data)  #, main = "", xlab = "Quantis teóricos N(0,1)", pch = 20,
# ylab = "Velocidade (km/m)")
qqline(dados$data, lty = 2, col = "red")

# Testes
t1 <- ks.test(dados$data, "pnorm", mean(dados$data), sd(dados$data)) # KS
t2 <- shapiro.test(dados$data) # Shapiro-Wilk
#t3 <- ad.test(dados$data) # Anderson-Darling


# Tabela de resultados
testes <- c(t1$method, t2$method)
estt <- as.numeric(c(t1$statistic, t2$statistic))
valorp <- c(t1$p.value, t2$p.value)
resultados <- cbind(estt, valorp)
rownames(resultados) <- testes
colnames(resultados) <- c("Estatística", "p")
print(resultados, digits = 4)


##############################################

# Gráficos Descritivos 
plot(dados) 
hist(dados$data)

x=paste("box_plot",".png",sep = "")
png(x)
boxplot(dados$data,main=titulo_BoxPlot) #EXIBIR GRÁFICO (ARMAZENAR)
dev.off()


# ANÁLISE EXPLORATÓRIA ESPACIAL # Grafico Post-plot com legenda para o estudo de tendencia direcional.
points(dados,pt.div="quartile",col=c("yellow","green","red","blue"),main=titulo_PostPlot, xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)

# ANÁLISE ESPACIAL
# Calcular a maior e menor distancia da área considerando as coordenadas dados$coords para obter o cutoff de 50% da distancia maxima
max_dist <- max(dist(dados$coords))
min_dist <- min(dist(dados$coords))
vlr_cutoff <- max_dist*cutoff/100 

if (auto_lags==TRUE){
    nro_lags = round(vlr_cutoff/min_dist)	## bt 8/6/2016 - menor distancia das variancias
}

dados.var <- variog(dados,coords=dados$coords, data=dados$data, uvec=seq(min_dist,vlr_cutoff,l=nro_lags), lambda=v_lambda,
	 	estimator.type=estimador, max.dist=vlr_cutoff, pairs.min=nro_pares) 

dados.var
plot(dados.var, xlab = legenda_x_semiv, ylab = legenda_y_semiv, main = titulo_semiv)  
# Informações do semivariograma experimental
distancia <-  dados.var$u 
semivariancia <- dados.var$v
pares <- dados.var$n
tabela <- cbind(distancia,semivariancia,pares)

####################################
# envelopes --  bt 07/12/2016 ######
#dados.env<-variog.mc.env(dados, obj.v=dados.var) #,nsim = 99)
#plot(dados.var,env=dados.env,xlab="Distância", ylab="Semivariância")

####################################
min_dist_var = min(distancia)  ## bt 8/6/2016 - menor distancia das variancias

## para ajustar os valores para o semivariograma
min_var = min(semivariancia) # menor variância 
max_var = max(semivariancia) # maior variância

if (min_seq_alc==0){
#  min_seq_alc = min_dist_var	## bt 13/07/2016
   min_seq_alc = vlr_cutoff/4	## bt 13/07/2016
}
if (min_seq_contr==0){
    min_seq_contr = min_var		## bt 13/07/2016
}


vals <- expand.grid(seq(min_seq_contr,max_var, l=nro_intervalos_contr), 
# vals <- expand.grid(seq(min_var,max_var, l=nro_intervalos_contr), 
seq(min_seq_alc, vlr_cutoff, l=nro_intervalos_alc))
# seq(vlr_cutoff/4, vlr_cutoff, l=nro_intervalos_alc))

x=paste("semi_geral",".png",sep = "")
png(x)
plot(dados.var,xlab='Distância',ylab='Semivariância',main= paste ("Semivariograma ajustado -",atributo) )
dev.off()

cont = nro_intervalos_contr * nro_intervalos_alc

#cria matriz para armazenar informações do ice
matriz_ice<-matrix(nrow=0,ncol=7,
dimnames = list(c(),c("modelo","metodo","min_ice", "melhor_contrib", "melhor_alcance", "melhor_vlr_kappa", "gid" )))

vetor_ice = c()  ### vetor para armazenar o menor ice de cada molelo

j=0
metodo="wl"

metodo