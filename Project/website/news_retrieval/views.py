from django.shortcuts import render
import pickle
from jieba import lcut_for_search
import os
import copy
import re
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
import time



print(os.getcwd())
global host_list

host_list = pickle.load(open('hosts.txt','rb'))


#制造ip对应的词典
ip_dict = dict()
for h in host_list:
    ip_dict[h.ip] = h
#制造各种资源对应的词典
rc_dict = dict()


for h in host_list:
    h.portnum = len(h.portlist)
    for p in h.portlist:
        if(p.name in rc_dict):
            rc_dict[p.name].append(h)
        else:
            rc_dict[p.name] = [h]



# Create your views here.


def index(request):
    return render(request, 'index.html')

def s1(request):
    return render(request, 's1.html')
def s2(request):
    ##如果是从资源结果界面的ip跳转过来
    if('ip' in request.GET):
        ip = request.GET['ip']
        host = ip_dict[ip]
        return render(request, 'r1.html', locals())
    #如果是从资源搜索界面条转过来
    if('rc' in request.GET):
        rc = request.GET['rc']
        hosts = rc_dict[rc]
        return render(request, 'r2.html', locals())
    return render(request, 's2.html')

def r1(request):
    print("test???")
    print(request.POST)
    ip = request.POST['IP']
    if(ip in ip_dict):
        host = ip_dict[ip]
        return render(request, "r1.html", locals())
    else:
        return render(request, "notfound.html")

def r2(request):
    return rendet(request, "index.html")





