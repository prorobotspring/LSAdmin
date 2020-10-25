<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import = "java.util.ArrayList"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Búsqueda de Usuario</title>
<script type="text/javascript">
function valorCheck(vThis, vNombre, vIdentificador, vRol) {
	//alert(vThis.name + " /// " + vThis.checked + " /// " + vThis.value + " /// " + window.document.vForm.cChecked.value);
	if (vThis.checked==true) {
		window.document.vForm.cChecked.value = vThis.value;
		window.document.vForm.cNombre.value = vNombre;
		window.document.vForm.cIdentificador.value = vIdentificador;
		window.document.vForm.cRol.value = vRol;
	} else {
		window.document.vForm.cChecked.value = "null";
		window.document.vForm.cNombre.value = "null";
		window.document.vForm.cIdentificador.value = "null";
		window.document.vForm.cRol.value = "null";
	}
}

function validarRadio(vForm, vAction) {
	
	for ( var i = 0; i < vForm.seleccion.length; i++) {
		if (vForm.seleccion[i].checked)
			fInicialPag();
			fSubmit (vAction);
	}
	alert('Debe marcar un usuario');
	return;
}

function valiRadio( vForm, vAction ) {
	vContI = 0;
	for ( var i = 0; i < vForm.seleccion.length; i++) {
		if (vForm.seleccion[i].checked)
			vContI++;
	}
	if ( vContI<=0 ) {
		alert('Debe marcar un usuario');
		return false;
	} else {
		fSubmit( vAction );
		return true;
	}
}

function fSubmit( vAction ) {
	window.document.vForm.action = vAction;
	window.document.vForm.submit();
}

function validar(vForm, vAction)
{
	fSubmit (vAction);
}

