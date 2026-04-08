# 03_eda.R

library(tidyverse)
library(ggplot2)

# Use a cleaner default theme
theme_set(theme_minimal(base_size = 14))

# Load cleaned data
data_path <- "output/cleaned_house_sales.csv"

if (!file.exists(data_path)) {
  stop("Run 02_data_cleaning.R first.")
}

housing <- read.csv(data_path)

# Check required target column
if (!("SalePrice" %in% names(housing))) {
  stop("Expected a 'SalePrice' column in the dataset.")
}

# Ensure images folder exists
if (!dir.exists("images")) {
  dir.create("images", recursive = TRUE)
}

# 1. Distribution of house prices
p1 <- ggplot(housing, aes(x = SalePrice)) +
  geom_histogram(bins = 30, fill = "cornflowerblue", color = "white") +
  ggtitle("Distribution of House Prices") +
  xlab("Sale Price") +
  ylab("Count")

ggsave("images/price_distribution.png", plot = p1, width = 8, height = 5)

# 2. Living area vs sale price
if ("SqFtTotLiving" %in% names(housing)) {
  p2 <- ggplot(housing, aes(x = SqFtTotLiving, y = SalePrice)) +
    geom_point(color = "darkorange", alpha = 0.35) +
    geom_smooth(method = "lm", se = TRUE, color = "navy", fill = "skyblue") +
    ggtitle("Living Area vs Sale Price") +
    xlab("Total Living Area (Sq Ft)") +
    ylab("Sale Price")
  
  ggsave("images/living_area_vs_price.png", plot = p2, width = 8, height = 5)
}

# 3. Sale price by number of bedrooms
if ("Bedrooms" %in% names(housing)) {
  p3 <- ggplot(housing, aes(x = factor(Bedrooms), y = SalePrice, fill = factor(Bedrooms))) +
    geom_boxplot() +
    ggtitle("Sale Price by Number of Bedrooms") +
    xlab("Bedrooms") +
    ylab("Sale Price") +
    theme(legend.position = "none")
  
  ggsave("images/price_by_bedrooms.png", plot = p3, width = 8, height = 5)
}

# 4. Sale price by building grade
if ("BldgGrade" %in% names(housing)) {
  p4 <- ggplot(housing, aes(x = factor(BldgGrade), y = SalePrice, fill = factor(BldgGrade))) +
    geom_boxplot() +
    ggtitle("Sale Price by Building Grade") +
    xlab("Building Grade") +
    ylab("Sale Price") +
    theme(legend.position = "none")
  
  ggsave("images/price_by_bldggrade.png", plot = p4, width = 8, height = 5)
}

# 5. Sale price by renovation status
if ("WasRenovated" %in% names(housing)) {
  p5 <- ggplot(housing, aes(x = factor(WasRenovated), y = SalePrice, fill = factor(WasRenovated))) +
    geom_boxplot() +
    ggtitle("Sale Price by Renovation Status") +
    xlab("Was Renovated") +
    ylab("Sale Price") +
    scale_fill_manual(values = c("salmon", "mediumseagreen")) +
    theme(legend.position = "none")
  
  ggsave("images/price_by_renovation.png", plot = p5, width = 8, height = 5)
}

# 6. Lot size vs sale price
if ("SqFtLot" %in% names(housing)) {
  p6 <- ggplot(housing, aes(x = SqFtLot, y = SalePrice)) +
    geom_point(color = "purple", alpha = 0.35) +
    ggtitle("Lot Size vs Sale Price") +
    xlab("Lot Size (Sq Ft)") +
    ylab("Sale Price")
  
  ggsave("images/lot_size_vs_price.png", plot = p6, width = 8, height = 5)
}

cat("EDA charts saved in the images/ folder.\n")
