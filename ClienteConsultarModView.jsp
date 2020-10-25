<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import="ve.com.digitel.lsadmin.jb.Fraude"%>
<%
//Evita el \"Caching\" en el servidor Proxy
response.setHeader("Cache-Control","no-store"); //HTTP 1.0
response.setHeader("Pragma","no-cache"); //HTTP 1.1
response.setDateHeader("Expires",0);
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Consultar registro de un cliente</title>
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

	function ValidarNumerico(cadena) {
		var numeros = "0123456789";
		for ( var i = 0; i < cadena.length; i++) {
			if (numeros.indexOf(cadena.substring(i, i + 1)) == -1) {
				alert("El campo seleccionado no es correcto");
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
		if (CadenaVaciaBlancos(e.cedula.value)) {
		alert("El campo cedula es obligatorio");
		e.cedula.select();
		return;
		}
	e.submit();
  	}

	function ValidarForm(e) {
		if (CadenaVaciaBlancos(e.nombre.value)) {
			alert("El campo nombre es obligatorio");
			e.nombre.select();
			return;
		}
		if (!ValidarAlfanumerico(e.nombre.value)) {
			alert("El nombre ha de ser alfanumérico");
			e.nombre.select();
			return;
		}
		if (CadenaVaciaBlancos(e.apellido.value)) {
			alert("El campo apellido es obligatorio");
			e.apellido.select();
			return;
		}
		if (!ValidarAlfanumerico(e.apellido.value)) {
			alert("El apellido ha de ser alfanumérico");
			e.apellido.select();
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
	color:#FFFFFF;
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
<body onload="document.getElementById('cedula').focus()">
<table width="700px" border="0" align="center">
<tr>
<td>
<jsp:include page="commons/MenuPrincipal.jsp"/>
</td>
</tr>
<tr>
<td>
<br>&nbsp;<br>
<!--Formulario que se encarga de enviar los datos al servlet BuscadorClienteFraudeModServlet-->
<form id="form1" name="form1" method="post" action="BuscadorClienteFraudeModServlet">
<p>&nbsp;</p>
<table width="428" border="0" align="center">
	<%
		Fraude frau = (Fraude) request.getAttribute("frau");
		if (frau == null)
			frau = new Fraude();
	%>
	<tr>
		<td colspan="2" class="style9" align="center">
		<div align="center">
		<%
			if (mensaje != null) {
		%><img src="imagenes/error.gif" align="top" width="15" height="15" />
		<%=mensaje%> <%
 	} else {
 %> <%
 	}
 %>
		</div>
		</td>
	</tr>
	<tr>
		<td width="185" bgcolor="#274069">&nbsp;<span class="style4" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo
		<label><select name="tipo" id="tipo" class="style9">
			<%
				if (frau.getTipo().equalsIgnoreCase("E")) {
			%>
			<option value="V">V</option>
			<option value="E" selected="selected">E</option>
			<option value="P">P</option>
			<%
				} else {
					if (frau.getTipo().equalsIgnoreCase("V")) {
			%>
			<option value="V" selected="selected">V</option>
			<option value="E">E</option>
			<option value="P">P</option>
			<%
				} else {
			%>
			<option value="V">V</option>
			<option value="E">E</option>
			<option value="P" selected="selected">P</option>
			<%
				}
				}
			%>
		</select> </label> </span><label></label></td>
		<td width="227" bgcolor="#274069">&nbsp;<span class="style4" >Cedula <label>
		<input type="text" name="cedula" id="cedula"
			value="<%=frau.getCedula()%>"> </label> </span> <label> </label></td>
	</tr>
</table>
<table width="428" border="0" align="center">
	<tr>
		<td class="style9" bgcolor="#E2E2E2">Nombre</td>
		<td bgcolor="#E2E2E2"><label><input type="text" name="nombre" id="nombre"
			disabled="disabled" value="<%=frau.getNombre()%>"></label></td>
	</tr>
	<tr>
		<td class="style9" bgcolor="#E2E2E2">Apellido</td>
		<td bgcolor="#E2E2E2"><label> <input type="text" name="apellido"
			id="apellido" disabled="disabled" value="<%=frau.getApellido()%>"></label></td>
	</tr>
	<tr>
		<td class="style9" bgcolor="#E2E2E2">Tipo de Linea</td>
		<td bgcolor="#E2E2E2"><label> <select name="tipolinea" class="style9"
			id="tipolinea" disabled="disabled">
			<%
				if (frau.getTipolinea().equalsIgnoreCase("Prepago")) {
			%>
			<option value="Prepago" disabled="disabled" selected="selected">Prepago</option>
			<option value="Postpago" disabled="disabled">Postpago</option>
			<%
				} else {
			%>

			<option value="Prepago" disabled="disabled">Prepago</option>
			<option value="Postpago" disabled="disabled" selected="selected">Postpago</option>
			<%
				}
			%>
		</select> </label></td>
	</tr>
</table>
<p>&nbsp;</p>
<table width="160" border="0" align="center">
	<tr>
		<td width="134">
		<div align="center"><label> <input name="boton"
			type="button" class="style9" onClick="ValidarFormulario(this.form)" id="1" value="Consultar"> </label></div>
		</td>
	</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>