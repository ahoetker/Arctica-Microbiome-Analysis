# Adjacency Matrix Creation Function
#
# Description: Custom implementation of algorithm calculating the adjacendy matrix. This will
#              turn correlation data into network data, allowing various network analysis methods to be applied.
# Required Parameters: df: dataframe
# Optional Parameters: signed: To use the signed or unsigned adjacency in the analysis, signed by default,
#                      thresh: the threshold for the adjacency matrix calculation, recommended changed to 6 for unsigned,
#                      verbose: Change to true for printing returned results to console

adj_matrix <- function(df,signed=TRUE,thresh=12,verbose=FALSE){
  # Create Pearson's correlation matrix
  corr <- cor(df, use="complete.obs", method="pearson")

  # Create the unsigned matrix
  unsigned <- apply(corr, c(1, 2), function(x) abs(x))

  # Create the signed matrix
  signed <- apply(corr, c(1, 2), function(x) 0.5+0.5*x)

  # Apply thresholding parameter (6 or 12 standard) to create adjacency matrix
  if(signed==TRUE){
    adj <- apply(signed, c(1, 2), function(x) x**thresh)
  } else {
    adj <- apply(unsigned, c(1, 2), function(x) x**thresh)
  }

  # By convention, diagonal of an adjacency matrix should be all 0's
  for(i in 1:nrow(adj)){
    for(j in 1:ncol(adj)){
      if(i==j){
        adj[i,j] = 0
      }
    }
  }

  # Create a results dataframe
  results <- as.data.frame(adj)
  colnames(results) <- colnames(df)

  # Print and return results
  if(verbose == TRUE){
    print(results)
  }
  return(results)

} # End desc_stats function