\name{MetaDE.Read}
\alias{MetaDE.Read}
\title{ Read data sets into R}
\description{
	Function to import data set(s) into R and reformat it (them) to form required for other functions in MetaDE package.
}
\usage{
MetaDE.Read(filenames, via = c("txt", "csv"), skip,matched=FALSE, log = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{filenames}{ a character vecter specifying the names of data sets to read data values from. Should be a tab-separated or comma-separated text file, with one row per gene set. }
  \item{via}{ a character to specify the type of data sets. "txt" means tab delimited files and "csv" means comma-delimited files.
}
  \item{skip}{ a vecter of size K (the number of data sets) composes of 1 or 2. see 'Details'.}
  \item{matched}{a logical to specify whether the gene ProbeIDs have been matched into gene symbols in each data set.}
  \item{log}{ a logical to specify wheter data sets need to be log2-transformed.}
}
\details{
	The files to be read in should be prepared strictly according following format:\cr
	If \code{matched} is FALSE, column 1 has gene ProbeIds, column 2 has gene symbols, remaining columns are samples.
	If \code{matched} is TRUE, column 1 has gene symbols, remaining columns are samples.
	If the data set is a survival data, the second row should has the survival time,and third row should have the status of events,and remaining rows are gene expression files
	. otherwise, the second row should has the labels of samples and remaing rows are gene expression profiles.
	
	If the ith file is a survival data,the corresponding element of \code{skip} should be 2, otherwise, 1.

	The user can prepare the files according the structure of files wrote out using the example file.
}
\value{
  a list of studies. Each study is a list with components:\cr
	\itemize{	
	 \item \bold{x}: the gene expression matrix.
	 \item \bold{y}: the outcome.
	 \item \bold{censoring.status}: the censoring status. This only for survival data.
	 \item \bold{symbol}: the gene symbols. This is only for un-matched raw data.
	}
}
\references{
 Xingbin Wang, Jia Li and George C Tseng. Conducting Meta-analysis in R with the MetaDE package. http:xxxxx/MetaDE.pdf 
}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
 \code{\link{MetaDE.match}}, \code{\link{MetaDE.rawdata}}
}
\examples{
#================example test MetaDE.Read ==================================================#
setwd(tempdir())
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
rownames(exp1)<-paste("g1",1:20,sep="_")
rownames(exp2)<-paste("g2",1:20,sep="_")
study1<-rbind(label1,exp1)
study2<-rbind(label2,exp2)
write.table(study1,"study1.txt",sep="\t")
write.table(study1,"study2.txt",sep="\t")
mydata<-MetaDE.Read(c("study1","study2"),via="txt",skip=rep(1,2),matched=TRUE,log=FALSE)
#================Non-matched  =============================================================#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
rownames(exp1)<-paste("g1",1:20,sep="_")
rownames(exp2)<-paste("g2",1:20,sep="_")
symbol1<-sample(c("SST","VGF","CNP"),20,replace=TRUE)
symbol2<-sample(c("SST","VGF","CNP"),20,replace=TRUE)
study1<-cbind(c(NA,symbol1),rbind(label1,exp1))
study2<-cbind(c(NA,symbol2),rbind(label2,exp2))
setwd(tempdir())
write.table(study1,"study1.txt",sep="\t")
write.table(study2,"study2.txt",sep="\t")
mydata<-MetaDE.Read(c("study1","study2"),via="txt",skip=rep(1,2),log=FALSE)


}

