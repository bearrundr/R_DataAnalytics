#-------------------------------------------------------------------------------------
# ������ ������ �м� | Drawing Charts
#-------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------
# ���ֵ� �����ڽ�
#-------------------------------------------------------------------------------------

# 1.

# �ѱ��� ���� �۾��� �� �� �ʿ��� ����
library(KoNLP)
library(wordcloud)

useSejongDic()            
mergeUserDic(data.frame("�ֻ�����", "ncn"))   # �ʿ��� �ܾ ������ �߰�
mergeUserDic(data.frame("�����غ�", "ncn"))
mergeUserDic(data.frame("���������", "ncn"))
mergeUserDic(data.frame("��������", "ncn"))
mergeUserDic(data.frame("õ��������", "ncn"))
mergeUserDic(data.frame("�쵵", "ncn"))
mergeUserDic(data.frame("����", "ncn"))
mergeUserDic(data.frame("�߹���������", "ncn"))
mergeUserDic(data.frame("�����", "ncn"))
mergeUserDic(data.frame("���귣��", "ncn"))
mergeUserDic(data.frame("��ξ�", "ncn"))
mergeUserDic(data.frame("�ź��ǵ���", "ncn"))
mergeUserDic(data.frame("�Ѷ��", "ncn"))
mergeUserDic(data.frame("������", "ncn"))
mergeUserDic(data.frame("�����Ǽ�", "ncn"))
mergeUserDic(data.frame("�Ѹ�����", "ncn"))
mergeUserDic(data.frame("��Ӹ��ؾ�", "ncn"))
mergeUserDic(data.frame("�ؼ�����", "ncn"))
mergeUserDic(data.frame("�߹�", "ncn"))
mergeUserDic(data.frame("���ֹμ���", "ncn"))
mergeUserDic(data.frame("�ܵ���", "ncn"))
mergeUserDic(data.frame("���ڷ���", "ncn"))

txt <- readLines("data/jeju.txt")       # data�� ������ �о����
mode(txt)                               # ������ ���������� ǥ��

# ���� ����
txt <- txt[txt != '']
txt <- txt[txt != ' ']
txt <- txt[txt != '  ']
txt <- txt[txt != '   ']
# ���ʿ��� ���� ����
# gsub("������ ����","������ ����","����������")
txt <- gsub("-"," ", txt)
txt <- gsub("&"," ", txt)
txt <- gsub("=>"," ", txt)
txt <- gsub("��"," ", txt)
txt <- gsub("\\("," ", txt)
txt <- gsub("\\)"," ", txt)
txt <- gsub("/"," ", txt)
txt <- gsub(","," ", txt)


# 2.

# extractNoun : ������ �� ���縸 ����ִ� �Լ�.
# sapply : �Լ��� ����� list �� ��´�.
nounList <- sapply(txt, extractNoun, USE.NAMES = F)

# unlist : filtering ���� list ��ü�� �Ϲ� ���ͷ� ��ȯ
place <- unlist(nounList)
# �α��� �̻� �Ǵ� �͸� ���͸�. nchar() = character length
place <- Filter(function(x) {nchar(x) >= 2}, place) 
place

