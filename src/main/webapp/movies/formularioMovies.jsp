<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="es.daw.peliculas.model.Movie" %>
<%@ page import="es.daw.peliculas.model.Genre" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario Película</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    Movie movie = (Movie) request.getAttribute("movie");
    boolean esEdicion = movie != null;

    String titulo = esEdicion ? "Actualizar Película" : "Nueva Película";
    String accion = esEdicion ? "update" : "add";
%>
<div class="container mt-5">
    <div class="form-container">
        <h2 class="text-center text-primary mb-4">🎬 <%= titulo %></h2>

        <%
            List<Genre> genres = (List<Genre>) request.getAttribute("genres");
        %>

        <form action="<%=request.getContextPath()%>/movies/<%=accion%>" method="post">

            <% if (esEdicion) { %>
            <div class="mb-3">
                <label for="id" class="form-label">Código de la película</label>
                <input type="text" id="id" name="id" class="form-control"
                       value="<%= movie.getId() %>" readonly>
            </div>
            <% } %>

            <!-- TÍTULO -->
            <div class="mb-3">
                <label for="title" class="form-label">Título de la película *</label>
                <input type="text" id="title" name="title" class="form-control"
                       required placeholder="Ej: Matrix"
                       value="<%= esEdicion ? movie.getTitle() : "" %>">
            </div>

            <!-- DIRECTOR - ✅ CORREGIDO: id y name eran "title" -->
            <div class="mb-3">
                <label for="director" class="form-label">Nombre del director *</label>
                <input type="text" id="director" name="director" class="form-control"
                       required placeholder="Ej: Wachowski"
                       value="<%= esEdicion ? movie.getDirector() : "" %>">
            </div>

            <!-- AÑO DE ESTRENO -->
            <div class="mb-3">
                <label for="releaseYear" class="form-label">Año de estreno *</label>
                <input type="number" id="releaseYear" name="releaseYear"
                       class="form-control" required min="1900" max="2100"
                       value="<%= esEdicion ? movie.getReleaseYear() : "" %>">
            </div>

            <!-- DURACIÓN - ✅ AÑADIDO: faltaba este campo -->
            <div class="mb-3">
                <label for="duration" class="form-label">Duración (minutos) *</label>
                <input type="number" id="duration" name="duration"
                       class="form-control" required min="1"
                       placeholder="Ej: 136"
                       value="<%= esEdicion ? movie.getDuration() : "" %>">
            </div>

            <!-- GÉNERO - ✅ CORREGIDO: id y name eran "author_id" -->
            <div class="mb-3">
                <label for="genreId" class="form-label">Género *</label>
                <select id="genreId" name="genreId" class="form-select" required>
                    <option value="">-- Selecciona un género --</option>
                    <%
                        if (genres != null && !genres.isEmpty()) {
                            for (Genre g : genres) {
                                boolean seleccionado = false;
                                if (esEdicion && movie.getGenreId() != null) {
                                    seleccionado = g.getId().equals(movie.getGenreId());
                                }
                    %>
                    <option value="<%= g.getId() %>" <%= seleccionado ? "selected" : "" %>>
                        <%= g.getName() %>
                    </option>
                    <%
                        }
                    } else {
                    %>
                    <option disabled>No hay géneros disponibles</option>
                    <% } %>
                </select>
            </div>

            <!-- PUNTUACIÓN - ✅ AÑADIDO: faltaba este campo -->
            <div class="mb-3">
                <label for="rating" class="form-label">Puntuación *</label>
                <input type="number" id="rating" name="rating"
                       class="form-control" required step="0.1" min="0" max="10"
                       placeholder="Ej: 8.7"
                       value="<%= esEdicion ? movie.getRating() : "" %>">
            </div>

            <hr class="my-4">

            <div class="d-flex justify-content-between">
                <a href="<%= request.getContextPath() %>/movies/list" class="btn btn-secondary">
                    ⬅️ Cancelar
                </a>
                <button type="submit" class="btn btn-success">
                    💾 <%= esEdicion ? "Actualizar" : "Guardar" %> película
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
