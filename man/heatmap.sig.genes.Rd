
\name{heatmap.sig.genes}
\alias{heatmap.sig.genes}
\docType{data}
\title{A function to plot the heatmap of DE genes detectred at a given FDR threshold from the Meta-analysis.}
\description{
  \code{heatmap.sig.genes},a function to draw the
  Heatmap of DE genes given a FDR cut point obtained from the Meta-analysis.
}
\usage{heatmap.sig.genes(result,meta.method, fdr.cut=0.2,color="GR")
}

\arguments{
\item{result}{The object file from MetaDE.pvalue,MetaDE.ES or metaDE.minMCC.}
\item{meta.method}{If multiple methods were chosen for the meta analysis, the user needs to specify which which method is to be used for plotting.}
\item{fdr.cut}{cut off for FDR for the meta analysis result.}
\item{color}{The color scheme for the heatmap. "GR" is the default. "GR" stands for green, black,red. "BY"
 stands for blue,black and yellow.}
}
\value{A figure shows the standardized expression levels for the DE genes detected by
meta analysis across studies/datasets.}


\references{
Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019. 

Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 

}

\examples{
#------example 2: -----------#
# here I generate two pseudo datasets
set.seed(123)
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*200),200,5),matrix(rnorm(5*200,2),200,5))
exp2<-cbind(matrix(rnorm(5*200),200,5),matrix(rnorm(5*200,1.5),200,5))

#the input has to be arranged in lists
x<-list(list(exp1,label1),list(exp2,label2))

#here I used the modt test for individual study and used Fisher's method to combine results
#from multiple studies.
meta.res2<-MetaDE.rawdata(x=x,ind.method=c('modt','modt'),meta.method=c('Fisher',"maxP"),nperm=200)
heatmap.sig.genes(meta.res2, meta.method="maxP",fdr.cut=1,color="GR") #plot all genes
heatmap.sig.genes(meta.res2, meta.method="Fisher",fdr.cut=0.05,color="GR")  

}


\keyword{Meta-analysis DE genes}