# ������ �ʴ� ���� �ɷ�����.
place <- gsub("����","", place) 
place <- gsub("���","", place)  
place <- gsub("����","", place)  
place <- gsub("ü��","", place) 
place <- gsub("��ü","", place)  
place <- gsub("����","", place)
place <- gsub("����","", place)  
place <- gsub("����","", place)   
place <- gsub("����","", place)
place <- gsub("�˻�","", place)
place <- gsub("�ڽ�","", place)
place <- gsub("����","", place)
place <- gsub("�غ�","", place)
place <- gsub("�ٿ�ε�","", place)
place <- gsub("��ȸ��","", place)
place <- gsub("��õ��","", place)
place <- gsub("��õ","", place)
place <- gsub("�亯��","", place)
place <- gsub("ù°��","", place)
place <- gsub("ù¶��","", place) 
place <- gsub("������","", place)
place <- gsub("�̷���","", place)
place <- gsub("��°��","", place)
place <- gsub("��°��","", place)
place <- gsub("��¶��","", place)
place <- gsub("�����","", place)
place <- gsub("�Ͽ���","", place)
place <- gsub("�ð�","", place)
place <- gsub("�װ�","", place)
place <- gsub("������","", place)
place <- gsub("�����","", place)
place <- gsub("����","", place)
place <- gsub("�װ���","", place)
place <- gsub("����","", place)
place <- gsub("�뷫","", place)
place <- gsub("���","", place)
place <- gsub("\\-","", place)
place <- gsub("�̿�","", place)
place <- gsub("����","", place)
place <- gsub("�ؾ�","", place)
place <- gsub("����̺�","", place)
place <- gsub("����","", place)
place <- gsub("�ٴ�","", place)
place <- gsub("����","", place)
place <- gsub("�Ϸ�","", place)
place <- gsub("��Ʈī","", place)
place <- gsub("�Ͻ�","", place)
place <- gsub("����","", place)
place <- gsub("����","", place)
place <- gsub("��ġ","", place)
place <- gsub("�ʿ�","", place)
place <- gsub("����","", place)
place <- gsub("���","", place)
place <- gsub("����","", place)
place <- gsub("�ҿ�","", place)
place <- gsub("����","", place)
place <- gsub("�ϰ�","", place)
place <- gsub("��ó","", place)
place <- gsub("�߰�","", place)
place <- gsub("�پ�","", place)
place <- gsub("ù��","", place)
place <- gsub("����","", place)
place <- gsub("���","", place)
place <- gsub("����","", place)
place <- gsub("����","", place)
place <- gsub("����","", place)
place <- gsub("�̵�","", place)
place <- gsub("����","", place)
place <- gsub("ü��","", place)
place <- gsub("��°","", place)
place <- gsub(" ","", place)
place <- gsub("\\d+","", place)    #  ��� ���� ���ֱ�

# nouns1 <- grep("^ORA-+", txt, value=T)     # ù���ڰ� ORA- �� �����͸� ���.
# nouns2 <- substr(nouns1,5,9)               #ORA-12345 ���Ŀ��� ���ںκи� �߶�
# nouns3 <- gsub("[A-z]","",nouns2)          # ��� �ִ� �κ��� �����ϰ� ���ڸ� ���ܵ�

place <- Filter(function(x) {nchar(x) >= 2}, place)
place

# ������ �����͸� ���Ϸ� ������ �� �ٽ� table �������� �ٽ� �ҷ�����. �� ���ε� ���ŵ�.
write(unlist(place), "jeju_step2.txt")
place2 <- read.table("jeju_step2.txt")
wordcount <- table(place2)

head(wordcount, 10)
head(sort(wordcount, decreasing=T), 50)   # �󵵼��� ���� ������ �����ؼ� ���� 30�� ��ȸ


# 3.

# -------------------------------------------
# (1) Wordcloud

# min.freq : �ּ� �� �̻� ��޵� �ܾ ���
# scle : range of sizes of the words

library(RColorBrewer)       # color library �ε�
palete <- brewer.pal(9,"Set1") # ���� ���� ����
wordcloud(names(wordcount), freq=wordcount, scale=c(5, 0.5), min.freq=5, random.order=F, random.color=T, colors=palete)


# -------------------------------------------
# (2) Pie Chart

a <- head(sort(wordcount, decreasing=T), 10)
pie(a)
pie(a, col = rainbow(10), radius = 1)

percnt <- round(a/sum(a)*100, 1)      
names(a)
labelname <- paste(names(a), percnt, "%")   # % �� �ֱ�
pie(a, main = "Jeju Tour Point", col = rainbow(10), cex = 0.8, labels = labelname) # cex : size of label

# Conditiional Color
colors <- c()
for (i in 1:length(a)) {
    if (a[i] >= 50) {
        colors <- c(colors, "red")
    }
    else if (a[i] >= 15) {
        colors <- c(colors, "yellow")
    }
    else {
        colors <- c(colors, "green")
    }
}

pie(a, col = colors, radius = 1)

