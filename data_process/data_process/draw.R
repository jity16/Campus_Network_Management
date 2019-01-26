library(ggplot2)

portlist = read.csv("portlist.csv", stringsAsFactors = F)

services = levels(as.factor(portlist$name))
View(services)

freq = table(portlist$name)

##各种服务的占比（删除了数量不超过50的服务）
portlist2 = subset(portlist, freq[name] > 50)
ggplot(data = portlist2, aes(x = name)) + geom_bar(fill = "cadetblue3", width = 0.5)
ggplot(data = portlist2, aes(x = name, fill = name)) + geom_bar(width = 0.5)


##端口各state的占比
ggplot(data=portlist, mapping=aes(x="state",fill=state))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0)


##相同类服务的不同版本的数量对比
#http & https
httpall = subset(portlist, grepl("http", name))
httpslist = subset(portlist, grepl("https", name))
httplist = subset(portlist, grepl("http", name) & !grepl("https", name))
nrow(httpslist)
nrow(httplist)


ggplot(data=httpall, mapping=aes(x = "Service", fill=name))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0) + 
  labs(title = "http类端口数量（含https）", x = "", y = "")+
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data=httpslist, mapping=aes(x = "Service", fill=name))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0)+
  labs(title = "https类端口数量", x = "", y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data=httplist, mapping=aes(x = "Service", fill=name))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0)+
  labs(title = "http类端口数量（不含https）", x = "", y = "")+
  theme(plot.title = element_text(hjust = 0.5))


#ftp
ftplist = subset(portlist, grepl("ftp", name))
ggplot(data=ftplist, mapping=aes(x = "Service", fill=name))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0)+
  labs(title = "ftp类端口数量", x = "", y = "")+
  theme(plot.title = element_text(hjust = 0.5))


##host
hostlist = read.csv("hostlist.csv", stringsAsFactors = F)


##各ip的端口数（排除了超过100的端口）
hostlist2 = subset(hostlist, numofp < 100)
ggplot(data = hostlist2, aes(x = numofp)) + 
  geom_bar(fill = "cadetblue3", width = 0.5) + 
  labs(title = "各ip的端口数", x = "端口数", y =  "对应数量")+
  theme(plot.title = element_text(hjust = 0.5))
##特殊端口
hostlist3 = subset(hostlist2, numofp == 2)

