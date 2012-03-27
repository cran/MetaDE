
\name{draw.DEnumber}
\alias{draw.DEnumber}
\docType{data}
\title{A function to plot the number of DE genes against FDR obtained from the Meta-analysis.}
\description{
  \code{draw.DEnumber(result,maxcut,mlty=NULL,mcol=NULL,mlwd=NULL,mpch=NULL,FDR=TRUE)} 
  plot the number of DE genes against FDR obtained from the Meta-analysis.
}
\usage{draw.DEnumber(result,maxcut,mlty=NULL,mcol=NULL,mlwd=NULL,mpch=NULL,FDR=TRUE)
}

\arguments{
\item{result}{A p-value matrix or an object file from metaDE.rawdata.pvalue,metaDE.pvalue,metaDE.minMCC, metaDE.ES}
\item{FDR}{use FDR for cutpoints if true, p-value otherwise}
\item{maxcut}{The maximum cut point for FDR or P-value}
\item{mlty}{line type for each line. default is set}
\item{mcol}{line colour. defaut is set}
\item{mlwd}{line width for each line. default is set}
\item{mpch}{symbol for each line. default is set}
}
\value{A figure containing: \cr
  \item{figure}{p-value(or FDR) vs numberof detected genes for individual analysis as well as meta analysis.}

}

\references{
  Li and Tseng (2011) and Lu, Li and Tseng (2009).
}
\seealso{\code{\link{count.DEnumber}}
}

\examples{
#---example 1: Meta analysis of Differentially expressed genes between two classes----------#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*200),200,5),matrix(rnorm(5*200,2),200,5))
exp2<-cbind(matrix(rnorm(5*200),200,5),matrix(rnorm(5*200,1.5),200,5))
x<-list(list(exp1,label1),list(exp2,label2))

# here I used modt to generate p-values. 
DEgene<-ind.analysis(x,ind.method=rep("regt",2),tail="abs",nperm=100)

#--then you can use Fisher's method to combine the above p-values
res<-MetaDE.pvalue(DEgene,meta.method='Fisher')
draw.DEnumber(res,FDR=TRUE,maxcut=0.1)

}


\keyword{Meta-analysis DE genes}
