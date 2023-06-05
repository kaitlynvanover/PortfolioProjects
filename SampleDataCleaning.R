data <- read.csv('C:/Users/kaitl/Desktop/Datasets/Income Dirty Data.csv', header = TRUE)
data

sum(is.na(data))
dim(data)
prod(dim(data))

#percent of correct fields
(prod(dim(data)) - sum(is.na(data))) / (prod(dim(data)))

library(deducorrect)

#removing incorrect data
cr <- correctionRules(expression(if(!is.na(age) & age <18) age <- NA,
                                 if(!is.na(income) & income <1) income <- NA,
                                 if(!is.na(tax..15..) & tax..15.. <1) tax..15.. <- NA))

corule <- correctWithRules(cr, data)
newdata <- corule$corrected
newdata

#percent of correct fields
sum(is.na(newdata))
prod(dim(newdata))
(prod(dim(newdata)) - sum(is.na(newdata))) / (prod(dim(newdata)))
                                 
#updating fields                                 
plot(as.factor(newdata$gender))
cr <- correctionRules (expression(if(!is.na(age) & age <18) age <- NA,
                                  if(!is.na(gender) & gender =="Man") gender <- "Male",
                                  if(!is.na(gender) & gender =="Men") gender <- "Male",
                                  if(!is.na(gender) & gender =="Woman") gender <- "Female",
                                  if(!is.na(gender) & gender =="Women") gender <- "Female",
                                  if(!is.na(income) & income<1) income <- NA,
                                  if(!is.na(tax..15..) & tax..15.. <1) tax..15.. <- NA,
                                  if(!is.na(tax..15..) & is.na(income)) income <- (tax..15.. / 0.15),
                                  if(!is.na(income) & is.na(tax..15..)) tax..15.. <- (income * 0.15)
                                  ))

corules <- correctWithRules(cr, data)

newdata1 <- corules$corrected

newdata1
sum(is.na(newdata1))

library(VIM)

#using machine learning to fill in NA fields
summary(newdata1)
data_imputation <- kNN(newdata1)
data_imputation
sum(is.na(data_imputation))
summary(data_imputation)
