The betadiv package
===============

<!-- badges: start -->
[![R-CMD-check](https://github.com/CWFC-CCFB/betadiv/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CWFC-CCFB/betadiv/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The betadiv package is licensed under the GNU Lesser General Public License v3.0 (LGPL-3).

The betadiv package implements the multiple-site dissimilarity indices of Simpson, Sorensen 
and nestedness, which can be used to assess the beta diversity of a population. 
These indices were adapted from those developed by Baselga (2010, Global Ecology 
and Biogeography 19:134--143) in order to make them population size-independent. 
All the details behind the calculation and estimation of these adapted indices
can be found in Fortin et al. (2020, Global Ecology and Biogeography 29: 1073-1084). 

The betadiv package depends on the J4R package which is available on CRAN. The 
dissimilarity indices are estimated using two Java libraries: betadiversityindices and
repicea. Both are licensed under the Lesser GNU General Public License v3.0 (LGPL-3). 
This package and the associated Java libraries come with absolutely NO WARRANTY.

The source code of the betadiv package is freely available at https://github.com/CWFC-CCFB/betadiv .

The documentation can be found at https://github.com/CWFC-CCFB/betadiv/wiki/The-betadiv-package-for-R .

Tickets can be created at https://github.com/CWFC-CCFB/betadiv/issues .

Mathieu Fortin
e-mail: mathieu.fortin.re@gmail.com
