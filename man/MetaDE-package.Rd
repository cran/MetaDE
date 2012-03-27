\name{MetaDE-package}
\alias{MetaDE-package}
\alias{MetaDE}
\docType{package}
\title{Meta-analysis for Differential Expression Analysis
}
\description{
The MetaDE package consists of a collection of functions for conducting genomic meta-analysis to 
identify differentially expressed genes in R. The package includes functions for individual analysis to calculate the p-values or effect sizes used in meta-analysis.
Several popular meta-analysis methods of combining p-values or effect sizes can be carried out. Comparing to other packages, MetaDE offers much wider 
options of analysis methods for both individual dataset analysis and meta-analysis. 
It is suitable to researchers who want to easily obtain an analysis and tailor their 
choices to the biological questions of interest. For example, if one is interested in 
finding genes that are differentially expressed between cases and controls in all 
datasets. One could select "moderated t-test" from the individual analysis and 
select "maxP" from the meta-analysis to combine the p-values for moderated t-test. 
This would form the "modt+maxP" method for the whole process. 
One also could select "REM" as the meta-analytic method for this purpose. 
In this case, the effect sizes are generated during the stage of individual 
analysis and they are combined through the random-effected modle. This setting is highly suitable for those who want more flexibility.

\bold{The \code{ind.analysis} Function}\cr

This function is used to perform individual analysis and calculate the p-values frequently used in meta-analysis. Based on the type of outcome variable,

\bold{The \code{ind.cal.ES} Function}\cr

This function is used for calculating the effect sizes (standardized mean difference) frequently used in meta-analysis.
	
\bold{The \code{MetaDE.rawdata} Function}\cr

With the raw gene expression datasets, all the metheds combining the options of \code{ind.method} and \code{meta.method}
can be implemented by function \code{MetaDE.rawdata}.

\bold{The \code{MetaDE.pvalue} and \code{MetaDE.ES} Function}\cr

If p-values or effect sizes (and corresponding variances) have been calculated already, for
example by other methods not used in functions, \code{ind.analysis} or \code{ind.cal.ES}, with the help
of other software, then the meta-analysis can be implemented by function \code{MetaDE.pvalue}or \code{MetaDE.ES}.
}


\author{Jia Li<jiajiaysc@gmail.com>  and Xingbin Wang<xingbinw@gmail.com>
}
\references{
	Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019.
	
	Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 

}
\keyword{ package }