# -------------------------------------------
# (3) Donut Chart - ���� ��� ���� ����.

par(new = T)
pie(a, radius = 0.5, col = "white", labels = NA, border = NA)


# -------------------------------------------
# (4) Bar Chart --- 15_barplot_rainbow

# space : bar ������ ����
# ylim : y �� ������
# cex : size of label

bp <- barplot(a, main="Jeju Tour Point", col=rainbow(10), space=0.2, ylim=c(0,35), cex.names=1.0, las=2)
percnt <- round(a/sum(a)*100, 1)
text(x=bp, y=a*1.1, labels=paste(percnt,"%"), col="black", cex = 0.7)
text(x=bp, y=a*0.9, labels=paste(a), col="black", cex = 0.7)


# -------------------------------------------
# (5) Horizontal Bar Chart --- 15_horizontal_barplot

# xlim : x �� ������

bp <- barplot(a, main="Jeju Tour Point", col=rainbow(10), xlim=c(0,35), cex.names=0.7, las=1, horiz=T)
text(y=bp, x=a*1.15, labels=paste(percnt,"%"), col="black", cex = 0.7)
text(y=bp, x=a*0.9, labels=paste(a), col="black", cex = 0.7)


# -------------------------------------------
# (6) Line Chart

# xlab : x �� labels
# ylab : y �� labels
# type="o" : �缱 / type="s" : ����
# lwd : �� ����
# h : y-value(s) for horizontal line(s).
# v : x-value(s) for vertical line(s).

plot(a, main="Jeju Tour Point", xlab="", ylab="", ylim=c(0,35), axes=FALSE, type="s", col="red", lwd=5)
axis(1, at=1:10, labels=names(a), las=2)   # x ��
axis(2, las=1)                             # y ��
abline(h=seq(0,35,5), v=seq(1,10,1), col="gray", lty=2)


# -------------------------------------------
# (7) 3D Pie Chart

# explode : �� ������ ����

install.packages("plotrix")
library("plotrix")

cpercnt <- round(a/sum(a)*100, 1)
clabels <- paste(names(a), "\n", "(", cpercnt, ")")
pie3D(a, main="���ֵ� ������", col=rainbow(10), cex=0.7, labels=clabels, explode=0.05)


# Plot �̹����� �����ϱ�

# windows(800, 600, pointsize = 12)   # ������ ������ ����
# pie(a)                              # ��Ʈ �׸���
# savePlot("jeju.png", type="png")    # ������� �׸����� ����
# dev.off()                           # ������ �ݱ�



#-------------------------------------------------------------------------------------
# ������ �ڷ� �м� - Propose
#-------------------------------------------------------------------------------------

# chr (����) --> �ܾ� list --> chr (�ܾ�) --> txt --> table list --> wordcount (numeric)

txt <- readLines("data/propose_utf8.txt", encoding = "UTF-8")
txt

txt <- txt[txt != '']
txt <- txt[txt != ' ']
txt <- txt[txt != '  ']

nounList <- sapply(txt, extractNoun, USE.NAMES = F)

tempText <- unlist(nounList)
tempText <- gsub("��������","", tempText)
tempText <- gsub("����","", tempText)
tempText <- gsub("��õ","", tempText)
tempText <- gsub("�亯","", tempText)
tempText <- gsub("��ȸ","", tempText)
tempText <- gsub("����","", tempText)
tempText <- gsub("��Ȱ","", tempText)
tempText <- gsub("�̺�Ʈ","", tempText)
tempText <- gsub("�غ�","", tempText)
tempText <- gsub("\\d+","", tempText)    #  ��� ���� ���ֱ�
tempText <- Filter(function(x) {nchar(x) >= 2}, tempText)


write(unlist(tempText), "propose2.txt")
pro_table <- read.table("propose2.txt")
wordcount <- table(pro_table)

head(sort(wordcount, decreasing=T), 30)

library(RColorBrewer)
palete <- brewer.pal(9,"Set1")

wordcloud(names(wordcount), freq=wordcount, scale=c(5, 0.5), min.freq=5, random.order=F, random.color=T, colors=palete)
