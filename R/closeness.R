#' Closeness Centrality
#' @description Computes closeness centrlaity of each node in a network
#' 
#' @param A An adjacency matrix of network data
#' 
#' @param weighted Is the network weighted?
#' Defaults to TRUE.
#' Set to FALSE for unweighted measure of closeness centrality
#' 
#' @return A vector of closeness centrality values for each node in the network
#' 
#' @examples
#' A <- TMFG(neoOpen)$A
#'
#' #Weighted LC
#' LC <- closeness(A)
#' 
#' #Unweighted LC
#' LC <- closeness(A, weighted = FALSE)
#' 
#' @references
#' Rubinov, M., & Sporns, O. (2010). 
#' Complex network measures of brain connectivity: Uses and interpretations. 
#' \emph{Neuroimage}, \emph{52}, 1059-1069.
#' doi: \href{https://doi.org/10.1016/j.neuroimage.2009.10.003}{10.1016/j.neuroimage.2009.10.003}
#' 
#' @author Alexander Christensen <alexpaulchristensen@gmail.com>
#' 
#' @export 
#Closeness Centrality----
closeness <- function (A, weighted = TRUE)
{
    if(nrow(A)!=ncol(A))
    {stop("Input not an adjacency matrix")}
    
    A <- abs(A)
    A <- as.matrix(A)
    
    if (!weighted)
    {D<-distance(A,weighted=FALSE)
    }else if(weighted)
    {D<-distance(A,weighted=TRUE)}
    
    C <- vector("numeric", length = ncol(D))
    
    for(i in 1:ncol(D))
    {C[i]<-1/sum(D[,i])}
    
    LC<-C*100
    
    LC<-round(LC,3)
    
    names(LC) <- colnames(A)
    
    return(LC)
}
#----