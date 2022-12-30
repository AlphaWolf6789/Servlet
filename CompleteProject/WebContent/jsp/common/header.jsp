<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dto.UserDTO"%>
<%@ page import="com.util.Util"%>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/styleMenu.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/template.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/js/jqGrid460/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"
	href='<%=request.getContextPath() %>/css/jquery.ui.theme.css' />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/jquery.checkboxtree.min.css" />

<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jquery-1.10.2.js"></script>
<!-- <script type="text/javascript">
	    var jq = jQuery.noConflict();
	</script> -->
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jquery-ui-1.10.4.custom.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jqGrid460/grid.locale-en.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jqGrid460/jquery.jqGrid.js"></script>

<script src='<%=request.getContextPath() %>/js/jquery.bgiframe.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath() %>/js/jquery.uniform.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath() %>/js/jquery.checkboxtree.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath() %>/js/jquery.maskedinput.js'
	type="text/javascript"></script>

<%
UserDTO logedUser = null;
String roles = null;
try {
	logedUser = (UserDTO) Util.getLoginedUser(request.getSession());
	roles = logedUser.getRoleList();
} catch (Exception ex) {
}
%>

<body>
	<header>
		<div class="banner">
			<div style="float: right; height: 0px; margin-right: 20px;">
				<div class="abc">
					<!-- <ul class="topmenu"> -->
					<a href="#" style="color: yellow;">Xin chào <%=logedUser.getFullName()%></a>&nbsp;|&nbsp;
					<a href="${pageContext.request.contextPath}/login"
						style="color: red;"> Đăng xuất</a>
					<!-- </ul> -->
				</div>
			</div>
			<div class="clearing">&nbsp;</div>
		</div>
		<nav>
			<ul class="nav">
				<li><a href="${pageContext.request.contextPath}/home"
					class="icon home"><span>Home</span></a></li>
				<li class="dropdown"><a href="#">Hệ thống</a>
					<ul class="large">
						<li><a href="#">Reset mật khẩu</a></li>
					</ul></li>
				<li class="dropdown">
					<% if(roles.contains(",JSP_SERVLET,")) {%> <a href="index.html">Chức
						năng 1</a> <%} %>
				</li>
				<% if(roles.contains(",EL_JSTL,")) {%>
				<li class="dropdown"><a href="index.html">Chức năng 2</a></li>
				<%} %>
				<li class="dropdown"><a href="index.html">Quản lý</a>
					<ul class="large">
						<li><a
							href="${pageContext.request.contextPath}/jsp/jquery/Employee.jsp">Nhân
								Viên</a></li>
					</ul></li>
				<li class="dropdown"><a href="index.html">Webservice</a></li>
			</ul>
		</nav>
	</header>

</body>