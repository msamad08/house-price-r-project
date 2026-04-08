# 04_modeling.R

library(tidyverse)

data_path <- "output/cleaned_house_sales.csv"
if (!file.exists(data_path)) {
  stop("Run 02_data_cleaning.R first.")
}

housing <- read.csv(data_path)

if (!("SalePrice" %in% names(housing))) {
  stop("Expected a 'SalePrice' column in the dataset.")
}

# Candidate predictors based on your actual dataset
candidate_features <- c(
  "Bedrooms",
  "Bathrooms",
  "SqFtTotLiving",
  "SqFtLot",
  "BldgGrade",
  "YrBuilt",
  "HouseAge",
  "WasRenovated",
  "NbrLivingUnits",
  "TrafficNoise",
  "LandVal",
  "ImpsVal",
  "zhvi_px",
  "zhvi_idx"
)

available_features <- candidate_features[candidate_features %in% names(housing)]

if (length(available_features) == 0) {
  stop("No expected predictor columns found. Review your dataset columns.")
}

# Keep only modeling columns and drop missing rows
model_data <- housing[, c("SalePrice", available_features)]
model_data <- na.omit(model_data)

set.seed(123)
train_size <- floor(0.8 * nrow(model_data))
train_index <- sample(seq_len(nrow(model_data)), size = train_size)

train <- model_data[train_index, ]
test <- model_data[-train_index, ]

formula_text <- paste("SalePrice ~", paste(available_features, collapse = " + "))
model_formula <- as.formula(formula_text)

model <- lm(model_formula, data = train)
predictions <- predict(model, newdata = test)

rmse <- sqrt(mean((test$SalePrice - predictions)^2))
mae <- mean(abs(test$SalePrice - predictions))
r_squared <- summary(model)$r.squared

metrics <- c(
  paste("RMSE:", round(rmse, 2)),
  paste("MAE:", round(mae, 2)),
  paste("R-squared:", round(r_squared, 4)),
  "",
  "Model Formula:",
  formula_text,
  "",
  "Model Summary:",
  capture.output(summary(model))
)

writeLines(metrics, "output/model_metrics.txt")

cat("Model evaluation saved to output/model_metrics.txt\n")
cat("RMSE:", round(rmse, 2), "\n")
cat("MAE:", round(mae, 2), "\n")
cat("R-squared:", round(r_squared, 4), "\n")
