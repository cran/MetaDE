\name{MetaDE.ES}
\alias{MetaDE.ES}
\title{
Identify differentially expressed genes by combining effect sizes
}
\description{
Function to fit the meta-analytic fixed- and random-effects models.The data consists of effect sizes and corresponding
variances from your own method/calculations. 
}
\usage{
MetaDE.ES(x, meta.method = c("FEM", "REM"))
}
\arguments{
  \item{x}{ a list with components.\cr
	\itemize{
	\item \bold{ES}: The observed effect sizes.
	\item \bold{Var}: The observed variances corresponding to \code{ES}
	\item \bold{perm.ES}: The effect sizes calculated from permutations, \code{perm.ES} is NULL if the argument \code{nperm} is set as NULL.
	\item \bold{perm.Var}: The corresponding variances calculated from permutations. \code{perm.Var} is NULL if the argument \code{nperm} is set as NULL.
	}
}
 \item{meta.method}{a character string specifying whether a fixed- or a random/mixed-effects model should be fitted. A fixed-effects model is fitted when using meta.method="FEM".
  Random-effects model is fitted by setting meta.method equal to "REM". See "Details".}
}

\details{
	The function can be used to combine any of the usual effect size used in meta-analysis,such as standardized mean differences.Simply specify the observed effect sizes via the x\$ES
	and the corresponding variances vis x\$Var. If the effect sizes and corresponding varicances calculated from permutation are available,then specify them by x\$perm.ES and x\$perm.Var,
	respectively.

	The argument \code{paired} is a vecter of logical values to specify whethe the corresponding study is paired design or
	not. If the study is pair-designed, the effect sizes (corresponding variances) are calcualted using the formula in morris's 
	paper, otherwise calculated using the formulas in choi \emph{et al}.
	
	In addition, if the components of x, perm.ES and perm.Var, are not "NULL", the p-values are calculated using permutation method, otherwise, the p-values are calculated using parametric method by 
	assupming the z-scores following a standard normal distribution.
}
\value{
	The object is a list containing the following components:\cr	
	\item{zval }{test statistics of the aggregated value.}
	\item{pval }{p-values for the test statistics.}
	\item{FDR }{A matrix with one column which has the corrected p-values using Benjamini and Hochberg method (see \code{references}).}
	\item{Qval }{test statistics for the test of heterogeneity.}
	\item{Qpval}{p-values for the test of heterogeneity.}
	\item{tau2}{estimated amount of (residual) heterogeneity.}
}
\references{
Choi et al, Combining multiple microarray studies and modeling interstudy variation. Bioinformatics,2003, i84-i90.

Benjamini, Y., and Hochberg, Y. (1995). Controlling the false discovery rate: a practical and powerful approach to multiple testing. Journal of the Royal Statistical Society Series B, 57, 289:300. 

}
\author{
	Jia Li and Xingbin Wang
}

\seealso{
\code{\link{ind.cal.ES}}
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

\keyword{ REM }
\keyword{ FEM }
