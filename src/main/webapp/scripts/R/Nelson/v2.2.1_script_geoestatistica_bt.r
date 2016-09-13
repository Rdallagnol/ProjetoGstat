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

######## variáveis ######################

ISI = TRUE			#identifica que será utilizado o índice ISI para escolha do melhor modelo
#ISI = FALSE		#identifica que será utilizado o índice ICE para escolha do melhor modelo
	 
#variáveis para semivariograma
#v_lambda = 0 # 0 = dados transformados
v_lambda = 1 # 1 = dados NÃO transformados

auto_lags= TRUE		# parametro que define automaticamente o nro de lags
nro_lags = 11 		#parametro semivariograma KO que estipula o nro de lags arbitrariamente

estimador = "classical" #parametro semivariograma KO = Matheron
#estimador = "modulus"	#parametro semivariograma OK = Cressie

cutoff = 50		#parametro semivariograma KO - porcentagem da distancia maxima entre os pontos
nro_pares = 30 		#parametro semivariograma KO 

nro_intervalos_alc= 5 	#parametro Alcance parametros do semivariograma (KO)
nro_intervalos_contr= 5 #parametro Contribuição parametros do semivariograma (KO)

#parâmetros adicionados em 13/07/2016 (bt) # par
#parâmetros do expand.grid para criar vals da matriz de contribuição/alcance
min_seq_contr = 0  	# por padrão = 0 e receberá o valor de min_var mais adiante, ou usuário informa valor
min_seq_alc = 0 	# por padrão=0 e e receberá o valor de cutoff/4 ou min_dist_var mais adiante, ou usuário informa valor

t_cor_linha_ols = data.table(rbind("GOLD", "PURPLE", "VIOLET", "YELLOW", "BLACK", "GREEN", "ORANGE", "PINK", "GRAY", "BROWN", "BLUE", "RED", "MAGENTA"))
t_modelos = data.table(rbind("matern", "matern", "matern", "exp", "sph", "matern", "matern", "matern", "exp", "sph", "gaus", "gaus"))
t_kappa = data.table(rbind(1.0, 1.5, 2.0, 0.5, 0.5, 1.0, 1.5, 2.0, 0.5, 0.5, 0.5, 0.5))
t_metodo = data.table(rbind("ols", "ols", "ols", "ols", "ols", "wl", "wl", "wl", "wl", "wl", "wl", "ols"))
#t_modelos = data.table(rbind("exp", "sph", "gaus"))
#t_kappa = data.table(rbind(0.5, 0.5, 0.5))
nro_modelo=12

vlr_kappa=0			#parametro semivariograma KO

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

#parametros que identificam o tamanho do pixel do mapa final
tam_pixel_x = 5 #parametro dos mapas
tam_pixel_y = 5 #parametros dos mapas

classes = 5  	#número de classe no mapa (intervalos) - só no R

#########################################################
# Estabelece conexão com o PoststgreSQL usando RPostgreSQL
drv <- dbDriver("PostgreSQL")
drv

projeto = "db_projeto_schenatto_b"  	#área
atributo = "tb_prod_media_norm_amp"		#amostra
local = 29182

# Configuração completa da conexão com o banco de dados
con <- dbConnect(drv, dbname=projeto,host="localhost",port=5432,user="postgres",password="P4P184k16r4f00f4r61k481P4P")
con

