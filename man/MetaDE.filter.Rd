\name{MetaDE.filter}
\alias{MetaDE.filter}
\title{ A function to filter genes	
}
\description{
	\code{MetaDE.filter} filters genes in the gene expression data sets.
}
\usage{
MetaDE.filter(x, DelPerc)
}
%- maybe also 'usage' for other objects documented here.
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
  \item{DelPerc}{ a numeric vector of size 2, which specify the percentage of genes to be filtered in the two sequential
  steps of gene filtering. see "Details".
}

}
\details{
Two sequential steps of gene filtering were performed in \code{MetaDE.filter}. In the first step, we filtered out genes with very low gene expression that were 
identified with small average expression values across majority of studies. Specifically, mean intensities of each gene across all samples in each study were 
calculated and the corresponding ranks were obtained. The sum of such ranks across five studies of each gene was calculated and genes with the lowest alpha percent
 rank sum were considered un-expressed genes (i.e. small expression intensities) and were filtered out. Similarly, in the second step, we filtered out non-informative
 (small variation) genes by replacing mean intensity in the first step with standard deviation. Genes with the lowest beta percent rank sum of standard deviations were filtered out. 
}
\value{
  a list of studies. Each study is a list with components:\cr
	\itemize{	
	 \item \bold{x}: the gene expression matrix.
	 \item \bold{y}: the outcome.
	 \item \bold{censoring.status}: the censoring status. This only for survival data.
	}
}
\references{
Xingbin Wang, Yan Lin, Chi Song, Etienne Sibille* and George C Tseng*. (2012) Detecting disease-associated genes with confounding variable adjustment and the impact on genomic meta-analysis: with application to major depressive disorder. BMC Bioinformatics. tentatively accepted. 
}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
 \code{\link{MetaDE.Read}}, \code{\link{MetaDE.match}},\code{\link{MetaDE.rawdata}},\code{\link{ind.analysis}} and \code{\link{MetaDE.rawdata}}
}
\examples{
#================Example Test Filter.gene================================================#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*200),200,5),matrix(rnorm(5*200,2),200,5))
exp2<-cbind(matrix(rnorm(5*300),300,5),matrix(rnorm(5*300,1.5),300,5))
rownames(exp1)<-paste("g1",1:200,sep="_")
rownames(exp2)<-paste("g2",1:300,sep="_")
symbol1<-sample(paste("symbol_",1:20,sep=""),200,replace=TRUE)
symbol2<-sample(paste("symbol_",1:20,sep=""),300,replace=TRUE)
study1<-cbind(c(NA,symbol1),rbind(label1,exp1))
study2<-cbind(c(NA,symbol2),rbind(label2,exp2))
setwd(tempdir())
write.table(study1,"study1.txt",sep="\t")
write.table(study2,"study2.txt",sep="\t")
mydata<-MetaDE.Read(c("study1","study2"),via="txt",skip=c(2,1),log=FALSE)
mydata.matched<-MetaDE.match(mydata,"IQR")
mydata.Merged<-MetaDE.merge(mydata.matched)
mydata.filtered<-MetaDE.filter(mydata.Merged,DelPerc=c(0.1,0.2))
ind.res<-ind.analysis(mydata.filtered,ind.method=c("regt","regt"),tail="abs",nperm=10)
meta.res<-MetaDE.rawdata(mydata.filtered,ind.method=c("regt","regt"),meta.method="Fisher",ind.tail="abs",nperm=10,paired=rep(FALSE,2))
}
