<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>MENU</title>
</head>
<body>
	<nav id= "menu" align="center">
		<ul>
			<li><a href="index">Home</a>
			<li><a href="notas">Inserir Notas</a>
			<li><a href="faltas">Inserir Faltas</a>
			<li><a href="relatorio">Gerar Relatórios</a>
		</ul>
	</nav>
</body>
</html>