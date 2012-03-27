
\name{MetaDE.pvalue}
\alias{MetaDE.pvalue}
\docType{data}
\title{Identify differentially expressed genes by combining p-values}
\description{
  \code{MetaDE.pvalue}
  Identify differentially expressed genes by integrating multiple studies(datasets). The data
  consists of p-values from your own method/calculations.
}
\usage{MetaDE.pvalue(x, meta.method = c("maxP", "maxP.OC", "minP",
                 "minP.OC", "Fisher", "Fisher.OC", "AW", "AW.OC",
                 "roP", "roP.OC", "Stouffer", "Stouffer.OC", "SR",
                 "PR"), rth = NULL, miss.tol = 0.3, asymptotic = FALSE)
		}

\arguments{
\item{x}{a list with components:\cr
	\itemize{
         \item \bold{p}: a list of p values for each dataset.
         \item \bold{bp}: a list of p values calculated from permutation for each dataset. This 
         part can be NULL if you just have the p-values from your own method.
       }
}

\item{meta.method}{a character to specify the type of Meta-analysis methods to combine the p-values or effect sizes. 
See "Detials".}
\item{rth}{this is the option for roP and roP.OC method. rth means the rth smallest p-value.}
\item{miss.tol}{The maximum percent missing data allowed in any gene (default 30 percent).}
\item{asymptotic}{A logical values to specify whether the parametric methods is chosen to calculate the p-values in meta-analysis. The default is
FALSE.}
 }

\details{
	The options for argument,\code{mete.method},are listed below:\cr
	\itemize{
		\item \bold{"maxP"}: the maximum of p value method.
		\item \bold{"maxP.OC"}: the maximum of p values with one-sided correction.
		\item \bold{"minP"}: the minimum of p values from "test" across studies.
		\item \bold{"minP.OC"}: the minimum of p values with one-sided correction.
		\item \bold{"Fisher"}: Fisher's method (Fisher, 1932),the summation of -log(p-value) across studies.
		\item \bold{"Fisher.OC"}: Fisher's method with one-sided correction (Fisher, 1932),the summation of -log(p-value) across studies.
        \item \bold{"AW"}: Adaptively-weighted method (Li and Tseng, 2011).
		\item \bold{"AW.OC"}: Adaptively-weighted method with one-sided correction (Li and Tseng, 2011).
		\item \bold{"roP"}:  rth p-value method.
		\item \bold{"roP.OC"}: rth p-value  method with one-sided correction.
		\item \bold{"Stouffer"}: the minimum of p values from "test" across studies.
		\item \bold{"Stouffer.OC"}: the minimum of p values with one-sided correction.
		\item \bold{"SR"}: the naive sum of the ranks method.
		\item \bold{"PR"}: the naive product of the ranks method.
	}
	For those genes with less than miss.tol *100 percent missing,the p-values are calculated using parametric metod if asymptotic is TRUE. Otherwise,
	, the p-values for genes without missing values are calculated using permutation methold.

}
 
\value{A list containing: \cr
  \item{stat}{a matrix with rows reprenting genes. It is the statistic for the selected meta analysis method of combining p-values.}
  \item{pval}{the p-value from meta analysis for each gene for the above stat.}
  \item{FDR}{the FDR of the p-value for each gene for the above stat.}
  \item{AW.weight}{The optimal weight assigned to each dataset/study for each gene if the '\code{AW}' or '\code{AW.OC}'
				method was chosen.}
}


\references{
 	Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019.
	
	Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 

}
\seealso{MetaDE.minMCC, MetaDE.pvalue,MetaDE.ES,plot.FDR,heatmap.sig.genes}
\examples{
#---example 1: Meta analysis of Differentially expressed genes between two classes----------#
# here I generate two pseudo datasets
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))

#the input has to be arranged in lists
x<-list(list(exp1,label1),list(exp2,label2))

# start individual analysis for each dataset: here I used modt to generate p-values. 
DEgene<-ind.analysis(x,ind.method=c("modt","modt"),tail="high",nperm=100)
#you don't have to use our ind.analysis for the analysis for individual study. you can input 
#p-values to MetaDE.pvalue for meta analysis only. But the input has to be specified in the
# same format as the DEgene in the example above

#--then you can use meta analysis method to combine the above p-values:here I used the Fisher's method
MetaDE.pvalue(DEgene,meta.method='Fisher')
}


\keyword{Meta-analysis DE genes}
