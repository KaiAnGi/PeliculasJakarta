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
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/movies/add")
public class AnadirPelisServlet extends HttpServlet {

    private GenericDAO<Genre,Integer> genreDAO;
    private  GenericDAO<Movie,Integer> movieDAO;
    Logger logger = Logger.getLogger(AnadirPelisServlet.class.getName());

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        try {
            genreDAO = new GenreDAO();
            movieDAO = new MovieDAO();
        } catch (SQLException e) {
            throw new ServletException("Error inicializando DAO: ",e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Genre> genres;
        try {
            genres = genreDAO.findAll();
            req.setAttribute("genres", genres);
            req.getRequestDispatcher("/movies/formularioMovies.jsp").forward(req,resp);
        }catch(Exception e){
            logger.severe(e.getMessage());
            req.setAttribute("error",e.getMessage());
            getServletContext().getRequestDispatcher("/error.jsp").forward(req,resp);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String title = request.getParameter("title");
            String director = request.getParameter("director");
            Integer releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
            Integer duration = Integer.parseInt(request.getParameter("duration"));
            Long genreId = Long.parseLong(request.getParameter("genreId"));
            BigDecimal rating = new BigDecimal(request.getParameter("rating"));

            // ✅ Usar constructor sin LocalDateTime (la BD lo manejará automáticamente)
            Movie nuevo = new Movie(title, director, releaseYear, duration, genreId, rating);

            movieDAO.save(nuevo);

            logger.info("Película guardada: " + title);
            response.sendRedirect(request.getContextPath() + "/movies/list");

        } catch (SQLException e) {
            logger.severe("Error SQL: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        } catch (NumberFormatException e) {
            logger.severe("Error en formato: " + e.getMessage());
            request.setAttribute("error", "Error en el formato de los datos");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
    }


}
