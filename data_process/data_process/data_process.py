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
from xml.dom import minidom


def get_attrvalue(node, attrname):
     return node.getAttribute(attrname) if node else ''

def get_nodevalue(node, index = 0):
    return node.childNodes[index].nodeValue if node else ''

def get_xmlnode(node, name):
    return node.getElementsByTagName(name) if node else []

os.chdir("G:/大二上ver2/计算机网络管理/课程大作业/network_manage_bigwork/network_manage_bigwork/Project/data_process")
doc = minidom.parse("nmapinfo.xml") 
root = doc.documentElement
host_nodes = get_xmlnode(root, 'host')

host_list = []
for node in host_nodes:
    host = Host()
    status = get_xmlnode(node, "status")
    addr = get_xmlnode(node, "address")
    #if(addr == []):
        #continue;
    host.state = get_attrvalue(status[0], "state")
    host.ip = get_attrvalue(addr[0], "addr")
    
    ports = get_xmlnode(node, "ports")
    if(ports == []):
        continue;
    ports = get_xmlnode(ports[0], "port")

    for portnode in ports:
        port = Port()
        port.id = get_attrvalue(portnode, "portid")
        state = get_xmlnode(portnode, "state")
        service = get_xmlnode(portnode, "service")
        port.state = get_attrvalue(state[0], "state")
        port.name = get_attrvalue(service[0], "name")
        host.portlist.append(port)
        
    host_list.append(host)    

len(host_list)
len(host_nodes)


def printport(port):
    print("id = " + port.id + "\n"
         +"state = " + port.state + "\n"
         +"name = " + port.name + "\n")

def printhost(host):
    print("ip = " + host.ip + "\n"
         +"state = " + host.state + "\n")
    for p in host.portlist:
        printport(p)
    
printhost(host_list[len(host_list)-1])
file = open('hosts.txt','wb')     
pickle.dump(host_list, file)
file.close()


f = open('hosts.txt', 'rb')
hostlist = pickle.load(f)
tmp = list(map(lambda x: len(x.portlist), hostlist))
len(tmp)
for h in hostlist:
    if(len(h.portlist) == 1000):
        print(list(map(lambda x: x.id, h.portlist)))
        break
        
