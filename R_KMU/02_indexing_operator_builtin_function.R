###########################
# KMU : Lecture
###########################

###########################
# vector indexing
###########################

# making vectors

smpl_vector <- seq(1,20,2)
smpl_vector

mode(smpl_vector)
length(smpl_vector)

smpl_vector[1]
smpl_vector[9]
smpl_vector[length(smpl_vector)]
smpl_vector[3:length(smpl_vector)]
smpl_vector[3:length(smpl_vector)-1]        # c(3,4,5,6,7,8,9,10) - 1 = c(2,3,4,5,6,7,8,9)
smpl_vector[3:(length(smpl_vector)-1)]      # ��ȣ ��ġ �߿�. ���ȣ ���� ���ڴ� �ڸ� ��ȣ !!!
smpl_vector[-length(smpl_vector)]           # - : �ش� ��ġ �� ����

nchar("Hello")
nchar(smpl_vector)                          # ���ڿ� ����
smpl_vector[nchar(smpl_vector) >= 2]        # FFFFFTTTTT : True ��ġ�� ���鸸 ����


char_vector <- LETTERS
char_vector
mode(char_vector)

-1:5
1:5%%5
1:5^2          # 1:25


for (i in char_vector) {
  print(i)
}

for (i in char_vector) {
  cat(i)
}

for (i in char_vector) {
  cat(i, "\n")
}



# ---------------------------------------------------------------
str_vector <- c("hello", "me", "?", "it", "looking", "is", "you", "for")
str_vector

word_arrange <- c(1,6,4,2,7,5,8,3)  # hello is it me you looking for ?

for (i in word_arrange) {
  print(str_vector[i])
}

bool_vector <- c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
mode(bool_vector)
sum(bool_vector) # count the number of TRUEs

str_vector[bool_vector]       # TRUE ��ġ�� �͸� ���


# ---------------------------------------------------------------

str_vector[c(1,2,3,4,5,7,6,8)]
str_vector[seq(1,7,2)]
factorial(8)

sample(1:8, 8, replace = F)


# �ܾ��� ���� c(1,6,4,2,7,5,8,3)�� ã�� �ð� ����

str_vector <- c("hello", "me", "?", "it", "looking", "is", "you", "for")

start.time <- Sys.time()
for (i in 1:100000) {
  set.seed(i)
  dummy_str <- str_vector[sample(1:8, 8, replace=F)]
  
  # 8���� �ڸ��� ��� True�̸� sum() == 8
  if (sum(dummy_str == str_vector[c(1,6,4,2,7,5,8,3)] ) == 8) {
    print(i)
    print(dummy_str)
  }
}
Sys.time() - start.time



str_vector[c(1,6,4,2,7,5,8,3)]


na_vector <- rep(NA, 7)
na_vector
mode(na_vector)

null_vector <- NULL
null_vector
mode(null_vector)

null_vector2 <- c()
null_vector2


# how to count vector's number of elements?

length(smpl_vector)
length(char_vector)
length(str_vector)
length(bool_vector)


# Boolean retrieval

str_vector <- c("hello,", "me","?", "it", "looking", "is", "you", "for")
bool_vector <- c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
bool_vector

sum(bool_vector) # count the number of TRUEs

str_vector[bool_vector]

# application of boolean retrieval : comparing conditions

set.seed(25)
myVector <- sample(1:20, 10, replace=T)
myVector
myVector[myVector >= 10]
conditionCompare <- myVector >= 10
conditionCompare
myVector[conditionCompare]


# application of positive integer retrieval : which()

which(myVector >= 10)              # position list
myVector[which(myVector >= 10)]


# sigmoid function
x <- seq(-20,20,0.1)
length(x)
sigmoid <- exp(x)/(1+exp(x))
plot(x, sigmoid)


# ------------------------------------------------------------------

x <- seq(-5, 5, 0.1)
y <- exp(x)

plot(x, y)

sigmoid <- exp(x)/(1+exp(x))
plot(x, sigmoid)


z <- exp(9^(1/5)) / (1+exp(9^(1/5)))
z

# ���ϸ���Ʈ �� ���� "R" �� ���ϸ��� ���
getwd()
setwd("/Volumes/MacHDD/workspace/R_Study/R_KMU")
dirlist <- dir()
dirlist
nchar(dirlist)

dirlist[3]
substr(dirlist[3], nchar(dirlist[3]), nchar(dirlist[3]))  # ������ġ, ����ġ

endIndex <- substr(dirlist, nchar(dirlist), nchar(dirlist)) == "R"
endIndex
dirlist[endIndex]


str_vector <- c("1", "2", "3", "4")
str_vector2 <- c("5", "6", "7", "9")

paste(str_vector, str_vector2)
paste(str_vector, str_vector2, sep = "*")
paste(str_vector, str_vector2, collapse = " * ")
