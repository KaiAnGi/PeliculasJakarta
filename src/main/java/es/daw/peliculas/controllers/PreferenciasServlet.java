package es.daw.peliculas.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "PreferenciasServlet", value = "/preferencias")
public class PreferenciasServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ordenPeliculas = request.getParameter("orden"); // "ASC" o "DESC"

        if (ordenPeliculas != null) {
            // CREAR COOKIE
            Cookie cookie = new Cookie("orden_peliculas", ordenPeliculas);
            cookie.setMaxAge(60 * 60 * 24 * 30);
            cookie.setPath(request.getContextPath() + "/");
            response.addCookie(cookie);

        }

        response.sendRedirect(request.getContextPath() + "/movies/list");
    }
}
