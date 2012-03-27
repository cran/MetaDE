
\name{ind.analysis}
\alias{ind.analysis}
%\docType{data}
\title{Identify differentially expressed genes in each individual dataset}
\description{
  \code{ind.analysis} is a function to perform individual analysis. The outputs are measures (p-values) for meta-analysis. 
}
\usage{
ind.analysis(x, ind.method = c("f", "regt", "modt", "pairedt",
                 "pearsonr", "spearmanr", "F", "logrank"), miss.tol =
                 0.3, nperm = NULL, tail, ...)
}

\arguments{
\item{x}{a list of studies. Each study is a list with components:\cr
	\itemize{
         \item \bold{x}: the gene expression matrix.
		 \item \bold{y}: the outcome variable. For a binary outcome, 0 refers to "normal" and 1 to "diseased". For a multiple class outcome,
			the first level being coded as 0, the second as 1, and so on. For survival data, it is the survial time of the paitents.
		 \item \bold{censoring.status}:  0 refers to individual who did not experimented the outcome while 1 is used for patients who develop the event of interest.  
       }
}
\item{miss.tol}{The maximum percent missing data allowed in any gene (default 30 percent).}
\item{nperm}{The number of permutations. If nperm is NULL,the results will be based on asymptotic distribution.}
\item{ind.method}{a character vector to specify the statistical test to test if there is association between the variables
            and the labels (i.e. genes are differentially expressed in each study). see "Details".    
   }
\item{tail}{a character string specifying the alternative hypothesis,must be one of "abs" (default), "low" or "high". }
\item{...}{ Additional arguments.}
}

\details{
	The available statistical tests for argument, \code{ind.method}, are:\cr
	\itemize{
		\item \code{"regt":} Two-sample t-statistics (unequal variances).  
		\item \code{"modt":} Two-sample t-statistics with the variance is modified by adding a fudging parameter.
			In our algorithm, we choose the penalized t-statistics used in Efron et al.(2001) and Tusher et al. (2001). The fudge parameter s0 is chosen to be the median
			variability estimator in the genome.
		\item \code{"pairedt":} Paired t-statistics for the design of paired samples.  
        \item \code{"pearsonr":} Pearson's correlation. It is usually chosen for quantitative outcome.
		\item \code{"spearmanr":} Spearman's correlation. It is usually chosen for quantitative outcome.
		\item \code{"F":} the test is based on F-statistics. It is usually chosen where there are 2 or more classes.
	}
	For the argument, \code{miss.tol}, the default is 30 percent.  For those genes with less than miss.tol *100 percent missing are imputed using KNN method in package,impute; 
	for those genes with more than or equal miss.tol*100 percent missing are igmored for the further analysis.
}
\value{ a list with components: \cr
  \item{stat}{the value of test statistic for each gene}
  \item{p}{the p-value for the test for each gene}
  \item{bp}{the p-value from nperm permutations for each gene. It will be used for the meta analysis.
   It can be NULL if you chose asymptotic results. }
}


\references{
	Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019.
	
	Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 

}
\seealso{ \code{\link{MetaDE.Read}},\code{\link{MetaDE.match}},\code{\link{MetaDE.merge}},\code{\link{MetaDE.filter}},\code{\link{MetaDE.pvalue}} and \code{\link{MetaDE.rawdata}}
}
\examples{
#--generate two pseudo datasets----#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))

#the input has to be arranged in lists
x<-list(list(x=exp1,y=label1),list(x=exp2,y=label2))

# start individual analysis for each study: 
#find genes whose expession is higher in class 2 vs class 1 using moderated t test for both studies
test1<-ind.analysis(x,ind.method=c("modt","modt"),tail="high",nperm=100) 
#here I want to use two-sample t test for study 1 and moderated t test for study 2.
test2<-ind.analysis(x,ind.method=c("regt","modt"),tail="abs",nperm=100)

#--------time to event---------#
#--generate three pseudo datasets----#
exp1<-matrix(rnorm(20*10),20,10)
time1=c(4,3,1,1,2,2,3,10,5,4)
event1=c(1,1,1,0,1,1,0,0,0,1)
#study 2
exp2<-matrix(rnorm(20*10,1.5),20,10)
time2=c(4,30,1,10,2,12,3,10,50,2)
event2=c(0,1,1,0,0,1,0,1,0,1)
#study 3
exp3<-matrix(rnorm(20*15),20,15)
time3=c(1,27,40,10,2,6,1,10,50,100,20,5,6,8,50)
event3=c(0,1,1,0,0,1,0,1,0,1,1,1,1,0,1)

#the input has to be arranged in lists
test3<-list(list(x=exp1,y=time1,censoring.status=event1),list(x=exp2,y=time2,censoring.status=event2),
list(x=exp3,y=time3,censoring.status=event3))

# start individual analysis for each study: i use log rank test for all studies
test3.res<-ind.analysis(test3,ind.method=rep("logrank",3),nperm=100,tail='abs')
 
}

\keyword{Meta-analysis DE genes}
