# If a package is installed, it will be loaded. If any are not, the missing package(s) will be installed
# and then loaded.

r_packages <- c("dplyr",
              "tidyverse",
              "ggplot2",
              "ggrepel",
              "NCmisc",
              "lintr",
              "precommit")

missing_r_packages <- r_packages[!(r_packages %in% installed.packages()[, "Package"])]
if (length(missing_r_packages)) install.packages(missing_r_packages, repo = "http://cran.rstudio.com/")

github_packages <- c("precommit")

missing_gh_packages <- github_packages[!(github_packages %in% installed.packages()[, "Package"])]
lapply(missing_gh_packages, remotes::install_github)

# Initialize precommit.
precommit::use_precommit()
