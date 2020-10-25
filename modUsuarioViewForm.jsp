<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import = "ve.com.digitel.lsadmin.jb.UsuarioControl"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modificar Registro de un Usuario</title>
<script type="text/javascript">
function enviar() {
		window.location = 'UsuariosConsultarView.jsp';
	}
</script>
<style type="text/css">
.style1{
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
	color: #FFFFFF;
}
.style3 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
	color: #FFFFFF;
	font-weight: bold;
}

.style4 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
	color: #000000;
	font-weight: bold;
}

.style9 {
	font-family: "Tahoma", Courier, monospace;
	font-size: 12px;
}
</style>
</head>
<body>
<table width="700px" border="0" align="center">
<tr>
<td>
<jsp:include page="commons/MenuPrincipal.jsp"/>
</td>
</tr>
<tr>
<td>
<br>&nbsp;<br>
<!--Formulario que se encarga de enviar los datos al servlet ModificarUsuarioServlet-->
<form name="form1" method="post" action="ModificarUsuarioServlet">
<p>&nbsp;</p>
  <table width="425" border="0" align="center">
  <%
		UsuarioControl usu = (UsuarioControl) request.getAttribute("usu");
		if (usu == null)
			usu = new UsuarioControl();
	%>
	<tr>
		<td colspan="2" class="style9" align="center">
		<div align="center">
		<%
			if (mensaje != null) {
		%><img src="imagenes/check-green_alt.gif" align="top" width="15" height="15" />
		<%=mensaje%> <%
 	} 
		%>
		</div>
		</td>
	</tr>
	<p>&nbsp;</p>
    <tr>
      <td colspan="2" bgcolor="#274069"><div align="center" class="style1">Modificar Registro de un Usuario</div></td>
    </tr>
	<tr>
      <td width="235" bgcolor="#E2E2E2" class="style9"></td>
      <td width="247" bgcolor="#E2E2E2" class="style9"><label>
         <input type="hidden" name="idusuario" id="idusuario" maxlength="30" size="30" class="style9"  value='<%=request.getParameter("cChecked")%>'>
      </label></td>
    </tr>
    <tr>
      <td width="235" bgcolor="#E2E2E2" class="style9">Nombre Usuario</td>
      <td width="247" bgcolor="#E2E2E2" class="style9"><label>
         <input type="text" name="nombreusuario" id="nombreusuario" maxlength="30" size="30" class="style9" disabled="disabled" value='<%=request.getParameter("cNombre")%>'>
      </label></td>
    </tr>
    <tr>
      <td width="247" bgcolor="#E2E2E2" class="style9">Identificador(Usuario)<label>
      <td width="247" bgcolor="#E2E2E2" class="style9"><label>  
	  <input type="text" name="identificador" id="identificador" maxlength="30" size="30" class="style9" disabled="disabled" value='<%=request.getParameter("cIdentificador")%>'>
      </label></td>
    </tr>
    <tr>
      <td bgcolor="#E2E2E2" class="style9">Rol(es)</td>
      <td bgcolor="#E2E2E2" class="style9"><label>
        <select name="rol" id="rol" class="style9">
			   <%
				String vRol = (String) request.getParameter("cRol");
			    if (vRol.equalsIgnoreCase("Administrador")) {
                %>
                <option value="1" class="style9" selected="selected">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
			          if (vRol.equalsIgnoreCase("Fraude")) {
                %>
                <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9" selected="selected">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
                      if (vRol.equalsIgnoreCase("Consultas")) {
                %>
                <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9" selected="selected">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
                      if (vRol.equalsIgnoreCase("Aprobaciones")) {
                %>

                <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9" selected="selected">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
                      if (vRol.equalsIgnoreCase("Aprob. y Consultas")) {
                %>

                <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9" selected="selected">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
                      if (vRol.equalsIgnoreCase("Fraude y Consultas")) {
                %>
                <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9" selected="selected">Fraude y Consultas</option>
                <option value="7" class="style9">Gestion de Usuario</option>

                <%
                      } 
                      if (vRol.equalsIgnoreCase("Gestion de Usuario")) {
                %>

         	    <option value="1" class="style9">Administrador</option>
                <option value="2" class="style9">Fraude</option>
                <option value="3" class="style9">Consultas</option>
                <option value="4" class="style9">Aprobaciones</option>
                <option value="5" class="style9">Aprob. y Consultas</option>
                <option value="6" class="style9">Fraude y Consultas</option>
                <option value="7" class="style9" selected="selected">Gestion de Usuario</option>

                <%
                      }
                %>
        </select>
      </label></td>
    </tr>
</table>
  <p>&nbsp;</p>
  <table width="200" border="0" align="center">
    <tr>
      <td><label>
        <div align="center" class="style9">
          <input name="boton" type="submit" id="Modificar" class="style9" id="1" value="Modificar" onclick="ValidarForm(this.form)">
          </div>
      </label></td>
	   <td><label>
        <div align="center" class="style9">
          <input name="boton" type="button" id="Cancelar" class="style9" id="1" value="Cancelar" Onclick="enviar();">
          </div>
      </label></td>
    </tr>
  </table>
</form>
</td>
</tr>
</table>
</body>
</html>
