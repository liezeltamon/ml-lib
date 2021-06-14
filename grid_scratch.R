################################################################################
# Mains script for training a model with a pre-determined training dataset 
# (pre-processed) using the caret package 
################################################################################
#-------------------Validation scheme
# K-fold validation
CVnum = 6
# Repeat of K=fold validation
CVrep = 1

#-------------------Parameter tuning
# Resource on hands-on ML with R
#https://bradleyboehmke.github.io/HOML/index.html

# xgbTree (eXtreme Gradient Boosting | Classification, Regression | xgboost, plyr)
tg.xgbTree = expand.grid(nrounds = c(500, 600),
                         # Same as in GBM, typically [3,10]
                         max_depth = 3, #c(3,4,5),
                         # Learning rate
                         eta = 0.01, #c(0.001,0.005,0.01),
                         # A node is split only when the resulting split gives a positive 
                         # reduction in the loss function. Gamma specifies the minimum loss 
                         # reduction required to make a split.
                         # gamma=0 means No regularisation, [0,infinity]
                         gamma = 0,
                         # Similar to max_features in GBM. Denotes the fraction of columns/features 
                         # to be randomly sampled for each tree.
                         # colsample_bytree=1 means no subsampling
                         colsample_bytree = 1,
                         # Minimum number of values assigned to a leaf
                         min_child_weight = 3,
                         # Same as the subsample of GBM. Denotes the fraction of 
                         # observations to be randomly sampled for each tree, typically [0.5,1]
                         # To avoid trees becoming highly correlated
                         subsample = c(0.4, 0.6, 0.8))


# PRIM (Patient Rule Induction Method | Classification | supervisedPRIM)
tg.PRIM <- expand.grid(peel.alpha=c(0.05, seq(0.1, 0.15, 0.02)),  #c(0.01, 0.05),
                       paste.alpha=c(0.001, 0.005, 0.01), #c(0.01, 0.05)
                       mass.min=seq(0.004, 0.01, 0.002)) #c(0.01, 0.05)

# earth (Multivariate Adaptive Regression Spline | )
tg.earth <- expand.grid(
  # The maximum degree of interactions and the number of terms retained in the final model;
  # Rarely is there any benefit in assessing greater than 3-rd degree interactions
  degree = 1:3, 
  # The number of terms to retain in the final model; we suggest starting out with 10 evenly 
  # spaced values for nprune and then you can always zoom in to a region once you find an 
  # approximate optimal solution.
  nprune = floor(seq(from=3, to=19, length.out=9)) #floor(seq(from=2, to=100, length.out=10)) 
  )

# Deep learning - Neural Network

tg.nnet <- expand.grid(size=seq(3, 15, 1), #Hidden Units (nodes)
                       decay=c(0, 0.1, 0.01))

# Read RBF network vs. MLP

# mlpWeightDecayML (Multi-Layer Perceptron, multiple layers | Classification, Regression | RSNNS)
tg.mlpWeightDecayML <- expand.grid(layer1=c(40, 35, 30),  #Hidden Units (nodes) layer1
                                   layer2=c(25, 20, 15),  #Hidden Units (nodes) layer2
                                   layer3=c(20, 15, 10),  #Hidden Units (nodes) layer3
                                   # Weight decay, regularization parameter to avoid over-fitting
                                   decay=c(0.01, 0.001) 
                                   )

# rbf (Radial Basis Function Network | Classification, Regression | RSNNS)
tg.rbf <- expand.grid(size=seq(2, 19, 1)) #Hidden Units (nodes)

# rm(list=ls()); gc()



