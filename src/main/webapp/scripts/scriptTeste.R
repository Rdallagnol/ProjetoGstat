##install.packages("RPostgreSQL", repos = "http://cran.us.r-project.org")
library('RPostgreSQL', lib.loc = 'C:/Users/Dallagnol/Documents/R/win-library/3.2')
pw <- {
  "1"
}
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "db_gstat",
                 host = "localhost", port = 5432,
                 user = "postgres", password = pw)

args<-commandArgs(TRUE)   
x1<-as.numeric(args[1])
x2<-as.numeric(args[2])

sql_command <- paste("INSERT INTO users(username, password, role)VALUES ('Rodrigo',",x1,", ",x2,")")

dbGetQuery(con, sql_command)
out=dbGetQuery(con, "select * from users")

out
