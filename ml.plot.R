################################################################################
# Generate performance measure plots for caret models using MLeval::evalm()
################################################################################
# FLAGS * FLAGS * FLAGS * FLAGS * FLAGS * FLAGS * FLAGS * FLAGS * FLAGS * FLAGS
### DIRECTORY STRUCTURE ########################################################
whorunsit = "LiezelMac" # "LiezelMac", "LiezelCluster", "LiezelLinuxDesk",
# "AlexMac", "AlexCluster"

if( !is.null(whorunsit[1]) ){
  # This can be expanded as needed ...
  if(whorunsit == "LiezelMac"){
    lib = "/Users/ltamon/DPhil/lib"
    data.dir = "/Users/ltamon/Database"
    wk0.dir = "/Users/ltamon/hackathon"
  } else {
    stop("The supplied <whorunsit> option is not created in the script.", quote=F)
  }
}
wk.dir = paste0(wk0.dir, "/ml-project-1")
out.dir = wk.dir
### OTHER SETTINGS #############################################################
dset.v = rep(x="140", times=3)
model.v = c("xgbTree", "earth", "rbf")
ind.v = rep(x="1", times=3)
seed.v = rep(x="364", times=3)

out.id = "140_seed364_models_evalm"
################################################################################
# LIBRARIES & DEPENDENCIES * LIBRARIES & DEPENDENCIES * LIBRARIES & DEPENDENCIES 
################################################################################
suppressWarnings(suppressPackageStartupMessages(library(MLeval)))
################################################################################
# MAIN CODE * MAIN CODE * MAIN CODE * MAIN CODE * MAIN CODE * MAIN CODE *
################################################################################
# Load models into a list
len <- length(model.v)
model.lst <- sapply(X=1:len, simplify=FALSE, FUN=function(i){
  
  load(paste0(wk.dir, "/", model.v[i], "/output/", dset.v[i], "_ind", ind.v[i], 
              "_seed", seed.v[i], "_", model.v[i], ".FIT.RData"))
  eval(parse(text=paste0(
    'return(', model.v[i], '.FIT)'
  )))
       
})

EVALM <- MLeval::evalm(list1=model.lst, gnames=model.v, title=out.id)
save(EVALM, file=paste0(out.dir, "/", out.id, "_evalm.RData"))

pdf(file=paste0(out.dir, "/", out.id, "_evalm.pdf"), height=10, width=10)
par(mfrow=c(2,2))

for( x in c("roc", "proc", "prg", "cc") ){
  print(EVALM[[x]])
}

dev.off()

# rm(list=ls()); gc()

