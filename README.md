# Life_Expectancy_Prediction_R
Prediction of life expectancy by state using Multiple Linear Regression Model

About the data 
We will be examining the "state" dataset, which has data from the 1970s on all fifty US states. For each state, the dataset includes the population, per capita income, illiteracy rate, murder rate, high school graduation rate, average number of frost days, area, latitude and longitude, division the state belongs to, region the state belongs to, and two-letter abbreviation.

This dataset has 50 observations (one for each US state) and the following 15 variables: 
1. Population - the population estimate of the state in 1975 
2. Income - per capita income in 1974 
3. Illiteracy - illiteracy rates in 1970, as a percent of the population 
4. Life.Exp - the life expectancy in years of residents of the state in 1970 
5. Murder - the murder and non-negligent manslaughter rate per 100,000 population in 1976 
6. HS.Grad - percent of high-school graduates in 1970 
7. Frost - the mean number of days with minimum temperature below freezing from 1931–1960 in the capital or a large city of the state 
8. Area - the land area (in square miles) of the state 
9. state.abb - a 2-letter abreviation for each state 
10. state.area - the area of each state, in square miles 
11. x - the longitude of the center of the state 
12. y - the latitude of the center of the state 
13. state.division - the division each state belongs to (New England, Middle Atlantic, South Atlantic, East South Central, West South Central, East North Central, West North Central, Mountain, or Pacific) 
14. state.name - the full names of each state 
15. state.region - the region each state belong to (Northeast, South, North Central, or West)

Problem Statement:
Build an analytical model to predict the life expectancy by state using the state statistics. Build the model with all potential variables included (Population, Income, Illiteracy, Murder, HS.Grad, Frost, and Area). Note that you should use the variable "Area" in your model, NOT the variable "state.area".

Here, the dependent variable is Life.Exp which is a continuous variable and all others are independent variables. So MLRM is used for analysis.

For this analysis, state.area, state.abb and state.name are not taken into consideration since these are qualitative variables and state.area has a similar variable called Area. The variables x and y are dropped since they are redundant from a business perspective.

The model is run on the entire dataset after doing data preprocessing as the number of observations are too low to split it into train and test datasets. The focus here is to identify and interpret which variables are impacting Life Expectancy and not so much on prediction.

After running the MLRM Model we get the following test results:
1. Multiple R-squared: 80.18%
2. Adjusted R-squared: 76.88%
3. MAPE: 0.696%
4. D-W test p-value: 0.514
5. B-P test p-value: 0.03858

Significant variables at 95% confidence level:

Positively significant: Population, HS.Grad, State Division West North Central
Negatively significant: Murder, Frost, State Division Middle Atlantic, State Division South Atlantic

Interpretation of the significant variables:
1. Population: High population increases life expectancy since as a community, people can strive for economic growth of a state by reducing unemployment with the creation of new jobs, construction of new hospitals and schools, local businesses and markets where people can buy essentials from, etc.
2. HS.Grad: People who are high school graduates have at least basic education and can search for jobs or start a new business with which they sustain themselves and have a family to provide for. They have a better life expectancy than those who are not high school graduates.
3. State Division West North Central: The people at this state division have a better life expectancy because of location, weather or other factors.
4. Murder: Crimes like murder reduces the average life expectancy of a region.
5. Frost: Consistent low temperatures below freezing point affects the health of a person. Also it creates problem for local services to function. Thus life expectancy decreases.
6. State Division Middle Atlantic and South Atlantic: These states have a lower life expectancy than other states due to various factors which should be looked into.
