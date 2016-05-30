#------------------------------------------------------------
# wordcloud test
#------------------------------------------------------------

setwd("/Volumes/MacHDD/workspace/R_Study/R_JS")

library(KoNLP)  # ��ġ�� ��Ű���� Loading �մϴ�.
library(wordcloud)

#Step 3. �м��� �����͸� ������ �о� ���Դϴ�.

txt <- readLines("data/hong.txt") # txt ��� ������ �� �� �� �о� ���Դϴ�.
txt

#Step 4. ������ �߿��� ���縸 ��� �� nouns ������ �Ҵ��մϴ�.

txt <- gsub("��","",txt)  # ������ ���ڸ� �����մϴ�
txt <- gsub("��","",txt)
txt <- gsub("��","",txt)
txt <- gsub("��","",txt)

nouns <- sapply(txt,extractNoun,USE.NAMES=F)

#Step 5. ����� ���縦 ���� 30 ���� ����ؼ� Ȯ���մϴ�.

head(unlist(nouns), 30)

#Step 6. ���Ͽ� ������ �Ӵϴ�. 

write(unlist(nouns),"hong_2.txt") 

#Step 7. ���� �Ϸ�� ������ �ٽ� table �������� ��ȯ�ؼ� ������ �ҷ����Դϴ�.

rev <- read.table("hong_2.txt")

#Step 8. ȭ�鿡 �׷������� ����ϱ� ���� text ���·� ����� Ȯ���� ���ϴ�

nrow(rev) # rev ������ ����� �����Ͱ� �ִ��� Ȯ���� ���ϴ�
wordcount <- table(rev)
head(sort(wordcount, decreasing=T),30)

#Step 9. Word Cloud ���·� �׷������� ����մϴ�

library(RColorBrewer) # ȭ�鿡 ����� �÷��� ����� ���̺귯���� Loading �մϴ�.
palete <- brewer.pal(9,"Set1") # ���� ������ �����մϴ�.

wordcloud(names(wordcount),freq=wordcount,scale=c(5,0.5),rot.per=0.25,min.freq=1,
          random.order=F,random.color=T,colors=palete)
