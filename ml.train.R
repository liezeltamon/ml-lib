################################################################################
# Function to train a model with a pre-determined and pre-processed training 
# dataset using the caret package. 
################################################################################
# LIBRARIES & DEPENDENCIES * LIBRARIES & DEPENDANCIES * LIBRARIES & DEPENDENCIES 
################################################################################
#suppressWarnings(suppressPackageStartupMessages(library(foreach)))
#suppressWarnings(suppressPackageStartupMessages(library(doParallel)))
#source(paste0(lib, "/UTL_doPar.R"))

#suppressWarnings(suppressPackageStartupMessages(library(caret)))

## Add required packages (see caret guide) for chosen model.method
### FUNCTION ###################################################################
ml.train <- function(datafile = 'path to validity-checked, pre-processed 
                                 training dataset',
                     nCPU = 'number of CPUs for parallel computing',
                     
                     out.dir = 'output directory',
                     problem = 'Classification or Regression',
                     label.id = 'column name of labels in datafile',
                     seed = 'set seed for reproducibility',
                     
                     eval.metric = 'performance measure, see metric argument
                                    of caret::train()' ,
                     model.method = 'caret name for the model method',
                     model.id = 'id to indicate dataset and run',
                     grid.obj = 'hyperparameter grid object',
                     trcontrol.obj = 'trainControl object',
                     saveModel = 'boolean, save model?'
                     ){
  
  out.id <- paste0(model.id, "_seed", seed, "_", model.method)
  
  #-------------------Dataset
  d.lst <- ml.data(datafile=datafile, problem=problem, label.id=label.id)
              
  #-------------------Training
  print("NOTE: Model fitting...", quote=F)
  
  start.time <- Sys.time()
  
  set.seed(seed)
  FIT <- caret::train(x=d.lst$X,
                      y=d.lst$Y,
                      preProcess=NULL, 
                      weights=NULL,
                      method=model.method,
                      metric=eval.metric,
                      trControl=trcontrol.obj,
                      tuneGrid=grid.obj)
  
  end.time <- Sys.time()
  end.time-start.time 
  
  rm(d.lst)
  
  # Save model
  if(saveModel){
    save(FIT, file=paste0(out.dir, "/", out.id, ".model.RData"))
  }
  
  #-------------------Plot
  
  # Plot performance measure vs. hyperparameters tuned
  pdf(file=paste0(out.dir, "/", out.id, ".FIT.pdf"),
      height=10, width=10)
  
  print(plot(FIT, main=out.id))
  
  dev.off()
  
  return(FIT)
  
}

# rm(list=ls()); gc()

