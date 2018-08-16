#libraries
library(sqldf)
library(RH2)

data("UCBAdmissions")
data


#must be a data frame
ucb<-as.data.frame(UCBAdmissions)
ucb

sqldf("Select * FROM ucb")

majors <-data.frame(major=c("math","biology","engineering","computer science","history","architecture"),Dept=c(LETTERS[1:5],"Other"),Faculty=round(runif(6,min=10,max=30)))
majors

sqldf("SELECT * FROM majors")

#Return Female student admission result
sqldf("Select * FROM ucb where Gender ='Female'")

#Return the admitted students
sqldf("Select * from ucb where Admit ='Admitted'")

# order admissions per department
sqldf("Select * from ucb where Admit='Admitted' order by Freq DESC")

#How many departments are in this table
sqldf("SELECT distinct Dept from ucb")

#total admitted students
sqldf("Select sum(Freq) from ucb where Admit='Admitted'")

#total rejected students
sqldf("SELECT sum(Freq) from ucb WHERE Admit='Rejected'")

#return total admitted males
sqldf("Select sum(Freq) as  total_dudes from ucb where Admit='Admitted' AND Gender='Male'")

#return total females
sqldf("Select sum(Freq) as  total_ladies from ucb where Admit='Admitted' AND Gender='Female'")

# Average number of Admitted student by department (usually mean)
sqldf("SELECT Dept, avg(Freq) as average_admitted from ucb where Admit = 'Admitted' group by Dept")

#How many majors are there
sqldf("Select count(major) from majors")

#minimum amount of students rejected
sqldf("SELECT min(Freq) from ucb where Admit = 'Rejected'")

#Wild Card Match Queries
sqldf("SELECT * FROM ucb where Freq between 20 AND 100")

sqldf("SELECT * FROM ucb where Gender Like 'Fe%'")

sqldf("SELECT * FROM ucb where Gender Like '%male%'")

sqldf("SELECT * FROM ucb where Gender Like 'Ma%'")

sqldf("SELECT * FROM ucb WHERE Gender = 'Female' AND Freq >= 100")

sqldf("SELECT * FROM ucb where Gender LIKE '_ale'")

sqldf("SELECT * FROM ucb WHERE Gender NOT LIKE 'M_l_'")

#Manipulation & Nested Queries
#Which department had the most admitted students = A
sqldf("SELECT Dept FROM ucb WHERE Freq = (SELECT max(Freq) FROM ucb where Admit = 'Admitted')")

#Which Department had the most admitted Female student = C
sqldf("SELECT Dept FROM ucb WHERE Freq = (SELECT max(Freq) FROM ucb where Gender = 'Female')")

#Department with most faculty
sqldf("SELECT Dept FROM majors where Faculty = (Select max(Faculty) FROM majors)")

#Join Queries
#Join the two tables together by the common key
sqldf("Select * from ucb inner join majors on ucb.Dept = majors.Dept")

# Join the table on the left with the resultant nulls's on the right table
sqldf("SELECT * FROM ucb left join majors on ucb.Dept = majors.Dept")

#Join the table on the right with the left
sqldf("SELECT * FROM majors LEFT JOIN ucb on ucb.Dept = majors.Dept")
