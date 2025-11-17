<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cabeceras HTTP Request</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="mb-4">Cabeceras HTTP Request</h1>
    <ul class="list-group mb-4">
        <li class="list-group-item">Método HTTP: <strong><%= request.getMethod() %></strong></li>
        <li class="list-group-item">Request URI: <strong><%= request.getRequestURI() %></strong></li>
        <li class="list-group-item">Request URL: <strong><%= request.getRequestURL().toString() %></strong></li>
        <li class="list-group-item">Context Path: <strong><%= request.getContextPath() %></strong></li>
        <li class="list-group-item">Servlet Path: <strong><%= request.getServletPath() %></strong></li>
        <li class="list-group-item">IP local: <strong><%= request.getLocalAddr() %></strong></li>
        <li class="list-group-item">IP cliente: <strong><%= request.getRemoteAddr() %></strong></li>
        <li class="list-group-item">Puerto local: <strong><%= request.getLocalPort() %></strong></li>
        <li class="list-group-item">Scheme: <strong><%= request.getScheme() %></strong></li>
        <li class="list-group-item">Host: <strong><%= request.getHeader("host") %></strong></li>
    </ul>
    <h4>Headers HTTP:</h4>
    <ul class="list-group">
        <%
            java.util.Enumeration<String> headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String name = headerNames.nextElement();
                String value = request.getHeader(name);
        %>
        <li class="list-group-item"><strong><%= name %></strong>: <%= value %></li>
        <%
            }
        %>
    </ul>
</div>
</body>
</html>
