\name{MetaDE-package}
\alias{MetaDE-package}
\alias{MetaDE}
\docType{package}
\title{MetaDE: Microarray meta-analysis for differentially expressed gene detection
}
\description{
MetaDE MetaDE package implements 12 major meta-analysis methods for differential expression analysis
: Fisher (Rhodes, et al., 2002), Stouffer (Stouffer, 1949), adaptively weighted Fisher (AW) (Li and 
Tseng, 2011), minimum p-value (minP), maximum p-value (maxP), rth ordered p-value (rOP) 
(Song and Tseng, 2012),  fixed effects model (FEM), random effects model (REM) (Choi, et al., 2003),
 rank product (rankProd) (Hong, et al., 2006), naive sum of ranks and naive product of ranks 
 (Dreyfuss, et al., 2009). Detailed algorithms,  pros and cons of different methods have been 
 discussed in a recent review paper (Tseng, et al., 2012). In addition to selecting a meta-analysis
 method, two additional considerations are involved in the implementation:  (1) Choice of test 
 statistics: Different test statistics are available in the package for each type of outcome 
 variable (e.g. t-statistic or moderated t-statistic for binary outcome, F-statistic for multi-class
 outcome, regression or correlation for continuous outcome and Cox proportional hazard model for 
 survival outcome).  Additionally, a minimum multi-class correlation (min-MCC) has been included for
 multi-class outcome to  only capture concordant expression patterns that F-statistic often fails 
 (Lu, et al., 2010);  (2) One-sided test correction: When combining two-sided p-values for binary 
 outcomes, DE genes with discordant DE direction may be identified and the results are difficult to 
 interpret(e.g. up-regulation in one study but down-regulation in another study). One-sided test 
 correction is helpful  to guarantee identification of DE genes with concordant DE direction. For 
 example, Pearson's correction  has been proposed for Fisher's method (Owen, 2009). In addition to
 the choices above, MetaDE also provides options for gene matching across studies and gene filtering
 before meta-analysis. Outputs of the meta-analysis results include DE gene lists with corresponding
 raw p-value, q-values and various visualization tools. Heatmaps can be plotted across studies. 
 
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


\author{Xingbin Wang<xingbinw@gmail.com>, Jia Li<jiajiaysc@gmail.com> and George C Tseng<ctseng@pitt.edu> 
}
\references{
	Jia Li and George C. Tseng. (2011) An adaptively weighted statistic for detecting differential gene expression when combining multiple transcriptomic studies. Annals of Applied Statistics. 5:994-1019.
	
	Shuya Lu, Jia Li, Chi Song, Kui Shen and George C Tseng. (2010) Biomarker Detection in the Integration of Multiple Multi-class Genomic Studies. Bioinformatics. 26:333-340. (PMID: 19965884; PMCID: PMC2815659) 

	Xingbin Wang, Yan Lin, Chi Song, Etienne Sibille and George C Tseng. (2012) Detecting disease-associated genes with confounding variable adjustment and the impact on genomic meta-analysis: with application to major depressive disorder. BMC Bioinformatics. 13:52.

	George C. Tseng, Debashis Ghosh and Eleanor Feingold. (2012) Comprehensive literature review and statistical considerations for microarray meta-analysis. Nucleic Acids Research accepted
	
	Xingbin Wang, Dongwan Kang, Kui Shen, Chi Song, Lunching Chang, Serena G. Liao, Zhiguang Huo, Naftali Kaminski, Etienne Sibille, Yan Lin, Jia Li and George C. Tseng. (2012) A Suite of R Packages for Quality Control, Differentially Expressed Gene and Enriched Pathway Detection in Microarray Meta-analysis. In press.
	}
\keyword{ package }

