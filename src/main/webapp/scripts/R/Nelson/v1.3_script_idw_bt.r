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
#require (geosptdb)
require (gstat)


######## variáveis ######################

expoente = 0 		#se for 0 (zero) será escontrado o melhor expoente, ou define-se o valor do expoente
vizinhos = 10 		#parametro Inverso da distancia
exp_inicial = 0.5 		#parametro Inverso da distancia
exp_final = 4.0  		#parametro Inverso da distancia
intervalo = 0.5		#parametro Inverso da distancia
raio = 0			#parametro Inverso da distancia

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

projeto = "db_projeto_schenatto_b"
atributo = "tb_prod_media_norm_amp"
local = 29182

# Configuração completa da conexão com o banco de dados
con <- dbConnect(drv, dbname=projeto,host="localhost",port=5432,user="postgres",password="P4P184k16r4f00f4r61k481P4P")
con

borda <- dbGetQuery(con,"select x, y from tb_borda")  #em utm
#borda

#leitura dos dados da tabela de atributos do banco de dados
atrib = paste("select st_x(st_transform(the_geom,", local, ")), 
		st_y(st_transform(the_geom, ", local, ")),amo_medida from ", atributo)
frame_dados <- dbGetQuery(con,atrib)
frame_dados

dados <- as.geodata(frame_dados)
names(dados)
dados

############################################################

#Análise exploratória dos dados
summary(dados$data)
mean (dados$data) 
var(dados$data)
sd(dados$data)
CV = sd(dados$data)*100/mean(dados$data)
CV
skewness(dados$data)
kurtosis(dados$data)

# Gráficos Descritivos 
plot(dados) 
hist(dados$data)

boxplot(dados$data,main=titulo_BoxPlot) #EXIBIR GRÁFICO (ARMAZENAR)

# ANÁLISE EXPLORATÓRIA ESPACIAL # Grafico Post-plot com legenda para o estudo de tendencia direcional.
points(dados,pt.div="quartile",col=c("yellow","green","red","blue"),main=titulo_PostPlot, xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)

##########################################################################################
#######################   MAPA TEMATICO  GERAL    #########################################
## borda
borda  # apresenta os dados da borda
is.table(borda)
plot(borda, main=titulo_pamostrais, font.main = fonte_pamostrais,
	xlab=leg_x_pamostrais, ylab=leg_y_pamostrais)
polygon(borda)
points(dados, pch=fonte_pamostrais, add=T)

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
####################

#### ## bt - 25/08/2016 - escolhe o melhor expoente ####
atributo
tb_vc = "tb_vc"
atributo

#	queryID = sprintf ("select f_idw_main('%s','%s',%x,%i,%.1f,%i,%i)",atributo,tb_vc,exp_inicial,exp_final,intervalo,vizinhos,raio)  
#	queryID = sprintf ("select f_main2('%s','%s',%i,%i,%i)",atributo,tb_vc,36,vizinhos,raio)  

if (expoente == 0){
	queryID = sprintf ("select f_idw_isi_main('%s','%s',%.1f,%.1f,%.1f,%i,%i)",atributo,tb_vc,exp_inicial,exp_final,intervalo,vizinhos,raio)  
}else{
	queryID = sprintf ("select f_idw_isi_main('%s','%s',%.1f,%.1f,%.1f,%i,%i)",atributo,tb_vc,expoente,expoente,expoente,vizinhos,raio)  
}
	queryID
	expoente = dbGetQuery(con, queryID)  
	expoente = as.numeric(expoente)
	expoente
	exp_inicial
	exp_final
	intervalo

	#######################################################
	#################### bt -idw - 28/04/2016 ##############
	### Criar objeto 'sp'
	frame_id <- data.frame(x=dados$coords[,1], y=dados$coords[,2], atrib=dados$data)
	names(frame_id)
	frame_id
	coordinates(frame_id) <- ~x+y
	coordinates(frame_id)
	atrib~1
	class(frame_id)
	plot(frame_id, asp=1, axes=T, pch=20)
	polygon(borda, border=2)

	frame_id$x
	frame_id$y
	frame_id$atrib
	coordinates(frame_id)
	frame_id

	### IDW Default
	frame_id$atrib~1
	frame_id
	gi
	gridded(gi) = ~x+y
	gridded(gi)

	frame_id$atrib~1
	dados

	dados.id <- idw(frame_id$atrib~1, frame_id, gi, nmax=vizinhos, idp=expoente)  #Faz o mapa da variável dados por id
	dados.id
	length(dados.id$var1.pred)
	max(dados.id$var1.pred)
	min(dados.id$var1.pred)
	mean(dados.id$var1.pred)
	dados.id$var1.pred

dados.id$var1.pred
dados.id$var1.var
gi
gr
length(gi)
length(gr)

	str (dados.id)
	valores<-dados.id$var1.pred
	valores
	gi$x

	# Concatena colunas: coordenadas em UTM dos pontos e valores interpolados
	lng = gi$x
	lat = gi$y
	medida = valores
	interpol <- data.table(cbind(lng, lat, medida))
	interpol


nome_mapa = paste0 ("inter_idw_",expoente*10,"_",atributo)
nome_tab = paste0 ("tb_",nome_mapa)
nome_mapa
nome_tab

nome_mapa_jpg = paste0 (nome_mapa,".jpg")
nome_mapa_jpg
jpeg (filename = nome_mapa_jpg, quality=1600)

	image(interpol,col=gray(seq(1,0,l=classes)), 
	main= paste("Mapa interpolado por ID",expoente,atributo),font.main = 3,
	xlab=leg_x_pamostrais, ylab=leg_y_pamostrais, zlim=range(valores)) 
polygon(borda)

dev.off()

# Grava as coordenadas dos pontos e os respectivos valores interpolados no banco de dados na tabela "tb_utm"
dbWriteTable(con, "tb_utm", interpol, overwrite = T)


##### select para incluir parametros no insert # bt 23/08/2016
#leitura dos dados da tabela de atributos do banco de dados
sql_cod_amostra = paste("select distinct amo_codamostra from ", atributo)
codamostra= dbGetQuery(con,sql_cod_amostra)
cod_amostra = codamostra$amo_codamostra
cod_amostra

#sql_amostra = paste("select amo_codtipoatributo, amo_codarea from %s where gid=%i", atributo, cod_amostra$amo_codamostra)
sql_amostra = sprintf("select amo_codtipoatributo, amo_codarea from tb_amostra where gid=%i", cod_amostra)
sql_amostra
amostra <- dbGetQuery(con,sql_amostra)
amostra

tipo_atrib = amostra$amo_codtipoatributo
cod_area = amostra$amo_codarea
tipo_atrib
cod_area

## cria tabela com dados interpolados ### bt 18/08/2016
#queryIDW = sprintf ("select f_cria_mapa_R('%s',%i,%i,'%s',%i,%i,%i,'%s','%s',%.1f,%i,%i)",nome_mapa,1,1,nome_tab,1,tam_pixel_x,tam_pixel_y,'POLYGON','IDW',expoente,raio,vizinhos)
##gra_descricao, gra_codarea, gra_codtipoatributo, gra_data, gra_nometabela, gra_codamostra, gra_tampixelx, gra_tampixely, gra_tipogeometria, gra_tipointerpolador, gra_expoente, gra_tamanhoraio, gra_numeropontos
queryIDW = sprintf ("select f_cria_mapa_R('%s',%i,%i,'%s',%i,%i,%i,'%s','%s',%.1f,%i,%i)",nome_mapa,cod_area,tipo_atrib,nome_tab,cod_amostra,tam_pixel_x,tam_pixel_y,'POLYGON','IDW',expoente,raio,vizinhos)
queryIDW
dbGetQuery(con, queryIDW)


# Encerra a conexão com o banco de dados
dbDisconnect(con)

