-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Tabla de géneros
CREATE TABLE IF NOT EXISTS genres (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
    );

-- Tabla de películas
CREATE TABLE IF NOT EXISTS movies (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      title VARCHAR(255) NOT NULL,
    director VARCHAR(100),
    release_year INT,
    duration INT,
    genre_id BIGINT,
    rating DECIMAL(3,1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE SET NULL
    );

-- ✅ CAMBIADO: INSERT sin especificar ID
INSERT INTO users (username, password, email) VALUES ('admin', 'admin123', 'admin@cinema.com');
INSERT INTO users (username, password, email) VALUES ('user', 'user123', 'user@cinema.com');

INSERT INTO genres (name, description) VALUES ('Acción', 'Películas de acción y aventura');
INSERT INTO genres (name, description) VALUES ('Drama', 'Películas dramáticas');
INSERT INTO genres (name, description) VALUES ('Comedia', 'Películas de comedia');
INSERT INTO genres (name, description) VALUES ('Terror', 'Películas de terror y suspense');
INSERT INTO genres (name, description) VALUES ('Ciencia Ficción', 'Películas de ciencia ficción');

INSERT INTO movies (title, director, release_year, duration, genre_id, rating)
VALUES ('Matrix', 'Wachowski', 1999, 136, 5, 8.7);
INSERT INTO movies (title, director, release_year, duration, genre_id, rating)
VALUES ('El Padrino', 'Francis Ford Coppola', 1972, 175, 2, 9.2);
INSERT INTO movies (title, director, release_year, duration, genre_id, rating)
VALUES ('Duro de Matar', 'John McTiernan', 1988, 132, 1, 8.2);
INSERT INTO movies (title, director, release_year, duration, genre_id, rating)
VALUES ('El Resplandor', 'Stanley Kubrick', 1980, 146, 4, 8.4);
