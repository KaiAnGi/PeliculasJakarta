package es.daw.peliculas.repository;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface GenericDAO<T, ID> {

    // CREATE
    void save(T entity) throws SQLException;

    // READ
    Optional<T> findById(ID id) throws SQLException;

    List<T> findAll() throws SQLException;

    // UPDATE
    void update(T entity) throws SQLException;

    // DELETE
    void delete(ID id) throws SQLException;

    // PENDIENTE!!! DECIDIR SI DECLARO UN MÉTODO ABSTRACTO PARA HACER findByNombre!!!
}
