#Import data
TrainData = read.csv("https://s3.amazonaws.com/cumis/train.csv")
TestData = read.csv("https://s3.amazonaws.com/cumis/test.csv")

#Use str function to identify data type and parameters
str(TrainData)

#Need to add Survived column on our test data set
str(TestData)
TestData$Survived = NA

#Understanding the parameters, Sex and Age plotting
table(TrainData$Survived)
table(TrainData$Survived, TrainData$Sex)
barplot(table(TrainData$Survived), names.arg = c("Perished", "Survived"), 
        main = "Train Data Passenger Fate", col = "black")
mosaicplot(TrainData$Sex ~ TrainData$Survived, main = "Passenger Fate by Gender", 
           shade = FALSE, color = TRUE, xlab = "Sex", ylab = "Survived")
boxplot(TrainData$Age ~ TrainData$Survived, 
        main="Passenger Fate by Age",
        xlab="Survived", ylab="Age")
mosaicplot(TrainData$Pclass ~ TrainData$Survived, 
           main="Passenger Fate by Traveling Class", shade=FALSE, 
           color=TRUE, xlab="Pclass", ylab="Survived")

#Build prediction for women and children 
TestData$Survived <- 0
TestData$Survived[TestData$Sex == "female" || TestData$Age < 16] <- 16
#Create data frame for our prediction with two columns: "PassengerId" and "Survived"
solution = data.frame(PassengerId = TestData$PassengerId, Survived = TestData$Survived)

#Creating csv file
write.csv(solution, file = "solution.csv", row.names = FALSE)
