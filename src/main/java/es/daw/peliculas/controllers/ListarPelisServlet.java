package es.daw.peliculas.controllers;

import es.daw.peliculas.model.Genre;
import es.daw.peliculas.model.Movie;
import es.daw.peliculas.repository.DBConnection;
import es.daw.peliculas.repository.GenericDAO;
import es.daw.peliculas.repository.GenreDAO;
import es.daw.peliculas.repository.MovieDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "ListarPelisServlet", value = "/movies/list")
public class ListarPelisServlet extends HttpServlet {
    private static final Logger log = Logger.getLogger(ListarPelisServlet.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        List<Movie> movies = new ArrayList<>();
        List<Genre> genres = new ArrayList<>();

        try {
            MovieDAO daoM = new MovieDAO();
            GenericDAO<Genre, Integer> daoG = new GenreDAO();

            // FILTROS
            String genreIdParam = request.getParameter("genre");
            String searchTitle = request.getParameter("search");

            Long genreId = null;
            if (genreIdParam != null && !genreIdParam.trim().isEmpty()) {
                genreId = Long.parseLong(genreIdParam);
            }

            if (searchTitle != null && searchTitle.trim().isEmpty()) {
                searchTitle = null;
            }

            movies = daoM.findByFilters(genreId, searchTitle);
            genres = daoG.findAll();

            // COOKIE
            String orden = leerOrdenPreferido(request);
            log.info("Orden de películas desde cookie: " + orden);

            if ("ASC".equals(orden)) {
                movies.sort((m1, m2) -> m1.getTitle().compareToIgnoreCase(m2.getTitle()));
                log.info("Películas ordenadas ASC por título");
            } else {
                movies.sort((m1, m2) -> m2.getTitle().compareToIgnoreCase(m1.getTitle()));
                log.info("Películas ordenadas DESC por título");
            }

            request.setAttribute("ordenActual", orden);

        } catch (NumberFormatException e) {
            log.warning("Error en formato de parámetros: " + e.getMessage());
            request.setAttribute("error", "Los parámetros de filtro no son válidos");
            getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        } catch (SQLException e) {
            log.severe("Error SQL: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("movies", movies);
        request.setAttribute("genres", genres);
        getServletContext().getRequestDispatcher("/movies/movies.jsp").forward(request, response);
    }

    // METOOD PARA LEER COOKIE
    private String leerOrdenPreferido(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("orden_peliculas".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        // Por defecto: orden descendente (Z-A)
        return "DESC";
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }

    @Override
    public void destroy() {
        try {
            DBConnection.closeConnection();
            log.info("Conexión cerrada correctamente");
        } catch (SQLException e) {
            log.severe("Error al cerrar conexión: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}
