package es.daw.peliculas.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

public class Movie {
    private Long id;
    private String title;
    private String director;
    private Integer releaseYear;
    private Integer duration;
    private Long genreId;
    private BigDecimal rating;
    private LocalDateTime createdAt;

    public Movie(){

    }

    public Movie(Long id, String title, String director, Integer releaseYear, Integer duration, Long genreId, BigDecimal rating, LocalDateTime createdAt) {
        this.id = id;
        this.title = title;
        this.director = director;
        this.releaseYear = releaseYear;
        this.duration = duration;
        this.genreId = genreId;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public Movie(String title, String director, Integer releaseYear, Integer duration, Long genreId, BigDecimal rating, LocalDateTime createdAt) {
        this.title = title;
        this.director = director;
        this.releaseYear = releaseYear;
        this.duration = duration;
        this.genreId = genreId;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public Movie(String title, String director, Integer releaseYear, Integer duration, Long genreId, BigDecimal rating) {
        this.title = title;
        this.director = director;
        this.releaseYear = releaseYear;
        this.duration = duration;
        this.genreId = genreId;
        this.rating = rating;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Integer getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(Integer releaseYear) {
        this.releaseYear = releaseYear;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Long getGenreId() {
        return genreId;
    }

    public void setGenreId(Long genreId) {
        this.genreId = genreId;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Movie movie = (Movie) o;
        return Objects.equals(id, movie.id) && Objects.equals(title, movie.title) && Objects.equals(director, movie.director) && Objects.equals(releaseYear, movie.releaseYear) && Objects.equals(duration, movie.duration) && Objects.equals(genreId, movie.genreId) && Objects.equals(rating, movie.rating) && Objects.equals(createdAt, movie.createdAt);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, title, director, releaseYear, duration, genreId, rating, createdAt);
    }


}
