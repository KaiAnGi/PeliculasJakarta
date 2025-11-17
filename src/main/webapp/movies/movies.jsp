<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="es.daw.peliculas.model.Movie" %>
<%@ page import="es.daw.peliculas.model.Genre" %>
<%@ page import="java.util.List" %>
<%@ page import="es.daw.peliculas.util.Utils" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Películas - Cinema Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .filter-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            background: white;
        }
        .filter-card h5 {
            color: #667eea;
            font-weight: bold;
        }
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .table thead th {
            border: none;
            padding: 1rem;
            font-weight: 600;
        }
        .table tbody tr {
            transition: all 0.3s;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
        }
        .btn-custom-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            transition: all 0.3s;
        }
        .btn-custom-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .badge-rating {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        .btn-action {
            border-radius: 8px;
            padding: 0.4rem 0.8rem;
            transition: all 0.3s;
        }
        .btn-action:hover {
            transform: scale(1.1);
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }
        .empty-state i {
            font-size: 5rem;
            color: #667eea;
            opacity: 0.5;
        }
        .stats-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            display: inline-block;
            font-weight: 600;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-dark navbar-custom mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/">
            <i class="bi bi-film me-2"></i>
            <strong>Cinema Manager</strong>
        </a>
        <div class="d-flex align-items-center">
                <span class="text-white me-3">
                    <i class="bi bi-person-circle me-1"></i>
                    <strong><%= session.getAttribute("username") %></strong>
                </span>
            <a href="<%= request.getContextPath() %>/" class="btn btn-outline-light btn-sm me-2">
                <i class="bi bi-house-door"></i> Inicio
            </a>
            <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-right"></i> Salir
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <%
        List<Movie> movies = (List<Movie>) request.getAttribute("movies");
        List<Genre> genres = (List<Genre>) request.getAttribute("genres");
        String selectedGenre = request.getParameter("genre") != null ? request.getParameter("genre") : "";
        String selectedTitle = request.getParameter("search") != null ? request.getParameter("search") : "";
        String ordenActual = (String) request.getAttribute("ordenActual"); // ✅ Leer orden actual
    %>

    <!-- Header con título, botón añadir y selector de orden -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">
                <i class="bi bi-collection-play text-primary"></i>
                Catálogo de Películas
            </h2>
            <% if (movies != null) { %>
            <span class="stats-badge">
            <i class="bi bi-film me-1"></i>
            <%= movies.size() %> película<%= movies.size() != 1 ? "s" : "" %>
        </span>
            <% } %>
        </div>

        <div class="d-flex gap-2">
            <!-- COOKIE -->
            <form action="<%= request.getContextPath() %>/preferencias" method="post" class="d-flex gap-2">
                <select name="orden" class="form-select">
                    <option value="ASC">A-Z</option>
                    <option value="DESC" selected>Z-A</option>
                </select>
                <button type="submit" class="btn btn-primary">Ordenar</button>
            </form>

            <!-- Botón añadir nueva -->
            <a href="<%= request.getContextPath() %>/movies/add" class="btn btn-custom-primary">
                <i class="bi bi-plus-circle me-2"></i>
                Añadir Nueva Película
            </a>
        </div>
    </div>

    <!-- FILTROS -->
    <div class="filter-card p-4 mb-4">
        <h5 class="mb-3">
            <i class="bi bi-funnel me-2"></i>
            Filtros de Búsqueda
        </h5>
        <form method="get" action="<%= request.getContextPath() %>/movies/list" class="row g-3">
            <!-- Filtro por Género -->
            <div class="col-md-4">
                <label for="genre" class="form-label">
                    <i class="bi bi-tag me-1"></i>
                    Género
                </label>
                <select name="genre" id="genre" class="form-select">
                    <option value="">-- Todos los géneros --</option>
                    <%
                        if (genres != null && !genres.isEmpty()) {
                            for (Genre g : genres) {
                                boolean selected = selectedGenre.equals(String.valueOf(g.getId()));
                    %>
                    <option value="<%= g.getId() %>" <%= selected ? "selected" : "" %>>
                        <%= g.getName() %>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <!-- Filtro por Título -->
            <div class="col-md-5">
                <label for="search" class="form-label">
                    <i class="bi bi-search me-1"></i>
                    Buscar por título
                </label>
                <input type="text" name="search" id="search" class="form-control"
                       placeholder="Escribe el título de la película..."
                       value="<%= selectedTitle %>">
            </div>

            <!-- Botones -->
            <div class="col-md-3 d-flex align-items-end gap-2">
                <button type="submit" class="btn btn-primary flex-fill">
                    <i class="bi bi-search me-1"></i>
                    Buscar
                </button>
                <a href="<%= request.getContextPath() %>/movies/list"
                   class="btn btn-outline-secondary">
                    <i class="bi bi-x-circle"></i>
                </a>
            </div>
        </form>
    </div>

    <!-- Tabla de Películas -->
    <div class="table-container">
        <%
            if (movies != null && !movies.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th scope="col"><i class="bi bi-hash"></i> ID</th>
                    <th scope="col"><i class="bi bi-film"></i> Título</th>
                    <th scope="col"><i class="bi bi-person"></i> Director</th>
                    <th scope="col"><i class="bi bi-calendar"></i> Año</th>
                    <th scope="col"><i class="bi bi-clock"></i> Duración</th>
                    <th scope="col"><i class="bi bi-tag"></i> Género</th>
                    <th scope="col"><i class="bi bi-star-fill"></i> Rating</th>
                    <th scope="col" class="text-center"><i class="bi bi-gear"></i> Acciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Movie m : movies) {
                        String nombreGen = Utils.obtenerNombreGenero(genres, m.getGenreId());
                %>
                <tr>
                    <td><strong>#<%= m.getId() %></strong></td>
                    <td><strong><%= m.getTitle() %></strong></td>
                    <td><%= m.getDirector() %></td>
                    <td><%= m.getReleaseYear() %></td>
                    <td><%= m.getDuration() %> min</td>
                    <td>
                            <span class="badge bg-info">
                                <%= nombreGen %>
                            </span>
                    </td>
                    <td>
                            <span class="badge-rating">
                                <i class="bi bi-star-fill me-1"></i>
                                <%= m.getRating() %>
                            </span>
                    </td>
                    <td class="text-center">
                        <div class="btn-group" role="group">
                            <!-- Editar -->
                            <form action="<%= request.getContextPath() %>/movies/update"
                                  method="get"
                                  style="display: inline;">
                                <input type="hidden" name="id" value="<%= m.getId() %>">
                                <button type="submit"
                                        class="btn btn-warning btn-sm btn-action"
                                        title="Editar película">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                            </form>

                            <!-- Eliminar -->
                            <form action="<%= request.getContextPath() %>/movies/delete"
                                  method="post"
                                  style="display: inline;"
                                  onsubmit="return confirm('¿Estás seguro de eliminar la película: <%= m.getTitle() %>?');">
                                <input type="hidden" name="id" value="<%= m.getId() %>">
                                <button type="submit"
                                        class="btn btn-danger btn-sm btn-action"
                                        title="Eliminar película">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <!-- Estado vacío -->
        <div class="empty-state">
            <i class="bi bi-film"></i>
            <h4 class="mt-3 text-muted">No hay películas disponibles</h4>
            <p class="text-muted">
                No se encontraron películas con los filtros seleccionados.
            </p>
            <a href="<%= request.getContextPath() %>/movies/list"
               class="btn btn-outline-primary mt-3">
                <i class="bi bi-arrow-clockwise me-2"></i>
                Limpiar filtros
            </a>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

