<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Cinema Manager</title>
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
        .login-container {
            max-width: 450px;
            width: 100%;
        }
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
        }
        .login-header h1 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .login-header p {
            margin: 0;
            opacity: 0.9;
        }
        .login-body {
            padding: 2.5rem;
        }
        .form-floating > label {
            color: #6c757d;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            border-radius: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-back {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .btn-back:hover {
            color: #764ba2;
        }
        .demo-credentials {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.25rem;
            margin-top: 1.5rem;
            border-left: 4px solid #667eea;
        }
        .demo-credentials h6 {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 0.75rem;
        }
        .demo-credentials .credential-item {
            background: white;
            padding: 0.5rem 0.75rem;
            border-radius: 5px;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            pointer-events: none;
        }
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            z-index: 10;
        }
        .password-toggle:hover {
            color: #667eea;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-6">
            <div class="login-container mx-auto">
                <div class="login-card">
                    <!-- Header -->
                    <div class="login-header">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">
                            🎬
                        </div>
                        <h1>Cinema Manager</h1>
                        <p>Inicia sesión para continuar</p>
                    </div>

                    <!-- Body -->
                    <div class="login-body">
                        <!-- Error Alert -->
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <strong>Error:</strong> <%= error %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>

                        <!-- Login Form -->
                        <form action="<%= request.getContextPath() %>/login" method="post">
                            <!-- Username -->
                            <div class="form-floating mb-3 position-relative">
                                <input type="text"
                                       class="form-control"
                                       id="username"
                                       name="username"
                                       placeholder="Usuario"
                                       required
                                       autofocus
                                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                                <label for="username">
                                    <i class="bi bi-person me-2"></i>Usuario
                                </label>
                            </div>

                            <!-- Password -->
                            <div class="form-floating mb-3 position-relative">
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password"
                                       placeholder="Contraseña"
                                       required>
                                <label for="password">
                                    <i class="bi bi-lock me-2"></i>Contraseña
                                </label>
                                <i class="bi bi-eye password-toggle"
                                   id="togglePassword"
                                   ></i>
                            </div>

                            <!-- Remember Me -->
                            <div class="form-check mb-4">
                                <input class="form-check-input"
                                       type="checkbox"
                                       id="remember"
                                       name="remember">
                                <label class="form-check-label" for="remember">
                                    Recordarme
                                </label>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary btn-login w-100 mb-3">
                                <i class="bi bi-box-arrow-in-right me-2"></i>
                                Iniciar Sesión
                            </button>

                            <!-- Back to Home -->
                            <div class="text-center">
                                <a href="<%= request.getContextPath() %>/" class="btn-back">
                                    <i class="bi bi-arrow-left me-1"></i>
                                    Volver al inicio
                                </a>
                            </div>
                        </form>

                        <!-- Demo Credentials -->
                        <div class="demo-credentials">
                            <h6>
                                <i class="bi bi-info-circle me-2"></i>
                                Credenciales de prueba
                            </h6>
                            <div class="credential-item">
                                <i class="bi bi-person-fill-gear text-primary me-2"></i>
                                <strong>Admin:</strong>
                                <code>admin</code> / <code>admin123</code>
                            </div>
                            <div class="credential-item">
                                <i class="bi bi-person-fill text-secondary me-2"></i>
                                <strong>Usuario:</strong>
                                <code>user</code> / <code>user123</code>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="text-center mt-4 text-white">
                    <small>
                        <i class="bi bi-shield-lock"></i>
                        Conexión segura | Cinema Manager v1.0
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
