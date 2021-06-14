################################################################################
# Function to create seeds based on hyperparameter grid and validation method
### FUNCTION ###################################################################
ml.seed <- function(seed = 'set seed before setting seeds further',
                    CVnum = 'k in k-fold', 
                    CVrep = 'number of times k-fold validation will be repeated',
                    tune.len = 'number of combinations of hyperparameters'){
  
  set.seed(seed) 
  
  if(CVrep>0){
    a <- CVnum*CVrep
  } else if(CVrep==0){
    a <- CVnum
  } else {
    stop("ml.seed(): CVrep should be >=0.")
  }
  
  seeds <- vector(mode="list", length=(a+1))
  
  for(si in 1:a){
    seeds[[si]] <- sample.int(n=10000, size=tune.len)
  }
  seeds[[a+1]] <- sample.int(n=10000, size=1)
  
  return(seeds)
  
}

# rm(list=ls()); gc()

