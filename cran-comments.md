## Submission
This is my first submission to CRAN


## Test environments
	- Ubuntu 18.04.5 LTS, R 3.6.3 (locally), R 4.0.2 (travis-ci), R Under development (unstable) (2020-09-14 r79203) (travis-ci)
	- win-builder (devel and release) 


## Test results
No errors on Ubuntu. 

There was 1 ERROR on Windows release when running with `devtools::check_win_release()`: 
Package required and available but unsuitable version: 'backports'

This error doesn't show up when running on Windows devel version with `devtools::check_win_devel()`. 
I think this is because we're importing backports version 1.1.10 which was released on CRAN very recently. 
Windows builder may not have the updated version of the package. 


## Downstream dependencies
There are no downstream dependencies. 
