\name{MetaDE.match}
\alias{MetaDE.match}
\alias{Match.gene}
\title{
	Match the probeIds to gene symbol
}
\description{
	When multiple probes (or probe sets) matched to an identical gene symbol, these functions are used to match them into a single gene symbol.}
\usage{
Match.gene(x, pool.replicate = c("average", "IQR"))
MetaDE.match(x,pool.replicate = c("average", "IQR"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ a list of studies. Each study is a list with components:\cr
	\itemize{	
	 \item \bold{x}: the gene expression matrix.
	 \item \bold{y}: the outcome.
	 \item \bold{censoring.status}: the censoring status. This only for survival data.
	 \item \bold{symbol}: the gene symbols.
	}
}
  \item{pool.replicate}{ a character to specify the method to match multiple probeIds to a single gene symbol. see "Details".}
}
\details{
 To be able to be combined, Probes (or probe sets) in each study need to be matched to official gene symbols. When multiple probes (or probe sets)
 matched to an identical gene symbol, the probe that presented the greatest inter-quartile range (IQR) was selected to represent the target gene symbol. 
 Larger IQR represents greater variability (and thus greater information content) in the data and this probe matching method has been recommended in Bioconductor.
 Another matching method is to take average across genes.
 
 Function, \code{Match.gene},is used to perform matching on a single study; \code{MetaDE.match} is used to apply on multiple study sets.
}

\value{
	A list with components:\cr
  \item{data }{a list of gene expression datasets.}
  \item{l }{a list of labels.}
}
\references{
Gentleman R, Carey V, Huber W, Irizarry R, Dudoit S (eds.): Bioinformatics and Computational Biology Solutions Using R and Bioconductor: Springer; 2005.
}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
 \code{\link{MetaDE.Read}}, \code{\link{MetaDE.filter}}
}
\examples{
#================example simulate data sets===============================================#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
time1=c(4,3,1,1,2,2,3,10,5,4)
event1=c(1,1,1,0,1,1,0,0,0,1)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
rownames(exp1)<-paste("g1",1:20,sep="_")
rownames(exp2)<-paste("g2",1:20,sep="_")
symbol1<-sample(c("SST","VGF","CNP"),20,replace=TRUE)
symbol2<-sample(c("SST","VGF","CNP"),20,replace=TRUE)
study1<-cbind(c(NA,NA,symbol1),rbind(rbind(time1,event1),exp1))
study2<-cbind(c(NA,symbol2),rbind(label2,exp2))
setwd(tempdir())
write.table(study1,"study1.txt",sep="\t")
write.table(study2,"study2.txt",sep="\t")
mydata<-MetaDE.Read(c("study1","study2"),via="txt",skip=c(2,1),log=FALSE)

#----------------------Test MetaDE.match--------------------------------------------------#
mydata.matched2<-MetaDE.match(mydata,"IQR")
}