#leitura dos dados da tabela de atributos do banco de dados
atrib = paste("select st_x(st_transform(the_geom,", local, ")), 
		st_y(st_transform(the_geom, ", local, ")),amo_medida from ", atributo)
frame_dados <- dbGetQuery(con,atrib)
frame_dados

dados <- as.geodata(frame_dados)
names(dados)
dados

#Análise exploratória dos dados
summary(dados$data)
mean (dados$data) 
var(dados$data)
sd(dados$data)
CV = sd(dados$data)*100/mean(dados$data)
CV
skewness(dados$data)
kurtosis(dados$data)
length(dados$data)

# Gráficos Descritivos 
plot(dados) 
hist(dados$data)

boxplot(dados$data,main=titulo_BoxPlot) #EXIBIR GRÁFICO (ARMAZENAR)

# ANÁLISE EXPLORATÓRIA ESPACIAL # Grafico Post-plot com legenda para o estudo de tendencia direcional.
points(dados,pt.div="quartile",col=c("yellow","green","red","blue"),main=titulo_PostPlot, xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)

	# ANÁLISE ESPACIAL
	# Calcular a maior e menor distancia da área considerando as coordenadas dados$coords para obter o cutoff de 50% da distancia maxima
	max_dist <- max(dist(dados$coords))
	min_dist <- min(dist(dados$coords))
	vlr_cutoff <- max_dist*cutoff/100 
	max_dist
	min_dist
	vlr_cutoff

	if (auto_lags==TRUE){
		nro_lags = round(vlr_cutoff/min_dist)	## bt 8/6/2016 - menor distancia das variancias
	}
	nro_lags
	dados.var <- variog(dados,coords=dados$coords, data=dados$data,
#		uvec=seq(0,vlr_cutoff,l=nro_lags), lambda=v_lambda,
		uvec=seq(min_dist,vlr_cutoff,l=nro_lags), lambda=v_lambda,
	 	estimator.type=estimador, max.dist=vlr_cutoff, pairs.min=nro_pares) 
#	 	estimator.type=estimador, pairs.min=nro_pares) 

	dados.var
	plot(dados.var, xlab = legenda_x_semiv, ylab = legenda_y_semiv, main = titulo_semiv)  
	# Informações do semivariograma experimental
	distancia <-  dados.var$u 
	semivariancia <- dados.var$v
	pares <- dados.var$n
	tabela <- cbind(distancia,semivariancia,pares)
	tabela

	min_dist_var = min(distancia)  ## bt 8/6/2016 - menor distancia das variancias
	min_dist_var
	## para ajustar os valores para o semivariograma
	min_var = min(semivariancia) # menor variância 
	max_var = max(semivariancia) # maior variância
	min_var
	max_var
	vlr_cutoff

	if (min_seq_alc==0){
#		min_seq_alc = min_dist_var	## bt 13/07/2016
		min_seq_alc = vlr_cutoff/4	## bt 13/07/2016
	}
	if (min_seq_contr==0){
		min_seq_contr = min_var		## bt 13/07/2016
	}

 	min_seq_alc
	vals <- expand.grid(seq(min_seq_contr,max_var, l=nro_intervalos_contr), 
#	vals <- expand.grid(seq(min_var,max_var, l=nro_intervalos_contr), 
	seq(min_seq_alc, vlr_cutoff, l=nro_intervalos_alc))
#	seq(vlr_cutoff/4, vlr_cutoff, l=nro_intervalos_alc))

	semiv_geral= paste0("semiv_geral_",atributo,".jpg")
semiv_geral
	jpeg (filename = semiv_geral, quality=1600)

	plot(dados.var,xlab='Distância',ylab='Semivariância',main= paste ("Semivariograma ajustado -",atributo) )
	vals
	cont = nro_intervalos_contr * nro_intervalos_alc
	cont
	
	#cria matriz para armazenar informações do ice
	matriz_ice<-matrix(nrow=0,ncol=9,
	dimnames = list(c(),c("modelo","metodo","min_ice", "melhor_contrib", "melhor_alcance", "melhor_vlr_kappa", "gid", "melhor_em", "melhor_dp_em" )))

	vetor_ice = c()  ### vetor para armazenar o menor ice de cada molelo

	t_modelos
	t_kappa 
	j=0
	j
	nro_modelo
	metodo="wl"

	while (j<nro_modelo)
	{
		#cria matriz para armazenar informações da validação cruzada
		matriz_vc<-matrix(nrow=0,ncol=9,
		dimnames = list(c(),c("Modelo", "EM", "EMR", "DP_EM", "DP_EMR", "DP_EMR_1", "EA","Metodo", "SDAE")))
		#cria vetores para armazenar informações da validação cruzada
		vetor_em = c()
		vetor_emr = c()
		vetor_dp_em = c()
		vetor_dp_emr = c()
		vetor_dp_emr_1 = c()
		vetor_ea = c()
		vetor_modelo = c()
		vetor_metodo =c()
		ice = c()
		A = c()
		B = c()
		vetor_contr = c()
		vetor_alcance = c()
		vetor_vlr_kappa = c()
		vetor_sdae=c()

		j=j+1
		j
		modelo = t_modelos$V1[j]
		vlr_kappa = as.numeric(t_kappa$V1[j])
		cor_linha_ols = t_cor_linha_ols$V1[j]
		metodo = t_metodo$V1[j]
	
#		if (j==((nro_modelo/2)+1)){
#			metodo="ols"
#		}

		modelo
		vlr_kappa
		metodo
		i=0
		i
		cont
		t_cont = 0  # zera a variável que armazena o tamanho da tabela table_ice de cada modelo# bt 23/05/2016

		while (i<cont)
		{
			i= i+1
			i
			contrib = as.numeric(vals$Var1[i])
			alcance = as.numeric(vals$Var2[i])
			contrib
			alcance
			if (modelo=="matern"){
				if (metodo=="ols"){
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),weights= "equal",cov.model= modelo, kappa= vlr_kappa, max.dist=vlr_cutoff)
				} else {
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),cov.model= modelo, kappa= vlr_kappa, max.dist=vlr_cutoff)
				}
			} else {
				if (metodo=="ols"){
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),weights= "equal",cov.model= modelo, max.dist=vlr_cutoff)
				} else {
				variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),cov.model= modelo, max.dist=vlr_cutoff)
				}
			}
			lines(variograma.ols,col=cor_linha_ols)
			variograma.ols
			#armazena informções da validação cruzada em variáveis
			vc=xvalid(dados,model=variograma.ols,micro.scale=0)
