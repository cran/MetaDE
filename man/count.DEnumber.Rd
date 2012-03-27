\name{count.DEnumber}
\alias{count.DEnumber}
\title{ Count the number of differentially expressed (DE) genes 
}
\description{
	a function to summary the number of DE genes at given p-value or FDR thresholds.
}
\usage{
count.DEnumber(result, p.cut, q.cut)
}
\arguments{
  \item{result}{ A p-value matrix or an object file from metaDE.pvalue,metaDE.minMCC, metaDE.ES
}
  \item{p.cut}{
	a numeric vecter to specify the p-value thresholds at which the DE number is counted.
}
  \item{q.cut}{
	a numeric vecter to specify the FDR thresholds at which the DE number is counted.
}

}
\details{
 To count the DE number at FDR thresholds, the p-values were corrected by Benjamini-Hochberg procedure.  
}
\value{
	a list with components:\cr
	\item{pval.table }{a table contains the DE numbers counted at given p-value thresholds.}
	\item{FDR.table}{a table contains the DE numbers counted at given FDR thresholds.}
}
\references{
Benjamini Y, Hochberg Y: Controlling the False Discovery Rate - a Practical and Powerful Approach to Multiple Testing. Journal of the Royal Statistical Society Series B-Methodological 1995, 57(1):289-300.}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
\code{\link{draw.DEnumber}}
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
count.DEnumber(res,p.cut=c(0.01,0.05),q.cut=c(0.01,0.05))
}
