<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import="java.util.ArrayList"%>
<%
	HttpSession sesion = request.getSession(false);
	String nombre = null;
	ArrayList modulo = null;
	if (sesion == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	} else {
		nombre = (String) sesion.getAttribute("nombre");
		modulo = (ArrayList) sesion.getAttribute("modulo");
		if (nombre == null || modulo == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	}
	}
%>
<html>
<head>
<title>Menu Principal</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="css/MenuPrincipal.css" />
</head>
<body>
<table width="700px" border="0" align="center">
<tr>
	<td width="10%">&nbsp;</td>
	<div align="center">
		<img src="imagenes/logo_digitel_tim.gif" align="left" />
	</div>
	<td width="90%">&nbsp;</td>
</tr>
<tr>
<td>
<table width="100%" border="0" ALIGN="CENTER">
<tr>
<td width="10%"></td>
<td width="4%"></td>
<td width="10%" VALIGN="MIDDLE" ALIGN="CENTER">
<div id="menu">
<ul>
	<li class="nivel1"><a href="inicio.jsp" class="nivel1">Inicio</a>
	<!--[if lte IE 6]><a href="inicio.jsp" class="nivel1ie">Inicio<table class="falsa"><tr><td><![endif]-->
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
	<%
		if (modulo.contains("1")) {
	%>
	<li class="nivel1"><a href="#" class="nivel1">Operaciones</a>
	<!--[if lte IE 6]><a href="#" class="nivel1ie">Operaciones<table class="falsa"><tr><td><![endif]-->
	<ul>
		<li><a href="CedulasEvaluarView.jsp">Aprobaciones Pendientes</a></li>
		<li><a href="CedulasRechazablesView.jsp">Cédulas con fecha
		inválida</a></li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
	<%
		}
		if (modulo.contains("2")) {
	%>
	<li class="nivel1"><a href="#" class="nivel1">Lista
	Fraude</a> <!--[if lte IE 6]><a href="#" class="nivel1ie">Lista Fraude<table class="falsa"><tr><td><![endif]-->
	<ul>
		<li><a href="incClienteViewForm.jsp">Registrar</a></li>
		<li><a href="ClienteConsultarModView.jsp">Modificar</a></li>
		<li><a href="ClienteConsultarEliView.jsp">Eliminar</a></li>
		<li><a href="ClienteConsultarView.jsp">Consulta Fraude</a></li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
	<%
		}
	%>
	<%
		if (modulo.contains("3")) {
	%>
	<li class="nivel1"><a href="#" class="nivel1">Consultas</a>
	<!--[if lte IE 6]><a href="#" class="nivel1ie">Consultas<table class="falsa"><tr><td><![endif]-->
	<ul>
		<li><a href="CedulasView.jsp">Cédulas Nuevas</a></li>
		<li><a href="consultaCedulaView.jsp">Consulta Cliente</a></li>
		<li><a href="ClienteConsultarView.jsp">Consulta Fraude</a></li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
	<%
		}
	%>
	
	<%
		if (modulo.contains("4")) {
	%>
	<li class="nivel1"><a href="#" class="nivel1">Gestión de Usuarios</a>
	<!--[if lte IE 6]><a href="#" class="nivel1ie">Gestión de Usuarios<table class="falsa"><tr><td><![endif]-->
	<ul>
		<li><a href="incUsuarioViewForm.jsp">Registrar</a></li>
		<li><a href="UsuariosConsultarView.jsp">Consultar</a></li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
	<%
		}
	%>
	<li class="nivel1"><a href="cerrarsesion.jsp" class="nivel1">Salir</a> <!--[if lte IE 6]><a href="cerrarsesion.jsp" class="nivel1ie">Salir<table class="falsa"><tr><td><![endif]-->
	<!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
</ul>
</div>
</td>
</tr>
</table>




</td>
</tr>

</table>

</body>
</html>
