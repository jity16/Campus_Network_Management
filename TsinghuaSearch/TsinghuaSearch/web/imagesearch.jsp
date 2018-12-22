<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
System.out.println(request.getCharacterEncoding());
response.setCharacterEncoding("utf-8");
System.out.println(response.getCharacterEncoding());
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println("path="+path);
System.out.println("base path="+basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/cover.css">
  <link rel="stylesheet" href="css/bing.css">
  <script src="js/bootstrap.min.js"></script>
  <title>Tsinghua Search</title>

</head>
<body>
<%--<div class="container">--%>
  <%--<form id="form1" name="form1" method="get" action="servlet/ImageServer">--%>
    <%--<input type="hidden" id="searchAction" name="searchAction"/>--%>
    <%--<div class="form-group col-xs-5">--%>
      <%--<input type="text" name="query" class="form-control" required="true"--%>
             <%--placeholder="Tsinghua Search"/>--%>
    <%--</div>--%>
    <%--<button type="submit" class="btn btn-info" name="Submit" value="搜索">--%>
      <%--<span class="glyphicon glyphicon-search"></span> Search--%>
    <%--</button>--%>
    <%--<br></br>--%>
    <%--<br></br>--%>
  <%--</form>--%>
<%--</div>--%>

<div class="site-wrapper">

  <nav class="navbar navbar-static-top">
      <%--<a class="navbar-brand" href="#">Brand</a>--%>
    <a href="#" class="navbar-left"><img src="css/resource/tsinghua-logo.png" alt=""></a>
      <ul class="nav navbar-nav">
      <li><a href="http://news.tsinghua.edu.cn">News</a>
      </li>
      <li><a href="http://info.tsinghua.edu.cn">Info</a>
      </li>
      <li><a href="http://lib.tsinghua.edu.cn">Library</a>
      </li>
      <li><a href="http://learn.tsinghua.edu.cn">Learn</a>
      </li>
      <li><a href="http://www.xuetangx.com">Xuetangx</a>
      </li>
      </ul>
  </nav>

  <div class="site-wrapper-inner">

    <div id="sbox" class="sw_sform" role="search" data-priority="0" data-bm="10">
        <div class="col-lg-6">
          <div class="input-group input-group-lg">
            <input type="text" class="form-control" placeholder="Search for...">
            <span class="input-group-btn">
               <button class="btn btn-info" type="button">Go!</button>
            </span>
          </div><!-- /input-group -->
        </div>
    </div>

    <%--<div class="cover-container">--%>

      <%--<div class="inner cover">--%>
        <%--<h1 class="cover-heading">Cover your page.</h1>--%>
        <%--<p class="lead">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>--%>
        <%--<p class="lead">--%>
          <%--<a href="#" class="btn btn-lg btn-secondary">Learn more</a>--%>
        <%--</p>--%>
      <%--</div>--%>

      <%--<div class="mastfoot">--%>
        <%--<div class="inner">--%>
          <%--<p>Cover template for <a href="https://getbootstrap.com">Bootstrap</a>, by <a href="https://twitter.com/mdo">@mdo</a>.</p>--%>
        <%--</div>--%>
      <%--</div>--%>

    <%--</div>--%>

  </div>

</div>
</body>
</html>
