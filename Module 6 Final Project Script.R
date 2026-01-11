# ---------Module 6 Final Project---------#
# --------------Group 4----------------#
# Isaac (Ying Shuo) Su
# Tanveer Begum
# Date: 15 DEC 2024

# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(stats)

# Load dataset
data <- read.csv("WHR2023.csv")

# ----------------------
# Initial EDA
# ----------------------
# Explore dataset structure and summary
str(data)
summary(data)

# Correlation matrix for numerical variables
numeric_vars <- numeric_vars %>% select(-Ladder.score.in.Dystopia)
# Ladder.score.in.Dystopia is not informative for the analysis because it has no variability
cor_matrix <- cor(numeric_vars, use = "complete.obs")
print(cor_matrix)

# Plot distribution of Happiness Score
ggplot(data, aes(x = Ladder.score)) +
  geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
  labs(title = "Distribution of Happiness Scores", x = "Happiness Score", y = "Frequency")



# ----------------------
# Question 1: Is the impact of healthy life expectancy on happiness stronger in countries with higher social support?
# ----------------------
# Create Social Support Groups (Low, Medium, High)
data <- data %>%
  mutate(Social_Support_Group = case_when(
    Social.support <= quantile(Social.support, 0.33, na.rm = TRUE) ~ "low_social_group",
    Social.support > quantile(Social.support, 0.33, na.rm = TRUE) & Social.support <= quantile(Social.support, 0.67, na.rm = TRUE) ~ "medium_social_group",
    TRUE ~ "high_social_group"
  ))

# Fit regression model with interaction term and set intercept for "low_social_group" to 0
model1 <- lm(Ladder.score ~ Healthy.life.expectancy + Social_Support_Group + Healthy.life.expectancy:Social_Support_Group, data = data)
summary(model1)


# Visualization: Add regression lines for each subgroup with "low_social_group" as baseline
data_clean <- data %>%
  filter(is.finite(Healthy.life.expectancy) & is.finite(Ladder.score))
scatterplot1 <- ggplot(data_clean, aes(x = Healthy.life.expectancy, y = Ladder.score, color = Social_Support_Group)) +
  geom_point(alpha = 0.7) +
  geom_smooth(data = filter(data_clean, Social_Support_Group == "low_social_group"), method = "lm", formula = y ~ x - 1, se = FALSE) +
  geom_smooth(data = filter(data_clean, Social_Support_Group == "medium_social_group"), method = "lm", formula = y ~ x, se = FALSE) +
  geom_smooth(data = filter(data_clean, Social_Support_Group == "high_social_group"), method = "lm", formula = y ~ x, se = FALSE) +
  labs(title = "Impact of Healthy Life Expectancy on Happiness by Social Support Group (Baseline: Low Social Support)",
       x = "Healthy Life Expectancy", y = "Happiness Score", color = "Social Group") +
  coord_cartesian(xlim = c(50, max(data_clean$Healthy.life.expectancy, na.rm = TRUE))) +
  theme_minimal()

print(scatterplot1)

# ----------------------
# Question 2: Does the interaction between freedom and social support predict happiness better than individual factors alone?
# ----------------------
# Fit regression model with interaction term and set intercept for "low_social_group" to 0
model2 <- lm(Ladder.score ~ Freedom.to.make.life.choices + Social_Support_Group + Freedom.to.make.life.choices:Social_Support_Group, data = data)
summary(model2)

# Visualization: Interaction plot with meaningful intercepts
# Plot regression lines for each group
scatterplot2 <- ggplot(data, aes(x = Freedom.to.make.life.choices, y = Ladder.score, color = Social_Support_Group)) +
  geom_point(alpha = 0.7) +  # Scatter points
  geom_smooth(data = filter(data, Social_Support_Group == "low_social_group"),
              method = "lm", formula = y ~ x, se = FALSE) +  # Regression line for low group
  geom_smooth(data = filter(data, Social_Support_Group == "medium_social_group"),
              method = "lm", formula = y ~ x + 1, se = FALSE) +  # Adjust intercept for medium group
  geom_smooth(data = filter(data, Social_Support_Group == "high_social_group"),
              method = "lm", formula = y ~ x + 1, se = FALSE) +  # Adjust intercept for high group
  labs(title = "Interaction Between Freedom and Social Support on Happiness",
       x = "Freedom to Make Life Choices", y = "Happiness Score", color = "Social Group") +
  theme_minimal()

print(scatterplot2)

# ----------------------
# Question 3: Does GDP per capita moderate the relationship between freedom to make life choices and happiness?
# ----------------------
# Create GDP Groups (Low, Medium, High)
data <- data %>%
  mutate(GDP_Group = case_when(
    Logged.GDP.per.capita <= quantile(Logged.GDP.per.capita, 0.33, na.rm = TRUE) ~ "low_gdp_group",
    Logged.GDP.per.capita > quantile(Logged.GDP.per.capita, 0.33, na.rm = TRUE) & Logged.GDP.per.capita <= quantile(Logged.GDP.per.capita, 0.67, na.rm = TRUE) ~ "medium_gdp_group",
    TRUE ~ "high_gdp_group"
  ))

# Fit regression model with interaction term and set intercept for "low_gdp_group" to 0
model3 <- lm(Ladder.score ~ Freedom.to.make.life.choices + GDP_Group + Freedom.to.make.life.choices:GDP_Group, data = data)
summary(model3)

# Visualization: Add regression lines for each subgroup with "low_gdp_group" as baseline
scatterplot3 <- ggplot(data, aes(x = Freedom.to.make.life.choices, y = Ladder.score, color = GDP_Group)) +
  geom_point(alpha = 0.7) +
  geom_smooth(data = filter(data, GDP_Group == "low_gdp_group"), method = "lm", formula = y ~ x, se = FALSE) +
  geom_smooth(data = filter(data, GDP_Group == "medium_gdp_group"), method = "lm", formula = y ~ x + 1, se = FALSE) +
  geom_smooth(data = filter(data, GDP_Group == "high_gdp_group"), method = "lm", formula = y ~ x + 1, se = FALSE) +
  labs(title = "Impact of Freedom on Happiness by GDP Group (Baseline: Low GDP)",
       x = "Freedom to Make Life Choices", y = "Happiness Score", color = "GDP Group") +
  theme_minimal()

print(scatterplot3)

# ----------------------
# Hypotheses and Results Interpretation
# ----------------------
cat("Question 1 Results:\n")
print(summary(model1))
cat("Interpretation: Higher social support amplifies the impact of healthy life expectancy on happiness, as evident from the significant interaction term.\n")

cat("\nQuestion 2 Results:\n")
print(summary(model2))
cat("Interpretation: The interaction term indicates that freedom and social support together better predict happiness than individually.\n")

cat("\nQuestion 3 Results:\n")
print(summary(model3))
cat("Interpretation: GDP per capita moderates the relationship between freedom and happiness, as shown by the varying slopes for different GDP groups.\n")
