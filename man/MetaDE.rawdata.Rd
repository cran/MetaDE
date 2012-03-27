
\name{MetaDE.rawdata}
\alias{MetaDE.rawdata}
\docType{data}
\title{Identify differentially expressed genes by integrating multiple studies(datasets)}
\description{
  \code{MetaDE.rawdata} 
  Identify differentially expressed genes by integrating multiple studies(datasets). }
\usage{MetaDE.rawdata(x, ind.method = c("modt", "regt", "pairedt", "F",
                 "pearsonr", "spearmanr", "logrank"), meta.method =
                 c("maxP", "maxP.OC", "minP", "minP.OC", "Fisher",
                 "Fisher.OC", "AW", "AW.OC", "roP", "roP.OC",
                 "Stouffer", "Stouffer.OC", "SR", "PR", "minMCC",
                 "FEM", "REM", "rankProd"), paired = NULL, miss.tol =
                 0.3, rth = NULL, nperm = NULL, ind.tail = "abs",
                 asymptotic = FALSE, ...)
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
\item{ind.method}{a character vector to specify the statistical test to test whether there is association between the variables
and the labels (i.e. genes are differentially expressed in each study). see "Details". 
}
\item{ind.tail}{a character string specifying the alternative hypothesis, must be one of "abs" (default), "low" or "high". 
  }
\item{meta.method}{ a character to specify the type of Meta-analysis methods to combine the p-values or effect sizes. 
See "Detials".
 }
\item{paired}{ a vector of logical values to specify that whether the design of ith study is paired or not. If the ith study is paired-design
, the correponding element of \code{paired} should be TRUE otherwise FALSE.}
\item{miss.tol}{The maximum percent missing data allowed in any gene (default 30 percent).}
\item{rth}{this is the option for roP and roP.OC method. rth means the rth smallest p-value.}
\item{nperm}{The number of permutations. If nperm is NULL,the results will be based on asymptotic distribution.}
\item{asymptotic}{A logical values to specify whether the parametric methods is chosen to calculate the p-values in meta-analysis. The default is
FALSE.}
\item{...}{Additional arguments.}
 }
\details{
	The available statistical tests for argument, \code{ind.method}, are:\cr
	\itemize{
		\item \code{"regt":} Two-sample t-statistics (unequal variances).  
		\item \code{"modt":} Two-sample t-statistics with the variance is modified by adding a fudging parameter.
			In our algorithm, we choose the penalized t-statistics used in Efron et al.(2001) and Tusher et al. (2001). The fudge parameter s0 is chosen to be the median
			variability estimator in the genome.\cr
		\item \code{"pairedt":} Paired t-statistics for the design of paired samples.  
        \item \code{"pearsonr":}, Pearson's correlation. It is usually chosen for quantitative outcome.
		\item \code{"spearmanr":}, Spearman's correlation. It is usually chosen for quantitative outcome.
		\item \code{"F":}, the test is based on F-statistics. It is usually chosen where there are 2 or more classes.
	}
	The options for argument,\code{mete.method},are listed below:\cr
	\itemize{
		\item \code{"maxP":} the maximum of p value method.
		\item \code{"maxP.OC":} the maximum of p values with one-sided correction.
		\item \code{"minP":} the minimum of p values from "test" across studies.
		\item \code{"minP.OC":} the minimum of p values with one-sided correction.
		\item \code{"Fisher":} Fisher's method (Fisher, 1932),the summation of -log(p-value) across studies.
		\item \code{"Fisher.OC":} Fisher's method with one-sided correction (Fisher, 1932),the summation of -log(p-value) across studies.
        \item \code{"AW":} Adaptively-weighted method (Li and Tseng, 2011).
		\item \code{"AW.OC":} Adaptively-weighted method with one-sided correction (Li and Tseng, 2011).
		\item \code{"SR":} the naive sum of the ranks method.
		\item \code{"PR":} the naive product of the ranks methods.
		\item \code{"minMCC":} the minMCC method.
		\item \code{"FEM":} the Fixed-effect model method.
		\item \code{"REM":} the Random-effect model method.
		\item \code{"roP":}  rth p-value method.
		\item \code{"roP.OC":} rth p-value  method with one-sided correction.
		\item \code{"rankProd":}rank Product method.
	}
	
	For the argument, miss.tol, the default is 30 percent. In individual analysis, for those genes with less than miss.tol *100 percent, 
	missing values are imputed using KNN method in package,impute; for those genes with more than or equal miss.tol*100 percent missing 
	are igmored for the further analysis. In meta-analysis, for those genes with less than miss.tol *100 percent missing,the p-values are calculated if asymptotic is TRUE. 


}
 
 
\value{
A list with components: \cr
  \item{meta.analysis}{a list of the results of meta-analysis with components:
	\itemize{
		\item meta.stat: the statistics for the chosen meta analysis method
		\item pval: the p-value for the above statistic. It is calculated from permutation.
		\item FDR: the p-values corrected by Benjamini-Hochberg.
		\item AW.weight: The optimal weight assigned to each dataset/study for each gene if the '\code{AW}' or '\code{AW.OC}'
				method was chosen.
	}
 }
 
 \item{ind.stat}{ the statistics calculated from individual analysis. This is for \code{meta.method} expecting "\code{REM}","\code{FEM}","\code{minMCC}" and "\code{rankProd}".}
 \item{ind.p}{ the p-value matrix calculated from individual analysis. This is for \code{meta.method} expecting "\code{REM}","\code{FEM}","\code{minMCC}" and "\code{rankProd}".}
 \item{ind.ES}{ the effect size matrix calculated from indvidual analysis. This is only \code{meta.method}, "REM" and "FEM".}
 \item{ind.Var}{ the corresponding variance matrix calculated from individual analysis. This is only \code{meta.method}, "\code{REM}" and "\code{FEM}".}
 \item{raw.data}{the raw data of your input. That's \code{x}. This part will be used for plotting.}

}


\references{
	Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019.
	
	Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 
}
\seealso{
 \code{\link{MetaDE.minMCC}},
 \code{\link{MetaDE.pvalue}},
 \code{\link{MetaDE.ES}},
 \code{\link{draw.DEnumber}} ,
}
\examples{
#---example 1: Meta analysis of Differentially expressed genes between two classes----------#
# here I generate two pseudo datasets
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))

#the input has to be arranged in lists
x<-list(list(exp1,label1),list(exp2,label2))

#here I used the modt test for individual study and used Fisher's method to combine results
#from multiple studies.
meta.res1<-MetaDE.rawdata(x=x,ind.method=c('modt','modt'),meta.method='Fisher',nperm=20)

#------example 2: genes associated with survival-----------#
# here I generate two pseudo datasets
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
time1=c(4,3,1,1,2,2,3,10,5,4)
event1=c(1,1,1,0,1,1,0,0,0,1)
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,4))
time2=c(4,30,1,10,2,12,3,10,50)
event2=c(0,1,1,0,0,1,0,1,0)

#again,the input has to be arranged in lists
test2 <-list(list(x=exp1,y=time1,censoring.status=event1),list(x=exp2,y=time2,censoring.status=event2))

#here I used the log-rank test for individual study and used Fisher's method to combine results
#from multiple studies.
meta.res2<-MetaDE.rawdata(x=test2,ind.method=c('logrank','logrank'),meta.method='Fisher',nperm=20)

#------example 3: Fixed effect model for two studies from paired design-----------#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
x<-list(list(x=exp1,y=label1),list(x=exp2,y=label2))
test<- MetaDE.rawdata(x,nperm=1000, meta.method="FEM", paired=rep(FALSE,2))
}


\keyword{Meta-analysis DE genes}

