
\name{MetaDE.minMCC}
\alias{MetaDE.minMCC}
\docType{data}
\title{Identify differentially expressed genes by integrating multiple studies(datasets) using minMCC approach}
\description{
  \code{MetaDE.minMCC} 
  Identify differentially expressed genes with the same pattern across studies/datasets.
}
\usage{MetaDE.minMCC(x,nperm=100,miss.tol=0.3)
}

\arguments{
\item{x}{a list of data sets and their labels. The first list is a list of datasets,
         the second list is a list of their labels. see examples for details.}
\item{nperm}{The number of permutations. If nperm is NULL,the results will be based on asymptotic distribution.}
\item{miss.tol}{The maximum percent missing data allowed in any gene (default 30 percent).}
}
\value{A list containing: \cr
  \item{meta.analysis$meta.stat}{the statistics for the chosen meta analysis method}
  \item{meta.analysis$pval}{the p-value for the above statistic. It is calculated from permutation.}
  \item{meta.analysis$FDR}{the FDR of the p-value.}
  \item{meta.analysis$AW.weight}{The optimal weight assigned to each dataset/study for each gene if the 'AW' or 'AW.OC'
  method was chosen.}
  \item{raw.data}{the raw data of your input. That's x. This part will be used for plotting.}
}

\references{
Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019. 

Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 
}
\seealso{
 \code{\link{MetaDE.rawdata}}
 \code{\link{MetaDE.pvalue}}
 \code{\link{MetaDE.ES}}
 \code{\link{draw.DEnumber}}
}

\examples{
label1<-rep(0:2,each=5)
label2<-rep(0:2,each=4)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5),matrix(rnorm(5*20,2.5),20,5))
exp2<-cbind(matrix(rnorm(4*20),20,4),matrix(rnorm(4*20,1.5),20,4),matrix(rnorm(4*20,2.5),20,4))
x<-list(list(exp1,label1),list(exp2,label2))

MetaDE.minMCC(x,nperm=100)

}


\keyword{Meta-analysis DE genes}
