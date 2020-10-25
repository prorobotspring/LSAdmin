<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%
	//Evita el \"Caching\" en el servidor Proxy
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.0
	response.setHeader("Pragma", "no-cache"); //HTTP 1.1
	response.setDateHeader("Expires", 0);
%>
<%
	HttpSession sesion = request.getSession(false);
	String nombre = null;
	if (sesion == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	} else {
		nombre = (String) sesion.getAttribute("nombre");

		if (nombre == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	}
	}
%>
<%
	String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Registro de nuevo Usuario</title>
<script type="text/javascript">
function ValidarAlfanumerico(cadena) {
		var numeros = "0123456789";
		for ( var i = 0; i < cadena.length; i++) {
			if (numeros.indexOf(cadena.substring(i, i + 1)) != -1) {
				//alert("El campo seleccionado contiene números");
				return false;
			}
		}
		//alert("El campo seleccionado es correcto");
		return true;
	}
function CadenaVaciaBlancos(cadena) {
	var salida = '';
	for ( var i = 0; i < cadena.length; i++) {
		if (cadena.substring(i, i + 1) != ' ')
			salida = salida + cadena.substring(i, i + 1);
	}
	if (salida.length == 0) {
		//alert("La cadena introducida está vacía");
		return true;
	} else {
		return false;
	}
}
function ValidarFormulario(e) {
	if (CadenaVaciaBlancos(e.nombre.value)) {
		alert("El campo nombre es obligatorio");
		e.nombre.select();
		return;
	}
	if (!ValidarAlfanumerico(e.nombre.value)) {
		alert("El nombre debe ser alfanumérico");
		e.nombre.select();
		return;
	}
	if (CadenaVaciaBlancos(e.identificador.value)) {
		alert("El campo Identificador es obligatorio");
		e.identificador.select();
		return;
	}
	if (!ValidarAlfanumerico(e.identificador.value)) {
		alert("El Identificador debe ser alfanumérico");
		e.nombre.select();
		return;
	}
	e.submit();
}
</script>
<style type="text/css">
.style3 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
	color: #FFFFFF;
	font-weight: bold;
}

.style4 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
	color: #FFFFFF;
}

.style6 {
	color: #000000;
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
}

.style9 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
}
</style>
</head>
<body onload="document.getElementById('nombre').focus()">
<table width="700px" border="0" align="center">
<tr>
<td>
<jsp:include page="commons/MenuPrincipal.jsp"/>
</td>
</tr>
<tr>
<td>
<br>&nbsp;<br>
<form name="form1" method="post" action="RegistrarUsuarioServlet">
<table width="428" border="0" align="center">
	<tr>
		<td colspan="2" class="style9" align="center">
		<div align="center">
		<%
			if (mensaje != null) {
		%><img src="imagenes/redchecksmall001.gif" align="top" width="15"
			height="15" /> <%=mensaje%> <%
 	} else {
 %> <%
 	}
 %>
		</div>
		</td>
	</tr>
	<tr>
		<td height="20" colspan="2" bgcolor="#274069">
		<div align="center" class="style3">Registrar Usuario</div>
		</td>
	</tr>
	<tr>
		<td width="235" bgcolor="#E2E2E2" class="style9">Nombre Usuario</td>
		<td width="247" bgcolor="#E2E2E2" class="style9"><label>
		<input type="text" name="nombre" id="nombre" maxlength="30" size="30"
			class="style9"> </label></td>
	</tr>
	<tr>
		<td width="247" bgcolor="#E2E2E2" class="style9">Identificador (Usuario)<label>
		<td width="247" bgcolor="#E2E2E2" class="style9"><label>
		<input type="text" name="identificador" id="identificador"
			maxlength="30" size="30" class="style9"> </label></td>
	</tr>
	<tr>
		<td bgcolor="#E2E2E2" class="style9">Rol</td>
		<td bgcolor="#E2E2E2" class="style9"><label> <select
			name="rol" id="rol" class="style9">
			<option value="1" class="style9" selected="selected">Administrador</option>
			<option value="2" class="style9">Fraude</option>
			<option value="3" class="style9">Consultas</option>
			<option value="4" class="style9">Aprobaciones</option>
			<option value="5" class="style9">Aprob. y Consultas</option>
			<option value="6" class="style9">Fraude y Consultas</option>
			<option value="7" class="style9">Gestion de Usuario</option>
		</select> </label></td>
	</tr>
</table>
<p>&nbsp;</p>
<table width="200" border="0" align="center">
	<tr>
		<td>
		<div align="center" class="style9"><input name="agregar"
			type="button" class="style9" onClick="ValidarFormulario(this.form)"
			id="1" value="Agregar" /></div>
		</td>
		<td>
		<div align="center" class="style9"><input name="Cancelar"
			type="reset" id="Cancelar" value="Cancelar" class="style9">
		</div>
		</td>
	</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>