#			vc=xvalid(dados,model=variograma.ols,dist.epsilon =5.55274e-17,micro.scale=0)

			vc
				emr=1
				dp_emr =1
				dp_emr_1 = 0

			if ((mean (vc$std.error) != "NaN"))
			{
				emr = mean (vc$std.error) #erro médio reduzido
				dp_emr = round(sd (vc$std.error),digits=20) #desvio padrão do erro médio reduzido
				dp_emr_1 = ((sd (vc$std.error))-1) #desvio padrão do erro médio reduzido - 1
			}
			
			vc$error
				em = round(mean (vc$error),digits=20) #erro médio
em
##### DPem  calculado - bt - 08/07/2016  ###########
				nro_amostras = length(vc$error)   #conta o número de elementos
				n = 0
				somatorio = 0
				while (n < nro_amostras)
				{
					n = n+1
					somatorio = somatorio + (vc$error[n]*vc$error[n])
				}
				media_em2 = somatorio / nro_amostras   	#média dos erros médios ao quadrado
				dp_em = sqrt(media_em2)				#raiz quadrada da média dos erros médios ao quadrado
				media_em2
				dp_em
###########################################

				ea=round(sum(abs(vc$predicted-vc$data)),digits=20)  	#armazenar informções do erro absoluto

############# BT 09/06/2016 # ISI
				vc
				vc$data
				vc$predicted
				em
#				dif = (vc$data - vc$predicted - em)^2
				dif = (vc$data - vc$predicted)^2
				dif
				media_dif = mean(dif)
				media_dif
				sdae = sqrt(media_dif)
				sdae
###################################

				#popula vetores com informações da validação cruzada
				vetor_em <- rbind(vetor_em,c(em))
				vetor_emr = rbind(vetor_emr,c(emr))
				vetor_dp_em = rbind(vetor_dp_em,c(dp_em))
				vetor_dp_emr = rbind(vetor_dp_emr,c(dp_emr))
				vetor_dp_emr_1 = rbind(vetor_dp_emr_1,c(dp_emr_1))
				vetor_ea = rbind(vetor_ea,c(ea))
				vetor_modelo = rbind(vetor_modelo,c(modelo))
				vetor_metodo = rbind(vetor_metodo,c(metodo))
				vetor_contr = rbind(vetor_contr,c(contrib)) 
				vetor_alcance = rbind(vetor_alcance,c(alcance))
				vetor_vlr_kappa = rbind(vetor_vlr_kappa,c(vlr_kappa))
				vetor_sdae = rbind(vetor_sdae,c(sdae))

				#popula matriz com informações da validação cruzada
				matriz_vc<-rbind(matriz_vc,c(modelo,em,emr,dp_em,dp_emr,dp_emr_1,ea,metodo,sdae))
				matriz_vc

				t_cont = t_cont +1    ###variável para armazenar o tamanho da tabela table_ice # bt 23/05/2016

		}
matriz_vc

					##########cálculo do ICE - 25/02/2016 - bt	
#		if(is.numeric(vetor_emr)==TRUE)
#		{

