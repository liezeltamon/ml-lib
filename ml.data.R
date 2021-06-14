################################################################################
# Function to prepare data for training or prediction
################################################################################
# LIBRARIES & DEPENDENCIES * LIBRARIES & DEPENDANCIES * LIBRARIES & DEPENDENCIES 
################################################################################
#suppressWarnings(suppressPackageStartupMessages(library(caret)))
### FUNCTION ###################################################################
ml.data <- function(datafile = 'path to dataset',
                    problem = 'Classification or Regression',
                    label.id = 'column name of labels in datafile'
){
  
  X <- read.csv(file=datafile, header=T, stringsAsFactors=F)
                     
  if( sum(colnames(X)==label.id)!=1 ){
    stop("ml.data(): Missing or multiple columns for label.")
  }
  
  # Fix nature type of labels 
  Y <- X[,label.id]
  if(problem=="Classification"){
    
    print("Classification problem!", quote=F)
    # Convert labels to factors
    Y <- make.names(Y)
    Y <- factor(x=Y, levels=unique(Y))
    
  } else if(problem=="Regression"){
    print("Regression problem!", quote=F)
  } else {
    stop("ml.data(): Invalid problem argument. Classification or Regression only.")
  }
  
  # Finalise training data
  X <- X[,colnames(X)!=label.id]
  
  return( list(X=X, Y=Y) )
  
}

# rm(list=ls()); gc()

