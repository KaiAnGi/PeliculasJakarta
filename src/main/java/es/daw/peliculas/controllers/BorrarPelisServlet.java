package es.daw.peliculas.controllers;

import es.daw.peliculas.model.Movie;
import es.daw.peliculas.repository.GenericDAO;
import es.daw.peliculas.repository.MovieDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/movies/delete")
public class BorrarPelisServlet extends HttpServlet {

    private GenericDAO<Movie,Integer> daoM;

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        try {
            daoM = new MovieDAO();
        } catch (SQLException e) {
            throw new ServletException("Error inicializando DAO: ",e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            daoM = new MovieDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            daoM.delete(id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Redirigir de nuevo a la lista actualizada
        response.sendRedirect(request.getContextPath() + "/movies/list");
    }
}
