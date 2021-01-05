#  Simple Linear Regression Assignment #
#  3) Emp_data -> Build a prediction model for Churn_out_rate 
#  Do the necessary transformations for input variables for getting better R^2 value for the model prepared.

library(readr)
library(ggplot2)
library(moments)
SH_CO <- read_csv("C:/RAVI/Data science/Assignments/Module 6 Simple linear regression/DataSets/emp_data.csv")
View(SH_CO)
attach(SH_CO)
summary(SH_CO)
range(SH_CO$Salary_hike)
range(SH_CO$Churn_out_rate)
skewness(SH_CO$Salary_hike)
skewness(SH_CO$Churn_out_rate)

#Exploratory Data Analysis
boxplot(SH_CO$Salary_hike)
boxplot(SH_CO$Churn_out_rate)

#scatter plot for Caloriesconsumed vs Weightgained (Plot x,y)
plot(Salary_hike,Churn_out_rate)

#calculate correlation coefficient
cor(Salary_hike,Churn_out_rate)

#Simple Regression model
reg <- lm(Churn_out_rate~Salary_hike,data =SH_CO)
summary(reg)

#values prediction
#Confidence interval Calculation
confint(reg,level = 0.95)
pred <- predict(reg,interval = "predict")
#predict function gives fit value and its lower and upeer values as a range
pred <- as.data.frame(pred)
pred

#####Plot Graph for both Actual values and also the predicted linear Graph(Actual:Red,Predicted:Blue)#########
ggplot() + 
  geom_point(aes(x =`Salary_hike` , y =`Churn_out_rate` ),
             colour='red') + 
  geom_line(aes(x = `Salary_hike`, y = predict(reg, newdata=SH_CO)),
            colour='blue') + 
  ggtitle('Salary_hike vs Churn_out_rate') +
  xlab('Salary_hike') +
  ylab('Churn_out_rate')

cor(pred$fit,`Churn_out_rate`)

#Calculate Residuals "Errors"
reg$residuals
reg$residuals^2
mean(reg$residuals^2)
rmse <- sqrt(mean(reg$residuals^2))
rmse

############ Applying transformations##############
############ lOGORITHMIC MODEL    x = log(Salary_hike); y = Churn_out_rate ############
plot(log(`Salary_hike`),`Churn_out_rate`)
cor(log(`Salary_hike`),`Churn_out_rate`)

log_reg <- lm(`Churn_out_rate` ~ log(`Salary_hike`),data = SH_CO)
summary(log_reg)

#values prediction
#Confidence interval Calculation
confint(log_reg,level = 0.95)
pred_log <- predict(log_reg,interval ="predict")
#predict function gives fit value and its lower and upeer values as a range
pred_log <- as.data.frame(pred_log)
pred_log

rmse_log <- sqrt(mean(log_reg$residuals^2)) 
rmse_log
######or####
res_log=`Churn_out_rate`-pred_log$fit
rmse_log<-sqrt(mean(res_log^2))
rmse_log
##########Plot Graph for both Actual values and also the predicted linear Graph(Actual:Red,Predicted:Blue)#########
ggplot() + 
  geom_point(aes(x =`Salary_hike` , y =`Churn_out_rate` ),
             colour='red') + 
  geom_line(aes(x =`Salary_hike`, y = predict(log_reg, newdata=SH_CO)),
            colour='blue') + 
  ggtitle('Salary_hike vs Churn_out_rate') +
  xlab('Salary_hike') +
  ylab('Churn_out_rate')


############Polynomial model with 2 degree (quadratic model)  ;x =Salary_hike^2 ; y = Churn_out_rate ############
#### input=x & X^2 (2-degree); output=y  ####
reg_quad2<- lm(`Churn_out_rate` ~ `Salary_hike`+I(`Salary_hike`*`Salary_hike`),data = SH_CO)
summary(reg_quad2)

#prediction
#Confidence interval Calculation
confint(reg_quad2,level = 0.95)
pred_quad2<-predict(reg_quad2,interval = "predict")
pred_quad2  <- as.data.frame(pred_quad2)
pred_quad2

resq=`Churn_out_rate`-pred_quad2$fit
rmse_quad<-sqrt(mean(resq^2))
rmse_quad


##########Plot Graph for both Actual values and also the predicted linear Graph(Actual:Red,Predicted:Blue)#########
ggplot() + 
  geom_point(aes(x =`Salary_hike` , y =`Churn_out_rate` ),
             colour='red') + 
  geom_line(aes(x = `Salary_hike`, y = predict(reg_quad2, newdata=SH_CO)),
            colour='blue') + 
  ggtitle('Salary_hike vs Churn_out_rate') +
  xlab('Salary_hike') +
  ylab('Churn_out_rate')

############Polynomial model with 3 degree (quadratic model)  ;x = Salary_hike^3; y = Churn_out_rate ############
#### input=x & X^2 & x^3 (3-degree); output=y  ####
reg_quad3<- lm(`Churn_out_rate` ~ `Salary_hike`+I(`Salary_hike`*`Salary_hike`)+I(`Salary_hike`*`Salary_hike`*`Salary_hike`),data = SH_CO)
summary(reg_quad3)

#prediction
#Confidence interval Calculation
confint(reg_quad3,level = 0.95)
pred_quad3<-predict(reg_quad3,interval = "predict")
pred_quad3  <- as.data.frame(pred_quad3)
pred_quad3

resq3=`Churn_out_rate`-pred_quad3$fit
rmse_quad3<-sqrt(mean(resq3^2))
rmse_quad3
##########Plot Graph for both Actual values and also the predicted linear Graph(Actual:Red,Predicted:Blue)#########
ggplot() + 
  geom_point(aes(x =`Salary_hike` , y =`Churn_out_rate` ),
             colour='red') + 
  geom_line(aes(x = `Salary_hike`, y = predict(reg_quad3, newdata= SH_CO)),
            colour='blue') + 
  ggtitle('Salary_hike vs Churn_out_rate') +
  xlab('Salary_hike') +
  ylab('Churn_out_rate')



