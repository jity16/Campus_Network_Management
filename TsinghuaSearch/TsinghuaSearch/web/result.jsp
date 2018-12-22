<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="static java.lang.Integer.min" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String imagePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
    String currentQuery=(String) request.getAttribute("currentQuery");
    int currentPage=(Integer) request.getAttribute("currentPage");
    int totalResultsCnt1 = (Integer) request.getAttribute("totalResultsCnt1");
    int totalResultsCnt2 = (Integer) request.getAttribute("totalResultsCnt2");
    int numPerPage = (Integer) request.getAttribute("numPerPage");
    String typeString = (String) request.getAttribute("type");
    String IPClass = typeString.equals("IP") ? "cur":"";
    String servClass = typeString.equals("serv") ? "cur":"";
//    String[] times = (String[]) request.getAttribute("times");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<title><%currentQuery%>-result</title>--%>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/result.css">
</head>
<body>
    <div class="wrap">
        <div class="header">
            <a class="logo" href="http://www.tsinghua.edu.cn"></a>
            <form name="searchForm" id="searchForm" method="get" action="CNKIServer">
                <div class="querybox">
                    <div class="qborder">
                        <div class="qborder2">
                            <input type="text" class="query" id="upquery" name="query" value="<%=currentQuery%>">
                            <a href="#" class="qreset2" style="visibility: hidden;"></a>
                        </div>
                    </div>
                    <input type="hidden" name="ie" value="utf8">
                    <input type="hidden" name="type" value="<%=typeString%>">
                    <input type="submit" name="Submit" value="Search" class="sbtn1" uigs="searchBtn" id="searchBtn">
                </div>
            </form>
        </div>
    </div>

    <div class="wrapper">
        <div id="main" class="main">
            <div class="left-nav">
                <ul>
                    <li><a id="left_timespan_0" class="<%=IPClass%>" href="?query=<%=currentQuery%>&currentPage=<%=currentPage%>&type=IP"><span>IP查询</span></a></li>
                    <li><a id="left_timespan_1" class="<%=servClass%>" href="?query=<%=currentQuery%>&currentPage=<%=currentPage%>&type=serv"><span>服务查询</span></a></li>
                </ul>
            </div>

            <div class="results">
                <%
                    String[] titles = null;
                    Integer[] contents = null;
                    String[] urls = null;
                    Integer[] temp = null;
                    String first, second, therd;
                    if(typeString.equals("IP")) {
                        titles = (String[]) request.getAttribute("serv");
                        contents = (Integer[]) request.getAttribute("port_num");
                        urls = (String[]) request.getAttribute("state");
                        first = "服务名称：";
                        second = "端口号：";
                        therd = "端口状态：";
                    }
                    else {
                        titles = (String[]) request.getAttribute("IP");
                        contents = (Integer[]) request.getAttribute("num_serv");
                        urls = new String[titles.length];
                        temp = (Integer[]) request.getAttribute("port_num");
                        for(int i=0;i<titles.length;++i) {
                            urls[i] = temp[i].toString();
                        }
                        first = "IP地址：";
                        second = "该IP开放的端口数量：";
                        therd = "该服务对应的端口：";
                    }

                    if(titles!=null && titles.length>0){
                        for(int i=10 * (currentPage - 1);i<titles.length && i<10*currentPage;i++){
                        String rb_id = "rb_"+i;
                        String cacheresult_info = "cacheresult_info_"+i;
                        String cacheresult_summary = "cacheresult_summary_"+i;
                        %>

                <div id="<%=rb_id%>" class="rb">
                    <h3 class="pt">
                        <%=first + titles[i]%>
                    </h3>
                    <div class="ft" id="<%=cacheresult_summary%>">
                        <%=second + contents[i].toString()%>
                    </div>
                    <div class="fb">
                        <cite id="<%=cacheresult_info%>">
                            <%=therd + urls[i]%>
                        </cite>
                    </div>
                </div>
                <%
                    }}else {%>
                      <h3>NO RESULT</h3>
                    <%}
                %>

            </div>
            <div class="pag">
                <p>
                    <%if(currentPage > 1){ %>
                    <a href="CNKIServer?query=<%=currentQuery%>&page=<%=currentPage-1%>&type=<%=typeString%>" class="pevpage">上一页</a>
                    <%}; %>
                    <%for (int i=Math.max(1,currentPage-4);i<currentPage;i++){%>
                    <a href="CNKIServer?query=<%=currentQuery%>&page=<%=i%>&type=<%=typeString%>"><%=i%></a>
                    <%}; %>
                    <span><%=currentPage%></span>
                    <%for (int i=currentPage+1; i <= min(currentPage+4, (typeString.equals("IP") ? totalResultsCnt1 : totalResultsCnt2)/numPerPage);i++){ %>
                    <a href="CNKIServer?query=<%=currentQuery%>&page=<%=i%>&type=<%=typeString%>"><%=i%></a>
                    <%}; %>
                    <% if (currentPage < (typeString.equals("IP") ? totalResultsCnt1 : totalResultsCnt2)/numPerPage) {%>
                    <a href="CNKIServer?query=<%=currentQuery%>&page=<%=currentPage+1%>&type=<%=typeString%>" class="nextpage">下一页</a>
                    <%}%>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
