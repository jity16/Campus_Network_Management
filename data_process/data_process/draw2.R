library(xlsx)
library(ggplot2)
sshdata = read.xlsx2("piechart.xlsx", sheetIndex = 1)

sshdata$name = as.character(sshdata$name)
sshdata$number = as.numeric(as.vector(sshdata$number))


ssh = matrix(ncol = 2)

for(i in c(1:nrow(sshdata)))
{
  ssh = rbind(ssh, matrix(c(sshdata[i, 1], sshdata[i, 2]), nrow = sshdata[i, 2]/360*178, ncol = 2, byrow = T))

}
View(ssh)
View(sshdata)
ssh = ssh[-1, ]
ssh = data.frame(ssh)
colnames(ssh) = c("name", "number")


ggplot(data=ssh, mapping=aes(x = "ssh Version", fill=name))+
  geom_bar(stat="count",width=0.5,position='stack')+
  coord_polar("y", start=0) + 
  labs(title = "ssh服务版本统计", x = "", y = "")+
  theme(plot.title = element_text(hjust = 0.5))


