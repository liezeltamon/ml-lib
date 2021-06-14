################################################################################
# Function to predict with a model using training data or new data using the
# caret package
################################################################################
# LIBRARIES & DEPENDENCIES * LIBRARIES & DEPENDANCIES * LIBRARIES & DEPENDENCIES 
################################################################################
#suppressWarnings(suppressPackageStartupMessages(library(caret)))
### FUNCTION ###################################################################
ml.pred <- function(datafile = 'new datafile for prediction; set to NULL to predict
                                on training dataset only',
                    model.list = 'list of models',
                    problem = 'Classification or Regression',
                    label.id = 'column name of labels in datafile'
){
                     
  #-------------------Dataset
  
  if( !is.null(datafile) ){
    
    d.lst <- ml.data(datafile=datafile, problem=problem, label.id=label.id)
    testX <- d.lst$X
    testY <- d.lst$Y
    rm(d.lst)
    
  } else {
    
    testX <- NULL
    testY <- NULL
    
  }
  
  if(problem=="Classification"){
    PRED <- extractProb(models=model.list, testX=testX, testY=testY, verbose=T)
  } else if(problem=="Regression"){
    PRED <- extractPrediction(models=model.list, testX=testX, testY=testY, verbose=T)
  } else {
    stop("ml.pred(): Invalid problem argument. Classification or Regression only.")
  }

  return(PRED)
  
}

# rm(list=ls()); gc()

