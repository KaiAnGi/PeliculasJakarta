package es.daw.peliculas.repository;

import es.daw.peliculas.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDAO implements GenericDAO<User, Integer> {

    private Connection conn;

    public UserDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    @Override
    public void save(User entity) throws SQLException {
        // ✅ CAMBIAR: user → users, createdAt → created_at
        String sql = "INSERT INTO users (username, password, email, created_at) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getPassword());
            ps.setString(3, entity.getEmail());
            ps.setTimestamp(4, java.sql.Timestamp.valueOf(entity.getCreatedAt()));
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<User> findById(Integer id) throws SQLException {
        // ✅ CAMBIAR: user → users, created_at
        String sql = "SELECT * FROM users WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User(
                        rs.getLong("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    @Override
    public List<User> findAll() throws SQLException {
        List<User> users = new ArrayList<>();
        // ✅ CAMBIAR: user → users
        String sql = "SELECT * FROM users ORDER BY username ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new User(
                        rs.getLong("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                ));
            }
        }
        return users;
    }

    @Override
    public void update(User entity) throws SQLException {
        // ✅ CAMBIAR: user → users
        String sql = "UPDATE users SET username=?, password=?, email=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getPassword());
            ps.setString(3, entity.getEmail());
            ps.setLong(4, entity.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Integer id) throws SQLException {
        // ✅ CAMBIAR: user → users
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Optional<User> findByUsername(String username) throws SQLException {
        // ✅ CAMBIAR: user → users
        String sql = "SELECT * FROM users WHERE username = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User(
                        rs.getLong("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }
}