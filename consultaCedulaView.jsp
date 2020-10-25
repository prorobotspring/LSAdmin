<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="ve.com.digitel.lsadmin.jb.HistoricoCliente"%>
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
	String vDesde = "";
	String vHasta = "";
	if ( ( ( String ) request.getMethod() ).compareTo( "POST" )==0 ) {
		vDesde = request.getParameter("desde");
		vHasta = request.getParameter("hasta");
		if (vDesde == null)
			vDesde = "";
		if (vHasta == null)
			vHasta = "";
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Consulta Cliente</title>
<link rel="stylesheet" href="css/calendar-blue.css" type="text/css">
<script type="text/javascript" src="js/calendar.js"></script>
<script type="text/javascript" src="js/calendar-es.js"></script>
<script type="text/javascript" src="js/calendar-setup.js"></script>
<script type="text/javascript">

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
<table width="60%" border="0" align="center">
	<tr>
		<td width="28%" class="style9">
		<div align="left">
		<p><label>Cédula <input type="text" name="cedula"
			id="cedula" size="10"></label></p>
		</div>
		</td>
		<td width="32%" class="style9">
		<div align="left">
		<p><label>Status <select name="status" id="status"
			class="style9">
			<option value="0" class="style9" selected="selected">Todos</option>
			<option value="1" class="style9">Nuevo</option>
			<option value="2" class="style9">Aprobado</option>
			<option value="3" class="style9">Rechazado</option>
			<option value="4" class="style9">Reevaluar</option>
			<option value="5" class="style9">Fecha Inválida</option>
		</select> </label></p>
		</div>
		</td>
		<td width="22%"><input type="button" align="middle" 
			class="style9" name="consultar" id="consultar" value="Consultar"
			OnClick="validar( window.document.vForm, 'BuscadorHistoricoCedulasServlet' );">
		</td>
	</tr>
	<tr>
		<td width="28%" class="style9">
		<div align="left">
		<p><label>Desde&nbsp;&nbsp;<input type="text" name="desde" id="desde" readonly="readonly" size="10" value="<%=vDesde%>"> 
		<a href="#"
			id="load_fecha_nacimiento"><img src="imagenes/calendar.gif"
			alt="Calendario" title="Calendario" /></a> <script
			type="text/javascript"> 
      	Calendar.setup({inputField:"desde", ifFormat:"%d/%m/%Y", button:"load_fecha_nacimiento"});
     	</script> </label></p>
		</div>
		</td>
		<td width="31%" class="style9">
		<label>Hasta&nbsp;&nbsp;<input type="text" name="hasta" id="hasta" readonly="readonly" size="10" value="<%=vHasta%>">
		<a href="#" id="fecha_nacimiento"><img src="imagenes/calendar.gif"
			alt="Calendario" title="Calendario" /></a> <script
			type="text/javascript"> 
      	Calendar.setup({inputField:"hasta", ifFormat:"%d/%m/%Y", button:"fecha_nacimiento"});
     	</script> </label></td>
		<td width="22%"><input type="button" align="middle" 
			class="style9" name="limpiar" id="limpiar" value="Limpiar"
			OnClick="window.location.href='consultaCedulaView.jsp'"></td>
	</tr>
</table>
<p align="center">&nbsp;</p>

<table width="450" height="170" border="0" align="center">
	<tr>
		<td bgcolor="#274069">
		<div align="center" class="style3">Cédula</div>
		</td>
		<td bgcolor="#274069">
		<div align="center" class="style3">Fecha Actualizado</div>
		</td>
		<td bgcolor="#274069">
		<div align="center" class="style3">Status</div>
		</td>
	</tr>
	<%
		ArrayList lista = (ArrayList) request.getAttribute("lista");
		int vRowNumTotal = 1;
		int vRowNumIni = 1;

		if (request.getParameter("vRowNumIni") != null)
			vRowNumIni = Integer.parseInt(request
					.getParameter("vRowNumIni"));

		if (lista != null) {
			int i;

			String vSeleccion = "";

			for (i = 0; i < lista.size(); i++) {
				HistoricoCliente hist = (HistoricoCliente) lista.get(i);
	%>
	<tr>
		<td id='cedula' bgcolor='#E2E2E2' class="style9"><%=hist.getCedula()%></td>
		<td id='fnacimiento' bgcolor='#E2E2E2' class="style9"><%=hist.getFechaActualizado()%></td>
		<td id='estatus' bgcolor='#E2E2E2' class="style9"><%=hist.getStatus()%></td>
	</tr>
	<%
		vRowNumTotal = Integer.parseInt(hist.getCantRow());
			}

			for (int k = 10 - i; k > 0; k--) {
	%>
	<tr>
		<td bgcolor='#E2E2E2' class="style9">&nbsp;</td>
		<td bgcolor='#E2E2E2' class="style9">&nbsp;</td>
		<td bgcolor='#E2E2E2' class="style9">&nbsp;</td>
	</tr>
	<%
		}
			request.setAttribute("lista", lista);
		} else {
			for (int i = 0; i < 10; i++) {
	%>
	<tr>
		<td bgcolor='#E2E2E2'>&nbsp;</td>
		<td bgcolor='#E2E2E2'>&nbsp;</td>
		<td bgcolor='#E2E2E2'>&nbsp;</td>
	</tr>
	<%
		}
		}
	%>
</table>

<p>&nbsp;</p>
<!-- Inicio PaginaciÃ³n -->
<table width="200" border="0" align="center">
	<tr>
		<td><script type="text/javascript">
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
				
				//fSubmit();
				return true;
			}
		</script>
		<p><font face="Verdana" size="1"> <%
 	//int 	vRowNumTotal = 1;
 	//int 	vRowNumIni = 1;
 	int vMaxRow = 10;
 	int vFila = 1;

 	//if (request.getParameter("vRowNumTotal")!=null) vRowNumTotal = Integer.parseInt(request.getParameter("vRowNumTotal"));	
 	//if (request.getParameter("vRowNumIni")!=null) vRowNumIni = Integer.parseInt(request.getParameter("vRowNumIni"));	
 	if (request.getParameter("vMaxRow") != null)
 		vMaxRow = Integer.parseInt(request.getParameter("vMaxRow"));
 	if (request.getParameter("vFila") != null)
 		vFila = Integer.parseInt(request.getParameter("vFila"));

 %> <input type="hidden" name="vRowNumTotal" id="vRowNumTotal"
			value="<%=vRowNumTotal%>"> <input type="hidden"
			name="vRowNumIni" id="vRowNumIni" value="<%=vRowNumIni%>"> <input
			type="hidden" name="vMaxRow" id="vMaxRow" value="<%=vMaxRow%>">
		<input type="hidden" name="vFila" id="vFila" value="<%=vFila%>">
		<%
			if (lista != null) {
				if (lista.size() != 0) {
					HistoricoCliente hist = (HistoricoCliente) lista.get(0);
					vRowNumTotal = Integer.parseInt(hist.getCantRow());
					//vFila 			= Integer.parseInt(hist.getFila());
				}
			}
			float temp = (float) vRowNumTotal / vMaxRow;

			float pDecimal = temp - ((int) temp);

			int pEntera = ((int) temp);

			int vCantI;

			if (pDecimal > 0) {
				vCantI = pEntera + 1;
			} else {
				vCantI = pEntera;
			}

			if (vCantI > 1) {
				if (1 < vFila) {
		%> <a
			href="javascript:fPaginacion( 'BuscadorHistoricoCedulasServlet', <%=vRowNumTotal%>, <%=(vRowNumIni-vMaxRow)%>, <%=vMaxRow%>, <%=vFila-1%> );">&lt;Anterior</a>
		<%
			} else {
		%> <a nohref DISABLED>&lt;Anterior</a> <%
 	}
 		for (int vContI = 1; vContI <= vCantI; vContI++) {
 %> <a
			href="javascript:fPaginacion( 'BuscadorHistoricoCedulasServlet', <%=vRowNumTotal%>, <%=(((vContI*vMaxRow)-vMaxRow)+1)%>, <%=vMaxRow%>, <%=vContI%> );"><%=vContI%></a>
		<%
			}
				if (vCantI > vFila) {
		%> <a
			href="javascript:fPaginacion( 'BuscadorHistoricoCedulasServlet', <%=vRowNumTotal%>, <%=(vRowNumIni+vMaxRow)%>, <%=vMaxRow%>, <%=vFila+1%> );">siguiente&gt;</a>
		<%
			} else {
		%> <a nohref DISABLED>Siguiente&gt;</a> <%
 	}
 %> </font></p>
		<%
			}
		%>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
<!-- Fin Paginacion -->
</form>
</td>
</tr>
</table>
</body>
</html>