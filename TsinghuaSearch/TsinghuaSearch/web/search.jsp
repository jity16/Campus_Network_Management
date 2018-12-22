<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="data/style.css" />
    <script type="text/javascript">
        window.onload = function(){
            LandingJs.start({
                slide: true,
                brand: 'Tsinghua Search',
            });
        }

    </script>
</head>
<body>
<nav class="navbar navbar-static-top">
    <%--<a class="navbar-brand" href="#">Brand</a>--%>
    <ul class="nav navbar-nav">
        <li><a class="nav-text" href="http://news.tsinghua.edu.cn">News</a>
        </li>
        <li><a class="nav-text" href="http://info.tsinghua.edu.cn">Info</a>
        </li>
        <li><a class="nav-text" href="http://lib.tsinghua.edu.cn">Library</a>
        </li>
        <li><a class="nav-text" href="http://learn.tsinghua.edu.cn">Learn</a>
        </li>
        <li><a class="nav-text" href="http://www.xuetangx.com">Xuetangx</a>
        </li>
    </ul>
</nav>

<div id="no-blur"></div>
<div id="container">
    <h1></h1>
    <form method="post" id="search-form" method="get" action="servlet/CNKIServer">
        <input type="text" name="query" id="query" placeholder="Search for..." />
        <input type="submit" name="notify" id="notify" value="Search" />
    </form>
</div>

<script src="js/landing.js"></script>
</body>
</html>
