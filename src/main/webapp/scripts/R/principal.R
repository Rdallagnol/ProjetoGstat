args<-commandArgs(TRUE) 
area<-as.numeric(args[1])
amostra<-as.numeric(args[2])
desc<-args[3]
interpolador<-args[4]
tamx<-as.numeric(args[5])
tamy<-as.numeric(args[6])
expoente<-as.numeric(args[7])
vizinhos<-as.numeric(args[8])
estimador<-args[9]
nlags<-as.numeric(args[10])
npares<-as.numeric(args[11])  
nro_intervalos_alc<-as.numeric(args[12])
nro_intervalos_contr<-as.numeric(args[13])

area
amostra
desc
interpolador
tamx
tamy
expoente
vizinhos
estimador
nlags
npares
nro_intervalos_alc
nro_intervalos_contr


library('RPostgreSQL', lib.loc = 'C:/Users/Dallagnol/Documents/R/win-library/3.2')
pw <- {
  "1"
}
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "db_gstat",
                 host = "localhost", port = 5432,
                 user = "postgres", password = pw)
con



