package es.daw.peliculas.controllers;

import es.daw.peliculas.model.User;
import es.daw.peliculas.repository.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;
import java.util.logging.Logger;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    Logger logger = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mostrar formulario de login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO userDAO = new UserDAO();
            Optional<User> userOpt = userDAO.findByUsername(username);

            if (userOpt.isPresent()) {
                User user = userOpt.get();

                // ✅ Verificar contraseña
                if (user.getPassword().equals(password)) {

                    // ✅ Crear sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("username", user.getUsername());
                    session.setMaxInactiveInterval(30 * 60); // 30 minutos

                    logger.info("✅ Login exitoso: " + username);
                    response.sendRedirect(request.getContextPath() + "/movies/list");
                    return;
                }
            }

            // ❌ Credenciales incorrectas
            logger.warning("⚠️ Login fallido: " + username);
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.severe("Error SQL en login: " + e.getMessage());
            request.setAttribute("error", "Error en el sistema. Intente más tarde.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
