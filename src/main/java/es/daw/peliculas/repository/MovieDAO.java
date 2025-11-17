package es.daw.peliculas.repository;

import es.daw.peliculas.model.Movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MovieDAO implements GenericDAO<Movie, Integer>{

    private Connection conn;

    public MovieDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    public List<Movie> findByGenre(Long genreId) throws SQLException {
        List<Movie> movies = new ArrayList<>();
        // ✅ CAMBIAR: movie → movies, genreId → genre_id
        String sql = "SELECT * FROM movies WHERE genre_id = ? ORDER BY title ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, genreId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    movies.add(new Movie(
                            rs.getLong("id"),
                            rs.getString("title"),
                            rs.getString("director"),
                            rs.getInt("release_year"),  // ✅ CAMBIAR: releaseYear → release_year
                            rs.getInt("duration"),
                            rs.getLong("genre_id"),     // ✅ CAMBIAR: genreId → genre_id
                            rs.getBigDecimal("rating"),
                            rs.getTimestamp("created_at").toLocalDateTime()  // ✅ CAMBIAR: createdAt → created_at
                    ));
                }
            }
        }

        return movies;
    }

    @Override
    public void save(Movie entity) throws SQLException {
        String sql = "INSERT INTO movies (title, director, release_year, duration, genre_id, rating) VALUES (?,?,?,?,?,?)";
        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, entity.getTitle());
            ps.setString(2, entity.getDirector());
            ps.setInt(3, entity.getReleaseYear());
            ps.setInt(4, entity.getDuration());
            ps.setLong(5, entity.getGenreId());
            ps.setBigDecimal(6, entity.getRating());
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<Movie> findById(Integer id) throws SQLException {
        String sql = "SELECT * FROM movies WHERE id = ?";

        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                Movie movie = new Movie(
                        rs.getLong("id"),
                        rs.getString("title"),
                        rs.getString("director"),
                        rs.getInt("release_year"),
                        rs.getInt("duration"),
                        rs.getLong("genre_id"),
                        rs.getBigDecimal("rating"),
                        rs.getTimestamp("created_at").toLocalDateTime()  // ✅ snake_case
                );
                return Optional.of(movie);
            }
        }
        return Optional.empty();
    }

    public List<Movie> findByFilters(Long genreId, String title) throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql;
        PreparedStatement ps;

        // Normalizar title
        if (title != null && title.trim().isEmpty()) {
            title = null;
        }

        // CASO 1: Ambos filtros activos
        if (genreId != null && title != null) {
            sql = "SELECT * FROM movies WHERE genre_id = ? AND title LIKE ? ORDER BY title DESC";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, genreId);
            ps.setString(2, "%" + title.trim() + "%");
        }
        // CASO 2: Solo genreId
        else if (genreId != null) {
            sql = "SELECT * FROM movies WHERE genre_id = ? ORDER BY title DESC";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, genreId);
        }
        // CASO 3: Solo title
        else if (title != null) {
            sql = "SELECT * FROM movies WHERE title LIKE ? ORDER BY title DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + title.trim() + "%");
        }
        // Sin filtros
        else {
            sql = "SELECT * FROM movies ORDER BY title DESC";
            ps = conn.prepareStatement(sql);
        }

        try (ps) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                movies.add(new Movie(
                        rs.getLong("id"),
                        rs.getString("title"),
                        rs.getString("director"),
                        rs.getInt("release_year"),
                        rs.getInt("duration"),
                        rs.getLong("genre_id"),
                        rs.getBigDecimal("rating"),
                        rs.getTimestamp("created_at").toLocalDateTime()  // ✅ snake_case
                ));
            }
        }

        return movies;
    }

    @Override
    public List<Movie> findAll() throws SQLException {
        return findByFilters(null, null);
    }

    @Override
    public void update(Movie entity) throws SQLException {
        String sql = "UPDATE movies SET title=?, director=?, release_year=?, duration=?, genre_id=?, rating=? WHERE id=?";
        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, entity.getTitle());
            ps.setString(2, entity.getDirector());
            ps.setInt(3, entity.getReleaseYear());
            ps.setInt(4, entity.getDuration());
            ps.setLong(5, entity.getGenreId());
            ps.setBigDecimal(6, entity.getRating());
            ps.setLong(7, entity.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Integer id) throws SQLException {
        String sql = "DELETE FROM movies WHERE id = ?";
        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
