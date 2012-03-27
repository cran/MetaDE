\name{MetaDE.merge}
\alias{MetaDE.merge}
\title{
	Merge microarray data sets 
}
\description{
	Merge microarray data sets in possibly irregular order.
}
\usage{
MetaDE.merge(x,MVperc=0)
}
\arguments{
\item{x}{a list of studies. Each study is a list with components:\cr
	\itemize{
         \item \bold{x}: the gene expression matrix.
		 \item \bold{y}: the outcome variable. For a binary outcome, 0 refers to "normal" and 1 to "diseased". For a multiple class outcome,
			the first level being coded as 0, the second as 1, and so on. For survival data, it is the survial time of the paitents.
		 \item \bold{censoring.status}:  0 refers to individual who did not experimented the outcome while 1 is used for patients who develop the event of interest.
			This object is NULL for binary, multiclass and continuous outcome.
       }
}
 \item{MVperc}{ a threshold to specificy which genes are remained for further analysis. The default is zero. }

}
\details{
	The gene expression data sets may be in possibly irregular order with different numbers of genes. This function is 
	used to extact the common genes across studies. The merged data sets have the same genes in the same order.
	
	When we combine a large of number of studies, the number of common genes may be very samll, so we allow to include somes gene 
	appearing in most studies and missing in few studies. The default is zero which means that we only include genes appearing in 
	all the studies.
}
\value{
  a list of studies. Each study is a list with components:\cr
	\itemize{	
	 \item \bold{x}: the gene expression matrix.
	 \item \bold{y}: the outcome.
	 \item \bold{censoring.status}: the censoring status. This only for survival data.
	}
}

\author{
	Jia Li and Xingbin Wang
}

\seealso{
 \code{\link{MetaDE.Read}}, \code{\link{MetaDE.filter}},\code{\link{ind.analysis}} and \code{\link{MetaDE.rawdata}}
}
\examples{
#================example test MetaDE.merge========================================================#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
time1=c(4,3,1,1,2,2,3,10,5,4)
event1=c(1,1,1,0,1,1,0,0,0,1)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
rownames(exp1)<-paste("g1",1:20,sep="_")
rownames(exp2)<-paste("g2",1:20,sep="_")
symbol1<-sample(c("SST","VGF","CNP","LPA"),20,replace=TRUE)
symbol2<-sample(c("SST","VGF","CNP","APOE"),20,replace=TRUE)
study1<-cbind(c(NA,NA,symbol1),rbind(rbind(time1,event1),exp1))
study2<-cbind(c(NA,symbol2),rbind(label2,exp2))
setwd(tempdir())
write.table(study1,"study1.txt",sep="\t")
write.table(study2,"study2.txt",sep="\t")
mydata.raw<-MetaDE.Read(c("study1","study2"),via="txt",skip=c(2,1),log=FALSE)

mydata.matched<-MetaDE.match(mydata.raw,"IQR")
mydata.merged<-MetaDE.merge(mydata.matched)
}
