<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gerar Relatório</title>
</head>
<body>
	<div>
         <jsp:include page="menu.jsp"></jsp:include>
     </div>
     <br />
     <br />
     <div align="center" class="container">
		<h1><b>Gerando Relatórios</b></h1>
	</div>
	<br />
	<div align="center" class="container">
        <form action="notas" method="post">
        	<table>
                 <tr>
                 	<td>
                 		<select id="disciplina" name="disciplina">
                            <option value="0">disciplina</option>
                            <c:if test="${not empty disciplinas }">
                                <c:forEach items="${disciplinas }" var="d">
                                          <option><c:out value="${d.nome }"></c:out></option>
                                </c:forEach>
                            </c:if>           
                    	</select>
                 	</td>
                 	<td>
                 		<select id="turno" name="turno">
                            <option value="0">turno</option>
                            <c:if test="${not empty turnos }">
                                <c:forEach items="${turnos }" var="a">
                                          <option><c:out value="${a }"></c:out></option>
                                </c:forEach>
                            </c:if>           
                    	</select>
                 	</td>
                 	</tr>
                 	<tr><td><input type="submit" id="botao" name="botao" value="Faltas"></td></tr>
                 	<tr><td><input type="submit" id="botao" name="botao" value="Notas"></td></tr>
            </table>  
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro } ">
			<H2><c:out value="${erro }"  /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida } ">
			<H3><c:out value="${saida }"  /></H3>
		</c:if>
	</div>
</body>
</html>