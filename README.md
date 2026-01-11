**World Happiness Report 2023: An Interaction-Based Analysis in R
Project Overview**

Happiness is a universal goal, yet the factors that truly drive it remain complex. This project analyzes data from the World Happiness Report 2023 to examine how healthy life expectancy, social support, freedom to make life choices, and GDP per capita influence national happiness levels.

Rather than studying these variables independently, this analysis focuses on interaction effects—exploring how combinations of social, economic, and personal factors work together to shape happiness across countries.

The study uses exploratory data analysis (EDA) and linear regression models with interaction terms, implemented entirely in R.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Research Questions**

This project investigates the following questions:

1. Does social support strengthen the impact of healthy life expectancy on happiness?

2. Does the interaction between freedom and social support predict happiness better than individual effects alone?

3. Does GDP per capita moderate the relationship between freedom to make life choices and happiness?

These questions were motivated by real-world contrasts across countries, highlighting that longer life, freedom, or wealth alone may not guarantee higher happiness without supportive social and economic contexts.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Data Source**

World Happiness Report 2023

Original dataset sourced from:

PhilippeCodes GitHub Repository
(World Happiness Report CSV)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Key variables used:**

  Ladder.score (Happiness Score)
  
  Healthy.life.expectancy
  
  Social.support
  
  Freedom.to.make.life.choices
  
  GDP.per.capita
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Methodology**

The analysis followed these steps:

  Exploratory Data Analysis (EDA)
  
  Examined distributions and pairwise relationships
  
  Identified preliminary trends and patterns
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Variable Grouping**

  Social support grouped into low, medium, high
  
  GDP per capita grouped into low, medium, high

**Regression Modeling**

  Linear regression with interaction terms
  
  Tested whether relationships vary across groups

**Visualization**

  Interaction plots to compare slopes across groups
  
  Clear graphical interpretation of moderation effects
  
  All analyses and visualizations were produced using R.

 **Hypotheses Tested**
1. Healthy Life Expectancy × Social Support

  H₀: Social support does not strengthen the impact of healthy life expectancy on happiness.
  
  H₁: Healthy life expectancy has a stronger effect on happiness in countries with higher social support.

2. Freedom × Social Support

  H₀: The interaction between freedom and social support does not predict happiness better than individual effects.
  
  H₁: The interaction between freedom and social support significantly improves happiness prediction.

3. Freedom × GDP per Capita

  H₀: GDP per capita does not moderate the effect of freedom on happiness.
  
  H₁: GDP per capita significantly moderates the relationship between freedom and happiness.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
** Key Findings**

1️ Healthy Life Expectancy & Social Support

  Interaction term was statistically significant (p = 0.0391)
  
  Countries with high social support showed the strongest positive relationship
  
  Indicates that social support amplifies the benefits of longer, healthier lives

2️ Freedom & Social Support Interaction

  Highly significant interaction (p = 0.0001)
  
  Combined model explained more variance in happiness (R² = 0.7323)
  
  Demonstrates that freedom and social support complement each other

3️ GDP Moderation of Freedom

  Interaction between freedom and GDP was significant (p < 0.001)
  
  Freedom had the strongest effect in high-GDP countries
  
  Suggests that economic stability allows freedom to translate more effectively into happiness
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
** Interpretation**
The results show that happiness is not driven by isolated factors. Instead:

Social support enhances the positive effects of health and freedom

Freedom matters more when people have economic resources

Strong communities and stable economies allow personal freedoms to meaningfully improve well-being

These insights highlight the need for holistic policymaking, balancing economic development, social cohesion, and individual autonomy.
