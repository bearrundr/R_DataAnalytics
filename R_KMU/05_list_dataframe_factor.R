###########################
# KMU : Lecture
###########################

#--------------------------
# List

x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x)

#Let's compare memory structure of vector and list

#list
mem_view <- function(x) capture.output(.Internal(inspect(x)))
mem_view(x)

#integer vector
intVec <- 1:4
mem_view(c)

#character vector
charVec <- LETTERS[1:4]
mem_view(charVec)

#numeric vector
numVec <- c(1.1, 2.3579, 3.33333, 4.4321)
mem_view(numVec)

#boolean vector
boolVec <- c(TRUE, FALSE, FALSE, TRUE)
mem_view(boolVec)

x[[1]]
x[[3]]

y <- list(int=1:3, char= "a", bool=c(TRUE, FALSE, TRUE), num=c(2.3, 5.9)) 
y
y[[2]]
y[[4]]
y[["num"]]
y$num
y$int
y$bool

y[5] <- "b"
y["added"] <- 5
y

#--------------------------
# Dataframe

myFamilyNames <- c("Dad","Mom","Sis","Bro","Dog")
myFamilyAges <- c(43,42,12,8,5)
myFamilyGenders <- c("Male","Female","Female","Male","Female")
myFamilyWeights <- c(188, 136, 83, 61, 44)

myFamily <- data.frame(Name=myFamilyNames, Age=myFamilyAges, Gender=myFamilyGenders, Weight=myFamilyWeights)
myFamily


row <- 1000
column <- 1000
myMatrix <- matrix(nrow=row, ncol=column)
dim(myMatrix)
head(myMatrix)

system.time(
  for (column in 1:column) {
    for (row in 1:row) {
      myMatrix[row,column] <- row*column
    }
  }
)
head(myMatrix)


row <- 1000
column <- 1000
myDataframe <- data.frame()
dim(myDataframe)

system.time(
  for (column in 1:column) {
    for (row in 1:row) {
      myDataframe[row,column] <- row*column
    }
  }
)
head(myDataframe)


start.time <- Sys.time()
N <- 12
matrixdata <- matrix(rep(0,81), ncol=9) 
for (i in 1:N) {
  for(j in 1:N) {
    matrixdata[i,j] <- i*j  #error. R is lazy.
  }
}
Sys.time() - start.time
matrixdata


# matrix를 행/렬을 잘 맞춰서 하면 dataframe 보다 빠르다.
start.time <- Sys.time()
N <- 9
matrixdata <- matrix(rep(0,81), ncol=9) 
for (i in 1:N) {
  for(j in 1:N) {
    matrixdata[i,j] <- i*j  #error
  }
}
Sys.time() - start.time
matrixdata



start.time <- Sys.time()
N <- 12
dfdata <- data.frame(matrix(rep(0,81), ncol=9))
for (i in 1:N) {
  for(j in 1:N) {
    dfdata[i,j] <- i*j
  }
}
Sys.time() - start.time
dfdata


#--------------------------------------------------------
# data set

data("iris")
str(iris)
summary(iris)
unique(iris$Species)
mean(iris$Sepal.Length[which(iris$Species == "setosa")])

apply(iris[,-5], 2, mean)
lapply(iris[,-5], mean)     # --> list return
sapply(iris[,-5], mean)     # --> vector return

tapply(iris$Sepal.Length, iris$Species, mean)



data("mtcars")
str(mtcars)
head(mtcars)
summary(mtcars)

aggregate(mpg ~ cyl, data = mtcars, mean)

rownames(mtcars)
which.min(mtcars$mpg)
rownames(mtcars)[15]

rownames(mtcars)[which(mtcars$cyl == 4)]

mtcars[which(mtcars$cyl == 4), ]


# --------------------------------------------------------
# factor

fac0 <- c("Male","Female","Female","Male")
fac1 <- factor(c("Male","Female","Female","Male"))
fac0
fac1
fac2 <- factor(c(1,2,1,1,2,3))
levels(fac1)
levels(fac2)


fac3 <- factor(sample(c("high", "middle", "low"), 20, replace=TRUE))
table(fac3)
barplot(table(fac3))

fac4 <- factor(fac3, levels=c("low","middle","high"), ordered=TRUE)
barplot(table(fac4))


fac4 <- factor(fac3, levels=levels(fac3), ordered=TRUE)
fac4



fac5 <- factor(sample(0:1, 20, replace=TRUE))
fac6 <- factor(fac5, labels=c("abs","pre"))
fac5
fac6


# -----------------------------------------------------------

## apply
# create a matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
# mean of the rows
apply(m, 1, mean)
# [1]  6  7  8  9 10 11 12 13 14 15

# mean of the columns
apply(m, 2, mean)
# [1]  5.5 15.5

# divide all values by 2
apply(m, 1:2, function(x) x/2) #annonymous function
#       [,1] [,2]
# [1,]  0.5  5.5
# [2,]  1.0  6.0
# [3,]  1.5  6.5
# [4,]  2.0  7.0
# [5,]  2.5  7.5
# [6,]  3.0  8.0
# [7,]  3.5  8.5
# [8,]  4.0  9.0
# [9,]  4.5  9.5
# [10,]  5.0 10.0


## lapply
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# the mean of the values in each element
lapply(l, mean)
# $a
# [1] 5.5
# 
# $b
# [1] 15.5

# the sum of the values in each element
lapply(l, sum)
# $a
# [1] 55

# $b
# [1] 155



## sapply
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# mean of values using sapply
l.mean <- sapply(l, mean)
# what type of object was returned?
class(l.mean)
# [1] "numeric"
# it's a numeric vector, so we can get element "a" like this
l.mean[['a']]
# [1] 5.5

## tapply
data(iris)
head(iris)

# mean petal length by species
tapply(iris$Petal.Length, iris$Species, mean)
# setosa versicolor  virginica 
# 1.462      4.260      5.552

