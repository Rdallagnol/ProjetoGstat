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

#########

t_cor_linha = data.table(rbind("GOLD", "PURPLE", "VIOLET", "YELLOW", "BLACK", "GREEN", "ORANGE", "PINK", "GRAY", "BROWN", "BLUE", "RED", "MAGENTA"))

######## variáveis ######################

#variáveis para semivariograma
#v_lambda = 0 # 0 = dados transformados
v_lambda = 1 # 1 = dados NÃO transformados

auto_lags=TRUE		# parametro que define automaticamente o nro de lags
nro_lags = 11 		#parametro semivariograma KO que estipula o nro de lags arbitrariamente

estimador = "classical" #parametro semivariograma KO = Matheron
#estimador = "modulus"	#parametro semivariograma OK = Cressie

cutoff = 50		#parametro semivariograma KO - porcentagem da distancia maxima entre os pontos
nro_pares = 30 		#parametro semivariograma KO

#parametros que identificam o tamanho do pixel do mapa final
tam_pixel_x = 5 #parametro dos mapas
tam_pixel_y = 5 #parametros dos mapas

classes = 5  	#número de classe no mapa (intervalos) - só no R

#Constante para gráfico Semivariograma
legenda_x_semiv = "Distância"
legenda_y_semiv = "Semivariância"
titulo_semiv = "Semivariograma experimental"
leg_x_pamostrais ="O - L"
leg_y_pamostrais ="S - N"

#########################################################
# Estabelece conexão com o PoststgreSQL usando RPostgreSQL
drv <- dbDriver("PostgreSQL")
drv

projeto = "db_projeto_schenatto_b"  	#área
atributo = "tb_prod_media_norm_amp"
local = 29182

# Configuração completa da conexão com o banco de dados
con <- dbConnect(drv, dbname=projeto,host="localhost",port=5432,user="postgres",password="P4P184k16r4f00f4r61k481P4P")
con

borda <- dbGetQuery(con,"select x, y from tb_borda")  #em utm
borda

