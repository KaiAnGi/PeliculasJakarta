package es.daw.peliculas.util;

import es.daw.peliculas.model.Genre;

import java.util.List;

public class Utils {
    public static String obtenerNombreGenero(List<Genre> genres, Long id){

        return genres.stream()
                .filter(genre -> genre.getId().equals(id))
                .findFirst()
                .map(Genre::getName)
                .orElse("Desconocido");

    }
}
