setwd("D:/ProjetoGstat/src/main/webapp/file")
arquivo_dados = "D:/ProjetoGstat/src/main/webapp/scripts/dados/Tasca_RSP 0-10 2013_UTM.txt"
arquivo_contorno = "D:/ProjetoGstat/src/main/webapp/scripts/dados/Tasca_contorno_UTM.txt"
nro_lags = 11
estimador = "classical"
nro_pares = 30
legenda_x_semiv = "Dist�ncia"
legenda_y_semiv = "Semivari�ncia"
titulo_semiv = "Semivariograma experimental"
cor_linha = "BLUE"
nro_intervalos=20
titulo_pamostrais = "Mapa de dispers�o dos pontos amostrais"
fonte_pamostrais = 3
leg_x_pamostrais ="O - L"
leg_y_pamostrais ="S - N"
tam_pixel = 5
classes = 5
nome_arquivo_saida <- paste("D:/ProjetoGstat/src/main/webapp/scripts/dados/teste.txt")
require(geoR)
require(splancs)
require(classInt)
library(stats)
require(MASS)
library(e1071)
dados= read.geodata(arquivo_dados,head=T,coords.col=1:2,data.col=3) 
mean (dados$data) 
CV = sd(dados$data)*100/mean(dados$data)
skewness(dados$data)
kurtosis(dados$data)
borda<-read.table(arquivo_contorno,head=T)
x=paste("plot",".png")
png(x)
plot(dados)
dev.off()
x=paste("boxplot",".png")
png(x)
boxplot(dados$data,main='Gráfico Boxplot')
dev.off()
x=paste("post-plot",".png")
png(x)
points(dados,pt.div="quartile",col=c("yellow","green","red","blue"),main="Post-Plot", xlab="Coordenadas E-W", ylab="Coordenadas N-S")
legend(197300, 7187200,c("Min - Q1","Q1 - Mediana","Mediana - Q3","Q3 - Max"),fill=c("yellow", "green", "red", "blue")) 
dev.off()
max_dist <- max(dist(dados$coords))
min_dist <- min(dist(dados$coords))
cutoff <- max(dist(dados$coords)/2)
dados.var <- variog(dados,uvec=seq(0,cutoff,l=nro_lags),
estimator.type=estimador,pairs.min=nro_pares)
dados.var
x=paste("variogram",".png")
png(x)
plot(dados.var, xlab = legenda_x_semiv, ylab = legenda_y_semiv, main = titulo_semiv)  
dev.off()




