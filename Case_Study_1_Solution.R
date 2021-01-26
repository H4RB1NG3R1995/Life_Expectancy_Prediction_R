#MLRM Model

#Building a Multiple Linear Regression model to predict the life expectancy by state using the state statistics. 

#Preparing environment for MLRM

#Step 1: Calling libraries

library(boot) 
library(car)
library(QuantPsyc)
library(lmtest)
library(sandwich)
library(vars)
library(nortest)
library(MASS)
library(caTools)
library(dplyr)
options(scipen = 999)

#Step 2: Setting Working Directory
Path<-"E:/IVY PRO SCHOOL/R/05 PREDICTIVE ANALYTICS PROJECTS/01 MULTIVARIATE LINEAR REGRESSION/CASE STUDY1/02DATA"
setwd(Path)
getwd()

Data<-read.csv("statedata.csv")
Data1<-Data #backup data

#Step 3: Basic exploration of the data
str(Data1)
summary(Data1)

#Step 4: Outlier Treatment of Dependent variable by Quantile method
#no outlier treatment is done since mean and median of all the variables is almost same

#Step 5: Checking missing values
as.data.frame(colSums(is.na(Data1)))
#Presence of missing values not found

#Step 6: Dropping redundant features from data frame
as.data.frame(colnames(Data1))
Data2<-select(Data1, -c("state.area", "x", "y", "state.abb", "state.name"))
#state.abb and state.name are dropped since these are qualitative columns. x and y have no use 
#from a business perspective. State.area is dropped since we are using another variable called area.

str(Data2) #final dataset for modelling

#Step 7: Exporting model data
write.csv(Data2, "modeldata.csv")

#Converting state.division and state.region to factor variables
Data2$state.division<-as.factor(Data2$state.division)
Data2$state.region<-as.factor(Data2$state.region)
str(Data2)
summary(Data2)

#Step 8: Splitting dataset into train and test datasets
#We are not splitting the dataset into train and test because the number of observations are too low
#and the model will not converge. We will be running the model on the entire dataset.

set.seed(345)


#Step 9: Fitting the model by Backward Selection

#Iteration 1: All variables included
linearmodel0<-lm(Life.Exp~., data=Data2)
summary(linearmodel0)

#Iteration 2: Dropping state.region 
linearmodel1<-lm(Life.Exp~.-state.region, data=Data2)
summary(linearmodel1)

#Iteration 3: Fixing classes of State.division
linearmodel2<-lm(Life.Exp~Population+Income+Murder+Illiteracy+HS.Grad+Frost+Area+I(state.division=="Middle Atlantic")+I(state.division=="West North Central")+I(state.division=="South Atlantic")+I(state.division=="West South Central"), data=Data2)
summary(linearmodel2)

#Iteration 4:Removing illiteracy
linearmodel3<-lm(Life.Exp~Population+Income+Murder+HS.Grad+Frost+Area+I(state.division=="Middle Atlantic")+I(state.division=="West North Central")+I(state.division=="South Atlantic")+I(state.division=="West South Central"), data=Data2)
summary(linearmodel3)

#Iteration 5: Removing I(state.division=="West South Central")
linearmodel4<-lm(Life.Exp~Population+Murder+HS.Grad+Frost+Area+I(state.division=="Middle Atlantic")+I(state.division=="West North Central")+I(state.division=="South Atlantic"), data=Data2)
summary(linearmodel4)

#Iteration 6: removing area
linearmodel5<-lm(Life.Exp~Population+Murder+HS.Grad+Frost+I(state.division=="Middle Atlantic")+I(state.division=="West North Central")+I(state.division=="South Atlantic"), data=Data2)
summary(linearmodel5) #FINAL MODEL

#cHECKING VIF
as.data.frame(vif(linearmodel5))

#Step 11: Getting predicted values
fitted(linearmodel5)
Data2$pred<-fitted(linearmodel5)

#Step 13: MAPE
attach(Data2)
MAPE<-print((sum((abs(Life.Exp-pred))/Life.Exp))/nrow(Data2)) #MAPE=0.006964836 or 0.696% and Accuracy=99.304%
#The prediction is highly accurate because the number of observations are low.

#Step 14: Autocorrelation
#Durbin-Watson test
dwt(linearmodel5) #p-value = 0.514
#So we fail to reject the null Hypothesis that the residuals from a linear regression model are uncorrelated.

#Step 15: Constant error variance (Heteroscedasticity)
# Breusch-Pagan test
bptest(linearmodel5) #p-value = 0.03858
#So we reject the null hypothesis that the errors are non-homogeneous.

#Model R-squared:0.8018 or 80.18% and Adjusted R-squared:  0.7688 or 76.88%

#Significant Variables at 95% confidence level:
#Population, Murder, HS.Grad, Frost, State division: Middle Atlantic, West North Central and South Atlantic.