##################################################################
###### bt 06/07/2016 - retirei os indices, só deixei EM ##########
			if (ISI==TRUE)
			{
				#####################
				# BT 8/6/2016 - calculo do ISI (Vanderlei)
				#####################
				max_abs_em = max (abs(vetor_em))
				min_abs_sdae = min (abs(vetor_sdae))
				max_abs_sdae = max (abs(vetor_sdae))
				max_abs_em
				min_abs_sdae
				max_abs_sdae

				A = (abs(vetor_em))/max_abs_em
				B = ((abs(vetor_sdae)) - min_abs_sdae)/ max_abs_sdae
				##############################################
			}else{
				#####################
				# calculo do ICE (Bazzi)
				#####################
				max_abs_emr = max (abs(vetor_emr))
				max_abs_dp_emr_1 = max (abs(vetor_dp_emr_1))
				max_abs_dp_emr_1
				max_abs_emr		
				A = (abs(vetor_emr))/max_abs_emr
				B = (abs(vetor_dp_emr_1))/max_abs_dp_emr_1
			}

			A
			B
			ice = round(A + B, digits=20)
ice
##################################################################
###### bt 06/07/2016 - retirei os indices, só deixei EM ##########
##################################################################
	
			min_ice=min(ice)
min_ice
			table_ice <- data.table(cbind(ice, vetor_contr, vetor_alcance, vetor_modelo, vetor_metodo, vetor_vlr_kappa, vetor_em, vetor_dp_em))
			table_ice

			i=0

			while (i<t_cont)
			{
				i= i+1
				if (table_ice$V1[i] == min_ice) {
					melhor_contrib = as.numeric(table_ice$V2[i])
					melhor_alcance = as.numeric(table_ice$V3[i])
					melhor_modelo = table_ice$V4[i]
					melhor_metodo = table_ice$V5[i]
					melhor_vlr_kappa = as.numeric(table_ice$V6[i])
					melhor_em = as.numeric(table_ice$V7[i])
					melhor_dp_em = as.numeric(table_ice$V8[i])

					i=t_cont				
				} 
			}

			table_ice
			melhor_contrib
			melhor_alcance
			melhor_modelo
			melhor_metodo
			melhor_vlr_kappa
			melhor_em
			melhor_dp_em
	
			#popula matriz com informações do melhor ICE de cada modelo
			matriz_ice<-rbind(matriz_ice,c(modelo, metodo, min_ice, melhor_contrib, melhor_alcance, melhor_vlr_kappa, j, melhor_em, melhor_dp_em))
			matriz_ice

			vetor_ice = rbind(vetor_ice,c(min_ice))  ### vetor para armazenar o menor ice de cada molelo
			vetor_ice
#		}
}

dev.off()

	matriz_ice

#### bt 16/06/2016 gráfico com o melhor semivariograma de cada modelo/metodo ###
	matriz_legenda<-matrix(nrow=0,ncol=3,
	dimnames = list(c(),c("modelo","metodo","vlr_kappa")))

semiv_melhores= paste0("semiv_melhores_",atributo,".jpg")
jpeg (filename = semiv_melhores, quality=1600)

	plot(dados.var,xlab='Distância',ylab='Semivariância',main= paste ("Semiariograma ajustado -",atributo) )
	i=0
	i
		while (i<nro_modelo)
		{

			i= i+1
			i
			modelo = matriz_ice[i,1]
			metodo = matriz_ice[i,2]
			contrib = as.numeric(matriz_ice[i,4])
			alcance = as.numeric(matriz_ice[i,5])
			vlr_kappa = as.numeric(matriz_ice[i,6])
			cor_linha_ols = t_cor_linha_ols$V1[i]

			if (modelo=="matern"){
				if (metodo=="ols"){
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),weights= "equal",cov.model= modelo, kappa= vlr_kappa, max.dist=vlr_cutoff)
				} else {
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),cov.model= modelo, kappa= vlr_kappa, max.dist=vlr_cutoff)
				}
			} else {
				if (metodo=="ols"){
					variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),weights= "equal",cov.model= modelo, max.dist=vlr_cutoff)
				} else {
				variograma.ols<-variofit(dados.var,ini=c(contrib,alcance),cov.model= modelo, max.dist=vlr_cutoff)
				}
			}
			lines(variograma.ols,col=cor_linha_ols)

#			matriz_legenda<-rbind(matriz_legenda,(cbind(modelo, metodo, vlr_kappa)))
		}
dev.off()

atributo
nome_tab = paste0 ("tb_ice_",atributo)
nome_tab
nome_arq = paste0 (atributo,".txt")
nome_arq
write.table(matriz_ice,nome_arq)

# Grava as coordenadas dos pontos e os respectivos valores interpolados no banco de dados na tabela "tb_utm"
dbWriteTable(con, nome_tab, as.data.table(matriz_ice), overwrite = T)

# Encerra a conexão com o banco de dados
dbDisconnect(con)
