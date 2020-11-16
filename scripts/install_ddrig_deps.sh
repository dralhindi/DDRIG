#!/bin/bash
 
# Standard R Packages.
declare -a cran_packages=(
	"ggforce"
	"dplyr"
	"tidyverse"
	"ggplot2"
	"ggrepel"
)
 

for pkg in "${cran_packages[@]}"; do
	Rscript -e "if (!'$pkg' %in% rownames(installed.packages())) install.packages('$pkg', repo='http://cran.rstudio.com/')"
done


# Github packages.
declare -a github_packages=(
	"lorenzwalthert/precommit"
)
 

for pkg in "${cran_packages[@]}"; do
	Rscript -e "if (!'$pkg' %in% rownames(installed.packages())) remotes::install_github('$pkg')"
done
