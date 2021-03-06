#' Community Closeness Centrality
#' @description Computes the community closeness centrality measure of each
#' community in a network
#' 
#' @param A An adjacency matrix of network data
#' 
#' @param comm A vector or matrix corresponding to the
#' community each node belongs to
#' 
#' @param weighted Is the network weighted?
#' Defaults to FALSE.
#' Set to TRUE for weighted measures
#' 
#' @return A vector of community closeness centrality values for each specified
#' community in the network
#' (larger values suggest more central positioning)
#' 
#' @examples
#' A <- TMFG(neoOpen)$A
#' 
#' comm <- igraph::walktrap.community(convert2igraph(abs(A)))$membership
#' 
#' #Weighted
#' result <- comm.close(A, comm)
#' 
#' #Unweighted
#' result <- comm.close(A, comm, weighted = FALSE)
#'
#' @references 
#' Christensen, A. P., Cotter, K. N., Silvia, P. J., & Benedek, M. (2018)
#' Scale development via network analysis: A comprehensive and concise measure of Openness to Experience
#' \emph{PsyArXiv}, 1-40.
#' doi: \href{https://doi.org/10.31234/osf.io/3raxt}{10.31234/osf.io/3raxt}
#'
#' @author Alexander Christensen <alexpaulchristensen@gmail.com>
#' 
#' @export
#Community Closeness Centrality----
comm.close <- function (A, comm, weighted = FALSE)
{
    if(is.null(comm))
    {stop("comm must be input")}
    
    comm <- as.vector(comm)
    
    if(ncol(A)!=length(comm))
    {stop("length of comm does not match nodes in matrix")}
    
    uniq <- unique(comm)
    len <- length(uniq)
    
    allP <- pathlengths(A, weighted = weighted)$ASPLi
    mean.allP <- mean(allP)
    remove <- vector("numeric",length=len)
    
    for(j in 1:len)
    {
        rem <- which(comm==uniq[j])
        
        remove[j] <- 1/mean(allP[rem])
    }
    
    names(remove) <- uniq
    
    return(remove)
}
#----