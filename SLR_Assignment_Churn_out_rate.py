# -*- coding: utf-8 -*-
"""
Created on Tue Apr 28 16:02:39 2020

@author: RAVI
"""
# For reading data set
# importing necessary libraries
import pandas as pd # deals with data frame  
import numpy as np  # deals with numerical values

SH_CO = pd.read_csv("C:/RAVI/Data science/Assignments/Module 6 Simple linear regression/DataSets/emp_data.csv")

import matplotlib.pylab as plt #for different types of plots
SH_CO.Salary_hike
plt.scatter(x=SH_CO['Salary_hike'], y=SH_CO['Churn_out_rate'],color='green')# Scatter plot

np.corrcoef(SH_CO.Salary_hike, SH_CO.Churn_out_rate) #correlation

help(np.corrcoef)

import statsmodels.formula.api as smf
plt.hist(SH_CO["Salary_hike"])
plt.hist(SH_CO["Churn_out_rate"])
model = smf.ols('Churn_out_rate ~ Salary_hike', data=SH_CO).fit()
model.summary()

#values prediction
#Confidence interval Calculation
pred1 = model.predict(pd.DataFrame(SH_CO['Salary_hike']))
pred1
print (model.conf_int(0.95)) # 95% confidence interval

res = SH_CO.Churn_out_rate - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)

######### Model building on Transformed Data#############

# Log Transformation
# x = log(Salary_hike); y = Churn_out_rate
plt.scatter(x=np.log(SH_CO['Salary_hike']),y=SH_CO['Churn_out_rate'],color='brown')
np.corrcoef(np.log(SH_CO.Salary_hike), SH_CO.Churn_out_rate) #correlation

model2 = smf.ols('Churn_out_rate ~ np.log(Salary_hike)',data=SH_CO).fit()
model2.summary()

pred2 = model2.predict(pd.DataFrame(SH_CO['Salary_hike']))
pred2
print(model2.conf_int(0.95)) # 95% confidence level

res2 = SH_CO.Churn_out_rate - pred2
sqres2 = res2*res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)

############Polynomial model with 2 degree (quadratic model)  ;x = Salary_hike*Salary_hike; y = Churn_out_rate############
#### input=x & X^2 (2-degree); output=y  ####
model4 = smf.ols('Churn_out_rate ~ Salary_hike+I(Salary_hike*Salary_hike)', data=SH_CO).fit()
model4.summary()

pred_p2 = model4.predict(pd.DataFrame(SH_CO['Salary_hike']))
pred_p2

print(model4.conf_int(0.95)) # 95% confidence level

res4 = SH_CO.Churn_out_rate - pred_p2
sqres4 = res4*res4
mse4 = np.mean(sqres4)
rmse4 = np.sqrt(mse4)

###########Polynomial model with 3 degree (quadratic model)  ;x = Salary_hike*Salary_hike*Salary_hike; y = Churn_out_rate############
#### input=x & X^2 (2-degree); output=y  ####
model5 = smf.ols('Churn_out_rate ~ Salary_hike+I(Salary_hike*Salary_hike)+I(Salary_hike*Salary_hike*Salary_hike)', data=SH_CO).fit()
model5.summary()

pred_p3 = model5.predict(pd.DataFrame(SH_CO['Salary_hike']))
pred_p3

print(model5.conf_int(0.95)) # 95% confidence level

res5 = SH_CO.Churn_out_rate - pred_p3
sqres5 = res5*res5
mse5 = np.mean(sqres5)
rmse5 = np.sqrt(mse5)

