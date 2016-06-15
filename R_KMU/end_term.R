# �츮���� �湮�� �ؿ� �������� �ι���ȭ log ������(Call Data Records, Call Detail Records)
# �������� ������ ��ȭ�� SMS�� �� ��ȭ ���� Ȥ�� �߽ŵǾ����� �ǹ�.

#----------------------------------------------------------------
# 0. load data

setwd("/Volumes/MacHDD/workspace/R_Study/R_KMU")

cdrData <- read.csv("trainData_CDR.csv", header = T, stringsAsFactors = F)
summary(cdrData)
head(cdrData)

require(dplyr)
require(reshape2)


#----------------------------------------------------------------
# 1. �츮���� ���� ���� �湮�� ������ �̸���? 1��� 2�� ������ �湮���� ���̴�?

# touristID �� �������� ���� ��, nation ���� ����
sumByNation <- cdrData %>%
    group_by(touristID, nation) %>%
    summarize(N=n()) %>%
        group_by(nation) %>%
        summarize(Total=n()) %>%
        arrange(desc(Total))

# Answer
sumByNation                                     # 1�� China, 2�� Japan
sumByNation$Total[1] - sumByNation$Total[2]     # 1,2�� �湮���� ���� = 9,312


#----------------------------------------------------------------
# 2.�ؿܿ��ఴ���� ��ȭ�Ǽ��� ���� ���� ������?

# ***** ��� 1 *****
cdrData$weekDay <- weekdays.Date(strptime(cdrData$dateChar, format = "%Y/%m%d"))
head(cdrData)

cdrData %>%
    group_by(weekDay) %>%
    summarize(Total=n())  %>%
    arrange(desc(Total))

# Answer : �ݿ��� 32,217��


# ***** ��� 2 *****
data_Q2 <- df_cdr
head(data_Q2)

# dateChar�� date �������� ����. date ������ dplyr ���� �ȵ�!!!
# �ش� ��¥�� ����. ���� factor�� ���ڷ� ����
data_Q2$date <- strptime(data_Q2$dateChar, format = "%Y/%m%d")
data_Q2$wday <- data_Q2$date$wday     # week : 0 = Sunday
data_Q2$wday <- factor(data_Q2$wday, 
                       levels = c(0:6), labels = c("��","��","ȭ","��","��","��","��"), 
                       ordered = T)

# ���Ϻ� ��ȭ�Ǽ� ���� �� ����
sort(table(data_Q2$wday), decreasing = T) 


#----------------------------------------------------------------
# 3.�ؿܿ��ఴ���� ��ȭ�Ǽ��� ���� ���� �ð����? 

# ***** ��� 1 *****
cdrData %>%
    group_by(Time=substr(timeChar,1,2)) %>%
    summarize(Total=n())  %>%
    arrange(desc(Total))

# Answer : 17�� 18,248��


# ***** ��� 2 *****
# timeChar ù �α��ڰ� �ð�
data_Q2$callTime <- substr(data_Q2$timeChar, 1, 2)

# �ð��뺰 ���� �� ����
sort(table(data_Q2$callTime), decreasing = T) 


#----------------------------------------------------------------
# 4.���������������� �ؿܹ湮���� ������ ��ȭ�Ǽ� ������ ���������������� �ۼ�.

summary1 <-cdrData %>%
    group_by(city, nation) %>%
    summarize(Total=n())

summary1

# ���� city, ���� nation
summary2 <- dcast(summary1, city ~ nation, fun.aggregate=sum, value.var="Total")

# �� city���� �հ�� ����. 
summary2$Total <- apply(summary2[-1], 1, sum)
totalCount <- sum(summary2$Total)
summary2$Ratio <- round(summary2$Total / totalCount * 100,2)
summary2

# Answer : ������ �������� ����
df_AreaNation <- summary2[order(-summary2$Total),]
df_AreaNation


#----------------------------------------------------------------
# 5.������ �湮�� �ؿ� ������ DB ����. �ؿ� �湮 ���� DB�� ����� �ڵ�� �� ����� ����.
# - touristID : �ؿܹ湮���� unique�� touristID
# - totalCall : ����ȭ�Ǽ�
# - callDays : ����ȭ�߻��ϼ� (�������� ��ȭ�� �ִ��� ���� ���̸� �Ϸ�� ȯ��)
# - visitAreas : ���� �湮���� �� (�������� ����)
# 
# dplyr ��Ű���� ������ group_by�� ���� ������ �ʵ忡 �ش��ϴ� �����͸� ������ ��,  join���� DB�� ����.

# 5-1. totalCall
callCount <- cdrData %>%
    group_by(touristID) %>%
    summarize(totalCall=n())

head(callCount);nrow(callCount)

# 5-2. callDays
dayCount <- cdrData %>%
    group_by(touristID, dateChar) %>%
    summarize(N=n())  %>%
        group_by(touristID) %>%
        summarize(callDays=n())

head(dayCount);nrow(dayCount)

# 5-3. visitAreas
areaCount <- cdrData %>%
    group_by(touristID, city) %>%
    summarize(N=n())  %>%
    group_by(touristID) %>%
    summarize(visitAreas=n())

head(areaCount);nrow(areaCount)

# 5-4. �� ������ join
require(plyr)
touristsData <- join(callCount, dayCount)
touristsData <- join(touristsData, areaCount)

head(touristsData)
nrow(touristsData)

# Answer
write.csv(touristsData, "touristsData_callSummary.csv")
