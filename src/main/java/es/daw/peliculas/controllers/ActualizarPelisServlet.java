package es.daw.peliculas.controllers;

import es.daw.peliculas.model.Genre;
import es.daw.peliculas.model.Movie;
import es.daw.peliculas.repository.GenericDAO;
import es.daw.peliculas.repository.GenreDAO;
import es.daw.peliculas.repository.MovieDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet({"/movies/update"})
public class ActualizarPelisServlet extends HttpServlet {

    private GenericDAO<Movie,Integer> daoM;
    private GenericDAO<Genre,Integer> daoG;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        try{
            daoM = new MovieDAO();
            daoG = new GenreDAO();
        } catch (SQLException e){
            throw new ServletException("error al inicializar los DAO",e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta el parametro con el codigo de libro");
            return;
        }
        try {
            Optional<Movie> libroOpt = daoM.findById(Integer.parseInt(id));

            if (libroOpt.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "No existe la pelicula");
                return;
            }

            Movie movie = libroOpt.get();
            req.setAttribute("movie", movie);

            // ✅ AÑADIR ESTA LÍNEA
            req.setAttribute("genres", daoG.findAll());

            getServletContext().getRequestDispatcher("/movies/formularioMovies.jsp").forward(req, resp);

        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            String title = request.getParameter("title");
            String director = request.getParameter("director");
            Integer releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
            Integer duration = Integer.parseInt(request.getParameter("duration"));
            Long genreId = Long.parseLong(request.getParameter("genreId"));
            BigDecimal rating = new BigDecimal(request.getParameter("rating"));

            // ✅ Obtener película existente para mantener createdAt
            Optional<Movie> existingOpt = daoM.findById(id.intValue());
            if (existingOpt.isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Película no encontrada");
                return;
            }

            // ✅ Crear Movie con ID (como haces con Book)
            Movie movie = new Movie(
                    id,
                    title,
                    director,
                    releaseYear,
                    duration,
                    genreId,
                    rating,
                    existingOpt.get().getCreatedAt()  // Mantener createdAt original
            );

            daoM.update(movie);

            response.sendRedirect(request.getContextPath() + "/movies/list");

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }
    }


}