function validarCheckbox( vForm, vAction ) {

	vContI = 0;
	for ( var i = 0; i < window.document.vForm.elements.length; i++) {
		if ( window.document.vForm.elements[i].type == "radio" && window.document.vForm.elements[i].value!="null") {
			vContI++;
		}
	}
	if ( vContI<=0 ) {
		alert('Debe marcar un usuario');
		return false;
	} else {
		fInicialPag();
		fSubmit( vAction );
		return true;
	}
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
<form name="vForm" method="post">
<input type="hidden" name="boton" id="boton">
<input type="hidden" name="cChecked" id="cChecked" value="">
<input type="hidden" name="cNombre" id="cNombre" value="">
<input type="hidden" name="cIdentificador" id="cIdentificador" value="">
<input type="hidden" name="cRol" id="cRol" value="">
<table width="550" height="20" border="0" align="center">
      <tr>
        <td width="365" class="style9">&nbsp;Identificador(Usuario) 
       <label>
       <input type="text" name="identificador" id="identificador" size="15">
      </label></td>
        <td width="65"><input type="button" align="middle"
			class="style9" name="consultar" id="consultar" value="Consultar"
			OnClick="validar(window.document.vForm, 'BuscadorUsuarioServlet');">
		</td>
		<td width="65"><input type="reset" align="middle" class="style9"
			name="limpiar" id="limpiar" value="Limpiar"></td>
      </tr>
<tr>
<td>&nbsp;</td>
</tr>
	  <tr>
		<td colspan="3" class="style9" align="center">
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
    </table>
<table width="530" height="170" border="0" align="center">
        <tr>
          <td width="295" bgcolor="#274069"><div align="center" class="style3">Nombre</div>
		  </td>
		  <td  width="100" bgcolor="#274069"><div align="center" class="style3">Identificador(Usuario)</div>
		  </td>
		   <td width="200" bgcolor="#274069"><div align="center" class="style3">Rol</div>
		  </td>
		  <td  width='110' bgcolor="#274069"><div align="center" class="style3">Seleccione<br></div>
		  </td>	
	    </tr>
		<!--AQUI VA EL CODIGO JAVA  -->
	    <%
			ArrayList lista = (ArrayList) request.getAttribute("lista");
			int vRowNumTotal = 1;
			int vRowNumIni = 1;
			if (request.getParameter("vRowNumIni")!=null) vRowNumIni = Integer.parseInt(request.getParameter("vRowNumIni"));	
		    if(lista != null){
				session.setAttribute("lista", lista);
			  			int i;
						String vSeleccion = "";
			  			for (i = 0; i < lista.size(); i++) {
			  				UsuarioControl usu = (UsuarioControl) lista.get(i);
							if (request.getParameter("seleccion"+((vRowNumIni-1)+i)+"_chek")!=null && !request.getParameter("seleccion"+((vRowNumIni-1)+i)+"_chek").equals("null")) {
								vSeleccion = "checked";
							}
		%>
			<tr>
			<td width="295" id ='nombreusuario' bgcolor='#E2E2E2' class="style9"><%=usu.getNombreusuario()%></td>
			<td width="100" id ='identificador' bgcolor='#E2E2E2' class="style9"><%=usu.getIdentificador()%></td>
			<td width="200" id ='rol' bgcolor='#E2E2E2' class="style9"><%=usu.getRol()%></td>
			<td width='110' bgcolor='#E2E2E2' class='style4'><div align='center'><label></label><label><input type='radio' name='seleccion' value='<%=usu.getIdusuario()%>' <%=vSeleccion%> Onclick="valorCheck(this, '<%=usu.getNombreusuario()%>', '<%=usu.getIdentificador()%>', '<%=usu.getRol()%>');"></label></div></td>
			</tr>
		<%
			}
					
			for(int k = 10 - i; k > 0; k--)
			{%>
			<tr>
			<td width="295" bgcolor='#E2E2E2' class="style9"></td>
			<td width="100" bgcolor='#E2E2E2' class="style9"></td>
			<td width="200" bgcolor='#E2E2E2' class="style9"></td>
			<td width='110' bgcolor='#E2E2E2' class='style4'><div align='center'><label></label><label><input type='hidden' name='seleccion' value=''></label></div>&nbsp;</td>
			</tr>
			<%}
					
			}
			else {
				for (int i = 0; i < 10; i++) {%>
			<tr>
			<td width="295" bgcolor='#E2E2E2'></td>
			<td width="100" bgcolor='#E2E2E2'></td>
			<td width="200" bgcolor='#E2E2E2'></td>
			<td width='110' bgcolor='#E2E2E2' class='style4'><div align='center'><label></label><label><input type="hidden" name='seleccion' value=''></label></div>&nbsp;</td>
			</tr>
			<% 
			}
			}
			%>
</table>
<p>&nbsp;</p>
<!-- Inicio Paginación -->
<table width="200" border="0" align="center">
<tr>
		<td>
		<script type="text/javascript">
			function fPaginacion( vAction, vRowNumTotal, vRowNumIni, vMaxRow, vFila ) {
				window.document.vForm.vRowNumTotal.value= vRowNumTotal;
				window.document.vForm.vRowNumIni.value= vRowNumIni;
				window.document.vForm.vMaxRow.value= vMaxRow;
				window.document.vForm.vFila.value= vFila;
				fSubmit( vAction );
				return true;
			}
	
			function fInicialPag() {
				//window.document.vForm.vRowNumTotal.value= 1;
				window.document.vForm.vRowNumIni.value= 1;
				window.document.vForm.vMaxRow.value= 10;
				window.document.vForm.vFila.value= 1;
				for ( var i = 0; i < window.document.vForm.elements.length; i++) {
					if (window.document.vForm.elements[i].className == "checked") {
						window.document.vForm.elements[i].value = "null";
					}
				}
				//fSubmit();
				return true;
			}
		</script>
		<p><font face="Verdana" size="1"> 
<%
	//int 	vRowNumTotal = 1;
	//int 	vRowNumIni = 1;
	int 	vMaxRow = 10;
	int 	vFila = 1;
	
	
	if (request.getParameter("vRowNumTotal")!=null) vRowNumTotal = Integer.parseInt(request.getParameter("vRowNumTotal"));	
	if (request.getParameter("vRowNumIni")!=null) vRowNumIni = Integer.parseInt(request.getParameter("vRowNumIni"));	
	if (request.getParameter("vMaxRow")!=null) vMaxRow = Integer.parseInt(request.getParameter("vMaxRow"));	
	if (request.getParameter("vFila")!=null) vFila = Integer.parseInt(request.getParameter("vFila"));
	
%>
		<input type="hidden" name="vRowNumTotal" id="vRowNumTotal" value="<%=vRowNumTotal%>">
		<input type="hidden" name="vRowNumIni" id="vRowNumIni" value="<%=vRowNumIni%>">
		<input type="hidden" name="vMaxRow" id="vMaxRow" value="<%=vMaxRow%>">
		<input type="hidden" name="vFila" id="vFila" value="<%=vFila%>">
		<%	
		if (lista != null) {
			if(lista.size() != 0){
			UsuarioControl usu 	= (UsuarioControl) lista.get(0);
			vRowNumTotal 	= Integer.parseInt(usu.getCantRow());
			//vFila 			= Integer.parseInt(cedu.getFila());
			}
		}
		
		float temp = (float) vRowNumTotal / vMaxRow;
		
		float pDecimal = temp - ((int)temp);
		
		int pEntera = ((int)temp);
		
		int vCantI;
		
		if(pDecimal > 0){
			vCantI = pEntera + 1;
		}else{
			vCantI = pEntera;
		}
		
		if (vCantI > 1) {
			if (1 < vFila) {
		%>
				<a href="javascript:fPaginacion( 'BuscadorUsuarioServlet', <%=vRowNumTotal%>, <%=(vRowNumIni-vMaxRow)%>, <%=vMaxRow%>, <%=vFila-1%> );">&lt;Anterior</a> 
			<%
			} else {
				%>
				<a nohref DISABLED>&lt;Anterior</a> 
			<%	
			}
			for (int vContI = 1; vContI <= vCantI; vContI++) {
			%> 
				<a href="javascript:fPaginacion( 'BuscadorUsuarioServlet', <%=vRowNumTotal%>, <%=(((vContI*vMaxRow)-vMaxRow)+1)%>, <%=vMaxRow%>, <%=vContI%> );"><%=vContI%></a> 
			<%
			}
			if (vCantI>vFila) {
			%> 
				<a href="javascript:fPaginacion( 'BuscadorUsuarioServlet', <%=vRowNumTotal%>, <%=(vRowNumIni+vMaxRow)%>, <%=vMaxRow%>, <%=vFila+1%> );">siguiente&gt;</a>
			<%
			}else {
				%>
				<a nohref DISABLED>Siguiente&gt;</a> 
			<%	
			}
			%>
			</font></p>
		<%
		}
		%>
		</td>
</tr>
</table>
<p>&nbsp;</p>
<!-- Fin Paginación -->
<table width="200" border="0" align="center">
	<tr>
		<td>
		<div align="center"><label><input type="button" name="Modificar" id="Modificar" class="style9" value="Modificar" 	Onclick="window.document.vForm.boton.value='Modificar'; valiRadio( window.document.vForm, 'modUsuarioViewForm.jsp');"> </label></div>
	</td>
	<td>
		<div align="center"><label><input type="button" name="Eliminar" id="Eliminar"  class="style9"  value="Eliminar" 	Onclick="window.document.vForm.boton.value='Eliminar'; valiRadio( window.document.vForm, 'eliUsuarioViewForm.jsp');"> </label></div>
		</td>
	</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>
