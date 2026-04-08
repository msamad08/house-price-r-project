# Install and load required packages

required_packages <- c(
  "tidyverse",
  "ggplot2"
)

installed <- rownames(installed.packages())

for (pkg in required_packages) {
  if (!(pkg %in% installed)) {
    install.packages(pkg, dependencies = TRUE)
  }
  library(pkg, character.only = TRUE)
}

cat("Packages are ready.\n")
