<<<<<<< HEAD
setwd("C:/Users/Emily/Documents/TeamGOATS")
=======
#!/usr/bin/env Rscript
>>>>>>> fd6943110e47ad9d0101470e89a6dcb1f3501800

## since libraries will be pulled, make sure repository is set
repos = "http://cran.us.r-project.org"
get.pkg <- function(pkg){
  loaded <- do.call("require",list(package=pkg))
  if(!loaded){
    print(paste("trying to install",pkg))
    install.packages(pkg,dependencies=TRUE,repos=repos)
    loaded <- do.call("require",list(package=pkg))
    if(loaded){
      print(paste(pkg,"installed and loaded"))
    } 
    else {
      stop(paste("could not install",pkg))
    }    
  }
}
get.pkg("RCurl")
get.pkg("XML")
get.pkg("ncdf4")
get.pkg("devtools")
get.pkg("MODISTools")

<<<<<<< HEAD
# Scrape Github for new data
## Grab raw html
zika_URL <- getURL("https://github.com/BuzzFeedNews/zika-data/tree/master/data/parsed/colombia")

## Read the Github reference table data into R
zika_table = readHTMLTable(zika_URL)[[1]]

## Store the dates of when each file was updated in the object "update"
update = as.Date(zika_table[,4],"%b%d,%Y")
=======
load("zika.RData")
update.old = update

data.repo = "https://github.com/BuzzFeedNews/zika-data/tree/master/data/parsed/colombia"

# Scrape Github for new data
## Grab raw html
zika_URL <- getURL(data.repo)

## Read the Github reference table data into R
zika_table = readHTMLTable(zika_URL)[[1]]
muni_data = as.matrix(zika_table[3:nrow(zika_table),]) # Extract the municipal data

## Store the dates of when each file was updated in the object "update"
update = as.Date(substr(muni_data[,2],20,29)) # Extract dates from .csv file names
>>>>>>> fd6943110e47ad9d0101470e89a6dcb1f3501800

## Plot histogram of when new files were uploaded
hist(update,"days",col="grey")

<<<<<<< HEAD
## Create a subset of the FIA reference table which includes only the files that were updated more recently than our specified download date
#zika_table[which(update > ),] # Only include files updated more recently than our last download date

# Pull the data off the web
## Loop over the files in our subsetted reference table and grab these files off the website using wget
wlef = read.csv("colombia-municipal-2016-01-09.csv")
total = sum(wlef[,"zika_total"])
total
=======
raw.path = "https://raw.githubusercontent.com/BuzzFeedNews/zika-data/master/data/parsed/colombia"
data = list()
total = matrix(data=NA,nrow=length(update))
for(i in 1:length(update)){
  data[[i]] = read.csv(paste0(raw.path,"/",muni_data[i,2]))
  total[i] = sum(data[[i]][,"zika_total"])
  #myfile = file.path("C:/Users/Emily/Documents/TeamGOATS/",paste0("file",i,".csv"))
  #datafile = read.csv(paste0(raw.path,"/",muni_data[i,2]))
  #write.csv(datafile,file=myfile)
}

plot(update,total,xlab="Time",ylab="Total confirmed and suspected")
barplot(as.vector(total),names.arg=update,xlab="Time",ylab="Total confirmed and suspected cases")

#############################################################################################
# TRY LATER: Only downloading new data
# If a new data file has been added, download it
#if(length(update) > length(update.old)) {
  ## Create a subset of the FIA reference table which includes only the files that were updated more recently than our specified download date
  #new_data = muni_data[which(update > update.old),] # Only include files updated more recently than our last download date
  # Pull the data off the web
  ## Loop over the files in our subsetted reference table and grab these files off the website 
  #raw.data = "https://raw.githubusercontent.com/BuzzFeedNews/zika-data/master/data/parsed/colombia"
  #total <- matrix(data=NA,nrow=nrow(new_data))
  #for(i in 1:nrow(new_data)){
    #data = read.csv(paste0(raw.data,"/",new_data[i,2]))
    #total[i] = sum(data[,"zika_total"])
  #}
#}
#############################################################################################

save.image("zika.RData")
#save

### Later, once server is working, need to make this script executable by using chmod
# Cron job directory: /home/carya/TeamGOATS/get_data.R
>>>>>>> fd6943110e47ad9d0101470e89a6dcb1f3501800
