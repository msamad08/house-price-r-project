# 03_eda.R

library(tidyverse)
library(ggplot2)

data_path <- "output/cleaned_house_sales.csv"
if (!file.exists(data_path)) {
  stop("Run 02_data_cleaning.R first.")
}

housing <- read.csv(data_path)

if (!("SalePrice" %in% names(housing))) {
  stop("Expected a 'SalePrice' column in the dataset.")
}

# 1. Distribution of house prices
p1 <- ggplot(housing, aes(x = SalePrice)) +
  geom_histogram(bins = 30) +
  ggtitle("Distribution of House Prices") +
  xlab("Sale Price") +
  ylab("Count")

ggsave("images/price_distribution.png", plot = p1, width = 8, height = 5)

# 2. Living area vs sale price
if ("SqFtTotLiving" %in% names(housing)) {
  p2 <- ggplot(housing, aes(x = SqFtTotLiving, y = SalePrice)) +
    geom_point(alpha = 0.4) +
    geom_smooth(method = "lm", se = TRUE) +
    ggtitle("Living Area vs Sale Price") +
    xlab("Total Living Area (Sq Ft)") +
    ylab("Sale Price")
  
  ggsave("images/living_area_vs_price.png", plot = p2, width = 8, height = 5)
}

# 3. Sale price by bedrooms
if ("Bedrooms" %in% names(housing)) {
  p3 <- ggplot(housing, aes(x = factor(Bedrooms), y = SalePrice)) +
    geom_boxplot() +
    ggtitle("Sale Price by Number of Bedrooms") +
    xlab("Bedrooms") +
    ylab("Sale Price")
  
  ggsave("images/price_by_bedrooms.png", plot = p3, width = 8, height = 5)
}

# 4. Sale price by building grade
if ("BldgGrade" %in% names(housing)) {
  p4 <- ggplot(housing, aes(x = factor(BldgGrade), y = SalePrice)) +
    geom_boxplot() +
    ggtitle("Sale Price by Building Grade") +
    xlab("Building Grade") +
    ylab("Sale Price")
  
  ggsave("images/price_by_bldggrade.png", plot = p4, width = 8, height = 5)
}

# 5. Sale price by renovation status
if ("WasRenovated" %in% names(housing)) {
  p5 <- ggplot(housing, aes(x = factor(WasRenovated), y = SalePrice)) +
    geom_boxplot() +
    ggtitle("Sale Price by Renovation Status") +
    xlab("Was Renovated") +
    ylab("Sale Price")
  
  ggsave("images/price_by_renovation.png", plot = p5, width = 8, height = 5)
}

cat("EDA charts saved in the images/ folder.\n")
