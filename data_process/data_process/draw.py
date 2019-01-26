class Host():
    def __init__(self):
        self.state = ""
        self.ip = ""
        self.portlist = []

class Port():
    def __init__(self):
        self.id = ""
        self.state = ""
        self.name = ""
        
        
import os
import pickle
os.chdir("G:/大二上ver2/计算机网络管理/课程大作业/network_manage_bigwork/network_manage_bigwork/Project/data_process")

f = open('hosts.txt', 'rb')
hostlist = pickle.load(f)
f.close()

for h in hostlist:
    if(len(h.portlist) > 30):
        print(h.ip)
        for p in h.portlist:
            print(p.name)
            print(p.state)



f = open('portlist.csv', 'w')
f.write("id, state, name\n")
for h in hostlist:
    for p in h.portlist:
        f.write(p.id + ',' + p.state + ',' + p.name + '\n')
f.close()

f = open('hostlist.csv', 'w')
f.write("ip, state, numofp\n")
for h in hostlist:
    f.write(h.ip + ',' + h.state + ',' + str(len(h.portlist)) + '\n')
f.close()


portstate = []
for h in hostlist:
    for p in h.portlist:
        if(p.state != "filtered" and p.state != "open"):
            print(p.state)

   
         
##各状态端口的数量
portnums = dict()
for h in hostlist:
    for p in h.portlist:
        if(p.state in portnums):
            portnums[p.state] += 1
        else:
            portnums[p.state] = 0       
            

##各种服务的数量
portdict = dict()
for h in hostlist:
    for p in h.portlist:
        if(p.name in portdict):
            portdict[p.name] += 1
        else:
            portdict[p.name] = 0

##按数量对服务降序排序
from collections import OrderedDict
sortdict = OrderedDict(sorted(portdict.items(), key=lambda t: t[1], reverse = True))
sortdict = dict(sortdict)
##去掉不足10个的服务
sortlist = list(filter(lambda x: sortdict[x] > 10 ,sortdict.keys()))
sortdict2 = dict()
for key in sortlist:
    sortdict2[key] = sortdict[key]
    
f = open('portlist.csv', 'w')
for key in portdict:
    f.write(key + ',' + str(portdict[key]) + '\n')
f.close()

##
targetlist = list(filter(lambda x: len(x.portlist)==2 ,hostlist))
for h in targetlist:
    for p in h.portlist:
        print(p.name)

len(targetlist)
for h in targetlist:
    print(h.ip)