#leitura dos dados da tabela de atributos do banco de dados
atrib = paste("select st_x(st_transform(the_geom,", local, ")), 
		st_y(st_transform(the_geom, ", local, ")),amo_medida from ", atributo)
frame_dados <- dbGetQuery(con,atrib)
frame_dados

dados <- as.geodata(frame_dados)
names(dados)
dados

##########################################################################################
#######################   MAPA TEMATICO  GERAL    #########################################
## borda
borda  # apresenta os dados da borda
#plot(borda, main=titulo_pamostrais, font.main = fonte_pamostrais,
plot(borda,
	xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)
polygon(borda)
#points(dados, pch=fonte_pamostrais, add=T)
points(dados, add=T)

apply(borda,2,range) #Mostra o mínimo e máximo das coordenadas
menor_X <- min(borda[,1]) #identifica o menor valor de X, primeira coluna 
menor_Y <- min(borda[,2]) #identifica o menor valor de Y, segunda coluna 
maior_X <- max(borda[,1]) #identifica o maior valor de X, primeira coluna 
maior_Y <- max(borda[,2]) #identifica o maior valor de Y, segunda coluna 
menor_X
menor_Y
maior_X
maior_Y

tam_pixel_x
tam_pixel_y

gr<-expand.grid(x=seq(menor_X,maior_X,by=tam_pixel_x), y=seq(menor_Y,maior_Y, by=tam_pixel_y))
plot(gr)
points(dados, pt.div="equal") #monta o grid de interpolação
gr
gi<- polygrid(gr,bor=borda)
gi
length(gi$x)
points(gi, pch="+", col=2) #o novo grid considerando apenas a região limitada
length(gr$x)

#################### krigagem ##########

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

############ bt 10/06/2016 - modelo escolhido ########### alterado em 14/06/2016 para individualizar as tabelas ice  # 30/06 para fazer de todos os melhores modelos
tb_matriz_ice = paste0 ("tb_ice_",atributo)
tb_matriz_ice
query_modelo = sprintf("select * from %s order by min_ice desc", tb_matriz_ice)
query_modelo
frame_modelo <- dbGetQuery(con,query_modelo)
frame_modelo


query_cont = sprintf("select count (*) from %s", tb_matriz_ice)
query_cont
v_cont <- dbGetQuery(con,query_cont)
v_cont

	i=0
	i
		while (i<v_cont)
		{

			i= i+1
			i
	melhor_contrib_geral = as.numeric(frame_modelo[i,5])
	melhor_alcance_geral = as.numeric(frame_modelo[i,6])
	melhor_modelo_geral = frame_modelo[i,2]
	melhor_metodo_geral = frame_modelo[i,3]
	melhor_vlr_kappa_geral = as.numeric(frame_modelo[i,7])

	melhor_contrib_geral
	melhor_alcance_geral
	melhor_modelo_geral
	melhor_metodo_geral
	melhor_vlr_kappa_geral

	id_modelo = as.numeric(frame_modelo[i,8])		#parametro do modelo escolhido
	cor_linha = t_cor_linha$V1[id_modelo]


	# para eliminar problema com o nome da tabela com .  ### bt 18/08/2016
	#nome= paste0 (atributo,"_",melhor_modelo_geral,"_",melhor_vlr_kappa_geral,"_",melhor_metodo_geral)}
	if (melhor_modelo_geral == "matern") { 
		if (melhor_vlr_kappa_geral == 1.5)
			nome= paste0 (atributo,"_",melhor_modelo_geral,"_1_5_",melhor_metodo_geral)
		else
			nome= paste0 (atributo,"_",melhor_modelo_geral,"_",melhor_vlr_kappa_geral,"_",melhor_metodo_geral)
	} else { 
		nome= paste0 (atributo,"_",melhor_modelo_geral,"_",melhor_metodo_geral)
	} 

	dados.var <- variog(dados,coords=dados$coords, data=dados$data,
		uvec=seq(min_dist,vlr_cutoff,l=nro_lags), lambda=v_lambda,
	 	estimator.type=estimador, max.dist=vlr_cutoff, pairs.min=nro_pares) 

	dados.var
	plot(dados.var, xlab = legenda_x_semiv, ylab = legenda_y_semiv, main = titulo_semiv)  

	#faz o ajuste novamente com o melhor modelo
	if (melhor_modelo_geral == "matern"){
		if (melhor_metodo_geral=="ols"){ 
			variograma.ols<-variofit(dados.var,ini=c(melhor_contrib_geral,melhor_alcance_geral),
				weights= "equal",cov.model= "matern", kappa=melhor_vlr_kappa_geral, max.dist=vlr_cutoff) 
		} else {
			variograma.ols<-variofit(dados.var,ini=c(melhor_contrib_geral,melhor_alcance_geral),
				cov.model= "matern", kappa=melhor_vlr_kappa_geral, max.dist=vlr_cutoff) 
			}
	} else {
		if (melhor_metodo_geral=="ols"){
			variograma.ols<-variofit(dados.var,ini=c(melhor_contrib_geral,melhor_alcance_geral),
				weights= "equal",cov.model= melhor_modelo_geral, max.dist=vlr_cutoff)
		} else {
			variograma.ols<-variofit(dados.var,ini=c(melhor_contrib_geral,melhor_alcance_geral),
				cov.model= melhor_modelo_geral, max.dist=vlr_cutoff)
			}
	}

	variograma.ols
	melhor_contrib_geral
	melhor_alcance_geral
	melhor_modelo_geral
	melhor_metodo_geral
	melhor_vlr_kappa_geral

nome_semiv = paste0 ("semiv_",nome,".jpg")
jpeg (filename = nome_semiv, quality=1600)

	plot(dados.var,xlab = legenda_x_semiv, ylab = legenda_y_semiv, main = paste ("Semivariograma ajustado pelo modelo",
		melhor_modelo_geral,melhor_vlr_kappa_geral,melhor_metodo_geral,atributo))
	lines(variograma.ols,col=cor_linha,pch=3) 
dev.off()

	kC=krige.control(obj=variograma.ols,lambda=v_lambda,micro.scale=0) #krigagem 
	kC
	dados.kC=krige.conv(dados, loc=gi, krige=kC) #Faz o mapa da variável dados por krigagem ordinária
	dados.kC
	length(dados.kC$pred)

	max(dados.kC$pred)
	min(dados.kC$pred)
	valores<-dados.kC$predict
	range(dados.kC$predict)

nome_mapa = paste0 ("mapa_",nome,".jpg")
jpeg (filename = nome_mapa, quality=1600)

	image(dados.kC, loc=gr, border=borda, col=gray(seq(1,0,l=classes)),
	main= paste ("Mapa interpolado pelo modelo",melhor_modelo_geral,melhor_vlr_kappa_geral,melhor_metodo_geral,atributo),font.main = 3,
	xlab=leg_x_pamostrais, ylab=leg_y_pamostrais, zlim=range(dados.kC$predict))
	zlim=range(dados.kC$predict)
dev.off()


}  # 30/06 bt fecha o while  # 23/08/2016




########################################################
##alterado em 17/08/2016 para gravar uma tabela para cada mapa
# Concatena colunas: coordenadas em UTM dos pontos e valores interpolados
lng = gi$x
lat = gi$y
medida = valores
interpol <- data.table(cbind(lng, lat, medida))

#nome_tab = paste0 ("tb_utm_",nome)
# Grava as coordenadas dos pontos e os respectivos valores interpolados no banco de dados na tabela "tb_utm"
#dbWriteTable(con, nome, interpol, overwrite = T)
dbWriteTable(con, "tb_utm", interpol, overwrite = T)

nome_mapa = paste0 ("inter_ko_",nome)
nome_tab = paste0 ("tb_",nome_mapa)
nome_mapa
nome_tab

##### select para incluir parametros no insert # bt 23/08/2016
#leitura dos dados da tabela de atributos do banco de dados
sql_cod_amostra = paste("select distinct amo_codamostra from ", atributo)
codamostra= dbGetQuery(con,sql_cod_amostra)
cod_amostra = codamostra$amo_codamostra

#sql_amostra = paste("select amo_codtipoatributo, amo_codarea from %s where gid=%i", atributo, cod_amostra$amo_codamostra)
sql_amostra = sprintf("select amo_codtipoatributo, amo_codarea from tb_amostra where gid=%i", cod_amostra)
sql_amostra
amostra <- dbGetQuery(con,sql_amostra)

tipo_atrib = amostra$amo_codtipoatributo
cod_area = amostra$amo_codarea
tipo_atrib
cod_area

## cria tabela com dados interpolados ### bt 18/08/2016
##gra_descricao, gra_codarea, gra_codtipoatributo, gra_data, gra_nometabela, gra_codamostra, gra_tampixelx, gra_tampixely, gra_tipogeometria, gra_tipointerpolador, gra_expoente, gra_tamanhoraio, gra_numeropontos
#queryINTER = sprintf ("select f_cria_mapa_R('%s',%i,%i,'%s',%i,%i,%i,'%s','%s',%.1f,%i,%i)",nome_mapa,1,1,nome_tab,2,tam_pixel_x,tam_pixel_y,'POLYGON','KO',melhor_vlr_kappa_geral,0,0)
queryINTER = sprintf ("select f_cria_mapa_R('%s',%i,%i,'%s',%i,%i,%i,'%s','%s',%.1f,%i,%i)",nome_mapa,cod_area,tipo_atrib,nome_tab,cod_amostra,tam_pixel_x,tam_pixel_y,'POLYGON','KO',melhor_vlr_kappa_geral,0,0)
queryINTER
dbGetQuery(con, queryINTER)


#}  # 30/06 bt fecha o while


###########################################################
## para conferir validação cruzada # bt 26/08/2106 ########
vc=xvalid(dados,model=variograma.ols,dist.epsilon =5.55274e-17,micro.scale=0)
vc
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
somatorio
media_em2 = somatorio / nro_amostras   	#média dos erros médios ao quadrado
media_em2
dp_em = sqrt(media_em2)				#raiz quadrada da média dos erros médios ao quadrado
dp_em
#####criar e gravar EM e DPEM na tabela ISI # bt 26/08/2016
nome_tab = paste0 ("tb_isi_",atributo)
nome_isi = paste0 ("ko_",melhor_modelo_geral,"_",melhor_vlr_kappa_geral,"_",melhor_metodo_geral)
dados_isi <- data.table(cbind(em,dp_em,nome_isi))
dbWriteTable(con, nome_tab, as.data.table(dados_isi), overwrite = T)



# Encerra a conexão com o banco de dados
dbDisconnect(con)


