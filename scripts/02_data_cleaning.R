# 02_data_cleaning.R

library(tidyverse)

data_path <- "data/house_sales.csv"
if (!file.exists(data_path)) {
  stop("Dataset not found. Place your file at data/house_sales.csv")
}

housing <- read.csv(data_path, stringsAsFactors = FALSE)

cat("Initial dimensions:\n")
print(dim(housing))

cat("\nColumn names:\n")
print(names(housing))

cat("\nSummary:\n")
print(summary(housing))

cat("\nMissing values by column:\n")
print(colSums(is.na(housing)))

# Convert date column if present
if ("DocumentDate" %in% names(housing)) {
  housing$DocumentDate <- as.Date(housing$DocumentDate)
}

# Create engineered features if present
if ("YrBuilt" %in% names(housing)) {
  housing$HouseAge <- as.numeric(format(Sys.Date(), "%Y")) - housing$YrBuilt
}

if ("YrRenovated" %in% names(housing)) {
  housing$WasRenovated <- ifelse(housing$YrRenovated > 0, 1, 0)
}

# Remove duplicates
housing <- housing %>% distinct()

cat("\nDimensions after duplicate removal:\n")
print(dim(housing))

write.csv(housing, "output/cleaned_house_sales.csv", row.names = FALSE)
cat("\nCleaned data saved to output/cleaned_house_sales.csv\n")
