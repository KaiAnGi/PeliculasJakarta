<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema Manager - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .hero-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .hero-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }
        .hero-header h1 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .hero-body {
            padding: 2rem;
        }
        .feature-card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .btn-custom {
            border-radius: 50px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s;
        }
        .user-badge {
            background: rgba(102, 126, 234, 0.1);
            padding: 1rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="hero-container">
                <!-- Header -->
                <div class="hero-header">
                    <h1>🎬 Cinema Manager</h1>
                    <p class="mb-0">Tu plataforma de gestión de películas</p>
                </div>

                <!-- Body -->
                <div class="hero-body">
                    <%
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                    %>
                    <!-- Usuario autenticado -->
                    <div class="user-badge text-center">
                        <h4 class="mb-0">
                            <i class="bi bi-person-circle"></i>
                            Bienvenido, <strong><%= username %></strong>
                        </h4>
                    </div>

                    <div class="row g-4 mb-4">
                        <!-- Películas -->
                        <div class="col-md-6">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-primary">
                                    <i class="bi bi-film"></i>
                                </div>
                                <h5 class="card-title">Gestión de Películas</h5>
                                <p class="card-text text-muted">
                                    Administra tu catálogo completo de películas
                                </p>
                                <a href="<%= request.getContextPath() %>/movies/list"
                                   class="btn btn-primary btn-custom">
                                    <i class="bi bi-arrow-right-circle"></i> Ir a Películas
                                </a>
                            </div>
                        </div>

                        <!-- Cabeceras -->
                        <div class="col-md-6">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-info">
                                    <i class="bi bi-code-square"></i>
                                </div>
                                <h5 class="card-title">Cabeceras HTTP</h5>
                                <p class="card-text text-muted">
                                    Información técnica de la petición
                                </p>
                                <a href="<%= request.getContextPath() %>/cabeceras-request"
                                   class="btn btn-info btn-custom">
                                    <i class="bi bi-eye"></i> Ver Cabeceras
                                </a>
                            </div>
                        </div>

                        <!-- Hora -->
                        <div class="col-md-6">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-success">
                                    <i class="bi bi-clock"></i>
                                </div>
                                <h5 class="card-title">Hora en Tiempo Real</h5>
                                <p class="card-text text-muted">
                                    Reloj actualizado automáticamente
                                </p>
                                <a href="<%= request.getContextPath() %>/hora-actualizada"
                                   class="btn btn-success btn-custom">
                                    <i class="bi bi-stopwatch"></i> Ver Hora
                                </a>
                            </div>
                        </div>

                        <!-- Logout -->
                        <div class="col-md-6">
                            <div class="card feature-card text-center p-4 bg-light">
                                <div class="feature-icon text-danger">
                                    <i class="bi bi-box-arrow-right"></i>
                                </div>
                                <h5 class="card-title">Cerrar Sesión</h5>
                                <p class="card-text text-muted">
                                    Salir de forma segura
                                </p>
                                <a href="<%= request.getContextPath() %>/logout"
                                   class="btn btn-outline-danger btn-custom">
                                    <i class="bi bi-power"></i> Cerrar Sesión
                                </a>
                            </div>
                        </div>
                    </div>

                    <% } else { %>
                    <!-- Usuario no autenticado -->
                    <div class="text-center mb-4">
                        <i class="bi bi-lock" style="font-size: 4rem; color: #667eea;"></i>
                        <h3 class="mt-3">Acceso Restringido</h3>
                        <p class="text-muted">
                            Inicia sesión para acceder a todas las funcionalidades
                        </p>
                    </div>

                    <div class="row g-4 mb-4">
                        <!-- Login -->
                        <div class="col-md-4">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-primary">
                                    <i class="bi bi-person-check"></i>
                                </div>
                                <h5 class="card-title">Iniciar Sesión</h5>
                                <p class="card-text text-muted">
                                    Accede a tu cuenta
                                </p>
                                <a href="<%= request.getContextPath() %>/login"
                                   class="btn btn-primary btn-custom">
                                    <i class="bi bi-box-arrow-in-right"></i> Login
                                </a>
                            </div>
                        </div>

                        <!-- Cabeceras -->
                        <div class="col-md-4">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-info">
                                    <i class="bi bi-code-square"></i>
                                </div>
                                <h5 class="card-title">Cabeceras HTTP</h5>
                                <p class="card-text text-muted">
                                    Acceso público
                                </p>
                                <a href="<%= request.getContextPath() %>/cabeceras-request"
                                   class="btn btn-info btn-custom">
                                    <i class="bi bi-eye"></i> Ver
                                </a>
                            </div>
                        </div>

                        <!-- Hora -->
                        <div class="col-md-4">
                            <div class="card feature-card text-center p-4">
                                <div class="feature-icon text-success">
                                    <i class="bi bi-clock"></i>
                                </div>
                                <h5 class="card-title">Hora Actual</h5>
                                <p class="card-text text-muted">
                                    Acceso público
                                </p>
                                <a href="<%= request.getContextPath() %>/hora-actualizada"
                                   class="btn btn-success btn-custom">
                                    <i class="bi bi-stopwatch"></i> Ver
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <!-- Footer -->
                    <div class="text-center mt-4 text-muted">
                        <small>
                            <i class="bi bi-info-circle"></i>
                            Cinema Manager v1.0 | Gestión profesional de películas
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
