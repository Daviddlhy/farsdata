
<!-- README.md is generated from README.Rmd. Please edit that file -->

# farsdata Package - A coursera Assigment Project.

<!-- badges: start -->

<img src="inst/logo/coursera.jpg" width="120"/>
<img src="inst/logo/jhu_v3.jpeg" width="120"/> <!-- badges: end -->

This R package is submitted as the Week 4 final assignment for the
“[Building R Packages](https://www.coursera.org/learn/r-packages)”
course on Coursera, as part of the Johns Hopkins University “[Mastering
Software Development in
R](https://www.coursera.org/specializations/r#about)” specialization. In
this course we learn to use libraries that make easy and faster to
develop an R package. Then we learn about continuous integration.

# Installation

You can install the released version of farsdata from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages('farsdata')

# Or below code if above code unable install the package
devtools::install_github('Daviddlhy/farsdata')
```

# Data Description

The data in this package come from the US National Highway Traffic
Safety Administration’s [Fatality Analysis Reporting
System](https://www.nhtsa.gov/Data/Fatality-Analysis-Reporting-System-\(FARS\)),
which is a nationwide census providing the American public yearly data
regarding fatal injuries suffered in motor vehicle traffic crashes. You
can download the data for this assignment here:

# Script in R subdirectory

These functions come from the assignment Week 2 oF course Buidling R
Packages. Note that in these functions it use dplyr packages with
deprecated functions like filter\_, so i remove them and add recent
function filter\_ become filter.

# Quick Example

If you want explore the dataset:

``` {r
library(farsdata)
library(maps)
fars_2013_fn <- make_filename(2013)
fars_2013 <- fars_read(fars_2013_fn) 
dim(fars_2013)
## [1] 30202    50
```

# Vignettes

To get started, read the introduction

``` {r
vignette: vignette('introduction', package = 'farsdata').
```

# Travis Badge

[![Build
Status](https://travis-ci.com/Daviddlhy/farsdata.svg?branch=master)](https://travis-ci.com/Daviddlhy/farsdata)
