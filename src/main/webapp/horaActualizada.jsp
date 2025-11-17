<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hora Actualizada</title>
    <%-- ✅ Auto-refresh cada 1 segundo --%>
    <meta http-equiv="refresh" content="1">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 3rem;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 2rem;
        }
        .time {
            font-size: 4rem;
            font-weight: bold;
            letter-spacing: 0.1em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>⏰ Hora Actualizada</h1>

    <%
        LocalTime hora = LocalTime.now();
        DateTimeFormatter df = DateTimeFormatter.ofPattern("HH:mm:ss");
        String horaFormateada = hora.format(df);
    %>

    <div class="time">
        <%= horaFormateada %>
    </div>

    <p style="margin-top: 2rem; opacity: 0.8;">
        Se actualiza automáticamente cada segundo
    </p>
</div>
</body>
</html>
