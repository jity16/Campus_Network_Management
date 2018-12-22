f = open("nmapinfo.xml")
fout = open("data.txt", "w")

host_list = []
host = {}

lines = f.readlines()
for line in lines:
	if line[1:6] == "host ":
		if host != {}:
			host_list.append(host)
		host = {}
		host["port"] = []
	if line[1:9] == "address ":
		host["addr"] = line.split(" ")[1][6:-1]
	if line[1:6] == "port ":
		p = {}
		p["id"] = line.split(" ")[2][8:-8]
		p["state"] = line.split(" ")[3][7:-1]
		p["serv"] = line.split(" ")[6][6:-1]
		host["port"].append(p)

for i in host_list:
	fout.write(i["addr"] + " ")
	for j in i["port"]:
		fout.write(j["id"] + " " + j["state"] + " " + j["serv"] + " ")
	fout.write("\n")
