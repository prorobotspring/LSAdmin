<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%
//Evita el \"Caching\" en el servidor Proxy
response.setHeader("Cache-Control","no-store"); //HTTP 1.0
response.setHeader("Pragma","no-cache"); //HTTP 1.1
response.setDateHeader("Expires",0);
%>
<%
	HttpSession sesion = request.getSession(false);
	if (sesion != null){
		sesion.removeAttribute("nombre");
		sesion.removeAttribute("modulo");
		sesion.invalidate();
		sesion = null;
	}
%>
<jsp:forward page="index.jsp"></jsp:forward>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cerrar sesión</title>
</head>
<body>
</body>
</html>