<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inserir faltas</title>
</head>
<body>
	<div>
         <jsp:include page="menu.jsp"></jsp:include>
     </div>
     <br />
     <br />
     <div align="center" class="container">
		<h1><b>Inserindo faltas</b></h1>
	</div>
	<br />
	<div align="center" class="container">
        <form action="faltas" method="post">
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
                 </tr>
                 <tr>
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
                 <tr>
                 	<td>
                 		<select id="falta" name="falta">
                            <option value="0">Número de falta</option>
                            <c:if test="${not empty faltas }">
                                <c:forEach items="${faltas }" var="f">
                                          <option><c:out value="${f }"></c:out></option>
                                </c:forEach>
                            </c:if>           
                    	</select>
                 	</td>
                 </tr>
                 <tr><td><input type="date" id="dataFalta" name="dataFalta"><td></td>
                 <tr><td><input type="text" id="RA" name="RA" placeholder="RA"></td></tr>
                 <tr><td><input type="submit" id="botao" name="botao" value="Inserir"></td></tr>
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