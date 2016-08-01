#----------------------------------------------------------------------------
# ���� ������ Ȱ���ϱ� (google map)
#----------------------------------------------------------------------------

require(ggmap)

#---------------------------------------------------------------------------
locData <- read.csv("data/library_blind_seoul.csv", header=T, encoding = "UTF-8")
head(locData)

# ���� ���� ��������
kor <- get_map("seoul", zoom=11, maptype = "roadmap")
# geom_point = x y ��ǥ : ���� �浵 / size : ǥ���� ũ��
# geom_text = �� ǥ��
kor.map <- ggmap(kor) + geom_point(data=locData, aes(x=LON, y=LAT), size=7, alpha=0.7)
kor.map + geom_text(data=locData, aes(x = LON, y = LAT+0.01, label=libCode), size=3)

ggsave("24_ggmap_library.png", dpi=1000)


#---------------------------------------------------------------------------
popData <- read.csv("data/population_201404.csv", header=T, encoding = "UTF-8")
popData

population <- round(popData$poeple/10000)  # �α���(����)

df <- data.frame(popData$LON, popData$LAT, population)
df

# maptype = roadmap / terrain / satellite / hybrid
map1 <- ggmap( get_map("Jeonju", zoom=7, maptype='roadmap') )
map1
map1 + geom_point(aes(x=popData$LON, y=popData$LAT, colour=population, size=population), data=df)

ggsave("24_ggmap_population.png", scale=1, width=7, height=4, dpi=1000)


# ���� ��� ����
map2 <- ggmap( get_map("Jeonju", zoom=7, maptype='roadmap') )
map2 + stat_bin2d(aes(x=popData$LON, y=popData$LAT, colour=population, fill=factor(population), size=population), data=df)

ggsave("24_ggmap_population_bubble.png", scale=2, width=7, height=4, dpi=700)


#---------------------------------------------------------------------------
location <- read.csv("data/jeju_tour_course.csv", header=T, encoding = "UTF-8")
location

kor <- get_map("Hallasan", zoom=10, maptype = "roadmap")
kor.map <- ggmap(kor) + geom_point(data=location, aes(x=LON, y=LAT), size=3, alpha=0.7, col="red")

# geom_path : ��� ǥ��.
kor.map + geom_path(data=location, aes(x=LON, y=LAT), size=1, linetype=2, col="green") +
    geom_text(data=location, aes(x=LON, y=LAT+0.005, label=point), size=2)

ggsave("24_ggmap_jeju_tour_path.png", dpi=700)




#----------------------------------------------------------------------------
# Google Motion Chart
#----------------------------------------------------------------------------

require(googleVis)

#----------------------------------------------------------------------------
Fruits      # ���� ������ ������

# �� ���Ϻ� ������ �Ǹŷ�
fchart <- gvisMotionChart(Fruits, idvar = "Fruit", timevar = "Year")
plot(fchart)     # �ڵ����� �������� �����



#----------------------------------------------------------------------------
# �ð��뺰 1-4ȣ�� ������ �°���

pdata <- read.csv("data/line_1_4_passengers.csv", header = T, sep = ",")
head(pdata)

pchart <- gvisMotionChart(pdata, idvar = "line_no", timevar = "time", options = list(width=1000, height=500))
plot(pchart)



