package es.daw.peliculas.repository;

import es.daw.peliculas.model.Genre;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GenreDAO implements GenericDAO<Genre, Integer> {

    private Connection conn;

    public GenreDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    @Override
    public void save(Genre entity) throws SQLException {
        String sql = "INSERT INTO genres (name, description) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<Genre> findById(Integer id) throws SQLException {
        // ✅ CAMBIAR: genre → genres
        String sql = "SELECT * FROM genres WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Genre genre = new Genre(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                return Optional.of(genre);
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Genre> findAll() throws SQLException {
        List<Genre> genres = new ArrayList<>();
        // ✅ CAMBIAR: genre → genres
        String sql = "SELECT * FROM genres ORDER BY name ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                genres.add(new Genre(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("description")
                ));
            }
        }
        return genres;
    }

    @Override
    public void update(Genre entity) throws SQLException {
        String sql = "UPDATE genres SET name=?, description=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setLong(3, entity.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Integer id) throws SQLException {
        String sql = "DELETE FROM genres WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
