library("readr")
payroll <- read.csv("/home/m280data/la_payroll/City_Employee_Payroll.csv")

library("rio")
export(payroll,"payroll.rds")

payrolls <- read_rds("payroll.rds")
payrolls[is.na(payrolls)] <- 0

sapply(payroll, class)
#2
library("tidyveryse")
library("magrittr")
library("dplyr")
payroll_by_year <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                    payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
               by = list(payrolls$Year), sum))
colnames(payroll_by_year) <- c("Year", "Total.Payments", "Base.Pay", "Overtime.Pay", "Other.Pay")
library("tidyr")
payroll_by_year_long <- gather(payroll_by_year, type, value, Base.Pay:Other.Pay)

library("ggplot2")
function1 <- function(x) {ggplot(data = x,aes(Year,value)) + 
  geom_col(aes(fill=type), position = "stack")}

function1(payroll_by_year_long)

#3 Who earned most? 
#Visualize the payroll information (total payment with breakdown into base pay, 
#overtime pay, and other pay, Department, Job Title) 
#of the top n highest paid LA City employees in a specific year. 
#User specifies n (default 10) and year (default 2017).

only_pay <- payrolls[ -c(3:15, 18:21, 23, 25:35) ]
only_pay <- only_pay[order(only_pay$Total.Payments,decreasing=T),]

#4 Which departments earn most? 
#Visualize the mean or median payroll, 
#with breakdown into base pay, overtime pay, and other pay, of top n earning departments. 
#User specifies n (default 5), year (default 2017), and method (mean or median, default median).

department_mean <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                             payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
                        by = list(payrolls$Department.Title, payrolls$Year), mean))
colnames(department_mean) <- c("Department.Title", "Year", "Mean.Total.Payments", "Mean.Base.Pay", "Mean.Overtime.Pay", "Mean.Other.Pay")

department_median <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                                                payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
                                           by = list(payrolls$Department.Title,payrolls$Year), median))
colnames(department_median) <- c("Department.Title","Year", "Median.Total.Payments", "Median.Base.Pay", "Median.Overtime.Pay", "Median.Other.Pay")




department_order <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                                                payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
                                           by = list(payrolls$Department.Title, payrolls$Year), sum))
colnames(department_order) <- c("Department.Title","Year", "Total.Payments", "Base.Pay", "Overtime.Pay", "Other.Pay")

department_order <- department_order[order(department_order$Total.Payments,decreasing=T),]
department_mean <- department_mean[order(match(
  paste(department_mean[,1],department_mean[,2]),
  paste(department_order[,1],department_order[,2]))
),]
department_median <- department_median[order(match(
  paste(department_median[,1],department_median[,2]),
  paste(department_order[,1],department_order[,2]))
),]


#5 Which departments cost most? 
#Visualize the total payroll, 
#with breakdown into base pay, overtime pay, and other pay, 
#of top n expensive departments. 
#User specifies n (default 5) and year (default 2017).

cost_order <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                                           payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.,
                                           payrolls$Average.Benefit.Cost), 
                                            by = list(payrolls$Department.Title, payrolls$Year), sum))
colnames(cost_order) <- c("Department.Title","Year", "Total.Payments", "Base.Pay", "Overtime.Pay", "Other.Pay", "Average.Benefit.Cost")
cost_order <- cost_order[order(cost_order$Average.Benefit.Cost,decreasing=T),]

#5 what kind of jobs earn the most in average? 
#Visualize the mean or median total payroll, 
#with breakdown into base pay, overtime pay, and other pay, 
#of top n expensive job titles. 
#User specifies n (default 5) and year (default 2017).
job_mean <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                                                payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
                                           by = list(payrolls$Job.Class.Title, payrolls$Year), mean))
colnames(job_mean) <- c("Job.Class.Title", "Year", "Mean.Total.Payments", "Mean.Base.Pay", "Mean.Overtime.Pay", "Mean.Other.Pay")
job_mean <- job_mean[order(job_mean$Mean.Total.Payments,decreasing=T),]

job_median <- as.data.frame(aggregate(list(payrolls$Total.Payments, payrolls$Base.Pay, 
                                                  payrolls$Overtime.Pay, payrolls$Other.Pay..Payroll.Explorer.), 
                                             by = list(payrolls$Job.Class.Title,payrolls$Year), median))
colnames(job_median) <- c("Job.Class.Title","Year", "Median.Total.Payments", "Median.Base.Pay", "Median.Overtime.Pay", "Median.Other.Pay")
job_median <- job_median[order(job_median$Median.Total.Payments,decreasing=T),]
