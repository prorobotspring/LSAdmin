<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import="ve.com.digitel.lsadmin.jb.Cedulado"%>
<%@ page import="java.util.ArrayList"%>
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
	String vDesde = "";
	String vHasta = "";
	String vCheck = "";
		
		vDesde = request.getParameter( "desde" );
		vHasta = request.getParameter( "hasta" );
		if (vDesde==null) vDesde = "";
		if (vHasta==null) vHasta = "";
		if (vCheck == null)vCheck = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cédulas a evaluar</title>
 <link rel="stylesheet" href="css/calendar-blue.css" type="text/css">
 <script type="text/javascript" src="js/calendar.js"></script>
 <script type="text/javascript" src="js/calendar-es.js"></script>
 <script type="text/javascript" src="js/calendar-setup.js"></script>
<script type="text/javascript">

	function valorCheck(vThis) {
		//alert(vThis.name);
		if (vThis.checked==true)
			window.document.vForm.elements[vThis.name+"_chek"].value = vThis.value;
		else
			window.document.vForm.elements[vThis.name+"_chek"].value = "null";
	}

	function ChequearTodos(chkbox) {
		for ( var i = 0; i < window.document.vForm.elements.length; i++) {
			if (window.document.vForm.elements[i].type == "checkbox" && window.document.vForm.elements[i].name!="seleccionTotal") {
				if (window.document.vForm.elements[i].value!="on" && window.document.vForm.seleccionTotal.checked==true) {
					window.document.vForm.elements[i].checked = true;
					valorCheck(window.document.vForm.elements[i].value);
				} else {
					window.document.vForm.elements[i].checked = false;
				}
			}
		}
	}

	function validar(vForm, vAction) {
		if (((vForm.desde.value == "") && (vForm.hasta.value != "")) || ((vForm.desde.value != "") && (vForm.hasta.value == ""))) {
			alert("Debe ingresar ambas fechas para realizar la búsqueda");
			return false;
		} else {
			fInicialPag();
			fSubmit( vAction );
			return true;
		}
	}

	function fSubmit( vAction ) {
		window.document.vForm.action = vAction;
		window.document.vForm.submit();
	}
	
	function validarCheckbox( vForm, vAction ) {
		vContI = 0;
		vCedula = "";
		valorCheck = "";
		for ( var i = 0; i < window.document.vForm.elements.length; i++) {
			if ( window.document.vForm.elements[i].className == "checked" && window.document.vForm.elements[i].value!="null") {
				vContI++;
				valorCheck = valorCheck + "|" + window.document.vForm.elements[i].value;
			}
		}
		valorCheck = valorCheck;
		window.document.vForm.cChecked.value = valorCheck;
		if ( vContI<=0 ) {
			alert('Debe marcar al menos un checkbox');
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
<form name="vForm" method="post">
<input type="hidden" name="boton" id="boton">
<input type="hidden" name="cChecked" id="cChecked" value="">
<table  width="60%" border="0" align="center">
	<tr>
		<td width="32%" class="style9">
		<div align="left">
		<p><label>Desde <input type="text" name="desde" id="desde" size="10" readonly="readonly">
		<a href="#" id="load_fecha_nacimiento"><img src="imagenes/calendar.gif" alt="Calendario" title="Calendario"/></a>
     	<script type="text/javascript"> 
      	Calendar.setup({inputField:"desde", ifFormat:"%d/%m/%Y", button:"load_fecha_nacimiento"});
     	</script> </label></p>
		</div>
		</td>
		<td width="31%" class="style9"><label>Hasta <input type="text" name="hasta" id="hasta" size="10" readonly="readonly">
		<a href="#" id="fecha_nacimiento"><img src="imagenes/calendar.gif" alt="Calendario" title="Calendario"/></a>
     	<script type="text/javascript"> 
      	Calendar.setup({inputField:"hasta", ifFormat:"%d/%m/%Y", button:"fecha_nacimiento"});
     	</script>
		</label></td>
		<td width="15%"><input type="button" align="middle" class="style9" name="consultar" id="consultar" value="Consultar" OnClick="validar( window.document.vForm, 'BuscadorCedulasRechazadasServlet' );">
		</td>
		<td width="22%">
			<input type="button" align="middle" class="style9" name="limpiar" id="limpiar" value="Limpiar" OnClick="window.location.href='CedulasRechazablesView.jsp'">
		</td>
	</tr>
</table>
<p align="center">&nbsp;</p>
<% 
		/*String vSeleccion = "";
		if((request.getParameter("seleccionTotal")!= null)) {
			//vSeleccion = "checked";
		}*/
		
		%>
<table width="850" height="170" border="0" align="center">
	<tr>
		<td bgcolor="#274069"><div align="center" class="style3">Cédula</div>
		</td>
		<td bgcolor="#274069"><div align="center" class="style3">Nombre</div>
		</td>
		<td bgcolor="#274069"><div align="center" class="style3">Fecha de Solicitud</div>
		</td>
		<td bgcolor="#274069"><div align="center" class="style3">Fecha de Nacimiento</div>
		</td>
		<td bgcolor="#274069"><div align="center" class="style3">Estatus</div>
		</td>
		<td bgcolor="#274069"><div align="center" class="style3"><label>
			Seleccione<br>
		 </label></div>
		</td>
	</tr>
	<%
		ArrayList lista = (ArrayList) request.getAttribute("lista");
		int vRowNumTotal = 1;
		int vRowNumIni = 1;
		if (request.getParameter("vRowNumIni")!=null) vRowNumIni = Integer.parseInt(request.getParameter("vRowNumIni"));	
		if (lista != null) {
			int i;
			String vSeleccion = "";
			for (i = 0; i < lista.size(); i++) {
				Cedulado cedu = (Cedulado) lista.get(i);
				if (request.getParameter("seleccion"+((vRowNumIni-1)+i)+"_chek")!=null && !request.getParameter("seleccion"+((vRowNumIni-1)+i)+"_chek").equals("null")) {
					vSeleccion = "checked";
				}
	%>
	<tr>
		<td id='cedula' bgcolor='#E2E2E2' class="style9"><%=cedu.getTipo() + "-" + cedu.getCedula()%></td>
		<td id='cedula' bgcolor='#E2E2E2' class="style9"><%=cedu.getNombre()%></td>
		<td id='fnacimiento' bgcolor='#E2E2E2' class="style9"><%=cedu.getFechaSolicitud()%></td>
		<td id='fnacimiento' bgcolor='#E2E2E2' class="style9"><%=cedu.getFechanacimiento()%></td>
		<td id='estatus' bgcolor='#E2E2E2' class="style9"><%=cedu.getEstatus()%></td>
		<td bgcolor='#E2E2E2' class='style4'>
		<div align='center'><label></label><label>
		<input type='checkbox' name='seleccion<%=((vRowNumIni-1)+i)%>' value='<%=cedu.getTipo() + "-" + cedu.getCedula()%>' <%=vSeleccion%> Onclick="valorCheck(this);"></label></div>
		</td>
	</tr>
	<%
			vSeleccion = "";
			vRowNumTotal = Integer.parseInt(cedu.getCantRow());
		}

			for (int k = 10 - i; k > 0; k--) {
	%>
	<tr>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9">&nbsp;</td>
		<td width='110' bgcolor='#E2E2E2' class='style4'>&nbsp;</td>
	</tr>
	<%
		}
			request.setAttribute("lista", lista);
		} else {
			for (int i = 0; i < 10; i++) {
	%>
	<tr>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9"></td>
		<td bgcolor='#E2E2E2' class="style9">&nbsp;</td>
		<td width='110' bgcolor='#E2E2E2' class='style4'>
		<div align='center'><label></label><label>&nbsp;</label></div>
		</td>
	</tr>
	<%
		}
		}
	%>
</table>
<% 
	for (int j=0;j<vRowNumTotal;j++) {
%>
		<input type="hidden" name="seleccion<%=j%>_chek" id="seleccion<%=j%>_chek" class="checked" value="<%=request.getParameter("seleccion"+j+"_chek")%>">
<%
	}
%>
<p>&nbsp;</p>
<!-- Inicio PaginaciÃ³n -->
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
	
	
	//if (request.getParameter("vRowNumTotal")!=null) vRowNumTotal = Integer.parseInt(request.getParameter("vRowNumTotal"));	
	//if (request.getParameter("vRowNumIni")!=null) vRowNumIni = Integer.parseInt(request.getParameter("vRowNumIni"));	
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
			Cedulado cedu 	= (Cedulado) lista.get(0);
			vRowNumTotal 	= Integer.parseInt(cedu.getCantRow());
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
				<a href="javascript:fPaginacion( 'BuscadorCedulasRechazadasServlet', <%=vRowNumTotal%>, <%=(vRowNumIni-vMaxRow)%>, <%=vMaxRow%>, <%=vFila-1%> );">&lt;Anterior</a> 
			<%
			} else {
				%>
				<a nohref DISABLED>&lt;Anterior</a> 
			<%	
			}
			for (int vContI = 1; vContI <= vCantI; vContI++) {
			%> 
				<a href="javascript:fPaginacion( 'BuscadorCedulasRechazadasServlet', <%=vRowNumTotal%>, <%=(((vContI*vMaxRow)-vMaxRow)+1)%>, <%=vMaxRow%>, <%=vContI%> );"><%=vContI%></a> 
			<%
			}
			if (vCantI>vFila) {
			%> 
				<a href="javascript:fPaginacion( 'BuscadorCedulasRechazadasServlet', <%=vRowNumTotal%>, <%=(vRowNumIni+vMaxRow)%>, <%=vMaxRow%>, <%=vFila+1%> );">siguiente&gt;</a>
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
<!-- Fin PaginaciÃ³n -->
<table width="200" border="0" align="center">
	<tr>
		<td>
		<div align="center"><label><input type="button" name="Rechazar" id="Rechazar" class="style9" value="Rechazar" Onclick="validarCheckbox( window.document.vForm, 'RechazarCedulasServlet' ); window.document.vForm.boton.value='Rechazar';"> </label></div>
		</td>
	</tr>
</table>
</form>
</td>
</tr>
</table>
<p align="center">&nbsp;</p>
</body>
</html>