\name{ind.cal.ES}
\alias{ind.cal.ES}
\title{Calculate the effect sizes}
\description{
The function can be used to calculate various effect sizes(and the corresponding sampling variances) that are commonly used in meta-analyses.
}
\usage{
ind.cal.ES(x, paired, nperm = NULL,miss.tol=0.3)
}
\arguments{
  \item{x}{a list of data sets and their labels. The first list is a list of datasets, the second list is a list of their labels
	}
  \item{paired}{A vector of logical values to specify the design patterns of studies. see 'Details'. }
  \item{nperm}{an integer to specify the number of permutations.}
	\item{miss.tol}{The maximum percent missing data allowed in any gene (default 30 percent).}
}
\details{
	This functions is used to calculate the effect size, standardized mean difference, often used in meta-analysis.

	The argument \code{paired} is a vector of logical values to specify whether the corresponding study is paired design or
	not. If the study is pair-designed, the effect sizes (corresponding variances) are calcualted using the formula in morris's 
	paper, otherwise calculated using the formulas in choi \emph{et al}.
}
\value{
	\item{ES }{The observed effect sizes.}
	\item{Var }{The observed variances corresponding to \code{ES}}
	\item{perm.ES}{The effect sizes calculated from permutations, \code{perm.ES} is NULL if the argument \code{nperm} is set as NULL.}
	\item{perm.Var}{The corresponding variances calculated from permutations. \code{perm.Var} is NULL if the argument \code{nperm} is set as NULL.}
}
\references{
  Morris SB: Distribution of the standardized mean change effect size for meta-analysis on repeated measures. Br J Math Stat Psychol 2000, 53 ( Pt 1):17-29.
  
  Choi et al, Combining multiple microarray studies and modeling interstudy variation. Bioinformatics,2003, i84-i90.

}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
	\code{\link{MetaDE.ES}}
}
\examples{
#---example 1: Meta analysis of Differentially expressed genes between two classes----------#
label1<-rep(0:1,each=5)
label2<-rep(0:1,each=5)
exp1<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,2),20,5))
exp2<-cbind(matrix(rnorm(5*20),20,5),matrix(rnorm(5*20,1.5),20,5))
x<-list(list(exp1,label1),list(exp2,label2))
ind.res<-ind.cal.ES(x,paired=rep(FALSE,2),nperm=100)
MetaDE.ES(ind.res,meta.method='REM')
}
