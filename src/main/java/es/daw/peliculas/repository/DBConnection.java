package es.daw.peliculas.repository;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static Connection con = null;

    private DBConnection() {
    }

    /**
     * Método para obtener la conexión
     * @return Connection
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        if (con == null) {
            Properties props = new Properties();

            try {
                // 1️⃣ CARGAR EL DRIVER EXPLÍCITAMENTE ANTES DE CARGAR PROPERTIES
                Class.forName("org.h2.Driver");
                System.out.println("✅ Driver H2 cargado correctamente");

                // 2️⃣ CARGAR PROPERTIES
                InputStream input = DBConnection.class.getClassLoader()
                        .getResourceAsStream("jdbc.properties");

                if (input == null) {
                    throw new SQLException("❌ No se encuentra jdbc.properties en classpath");
                }

                props.load(input);
                input.close();

                // 3️⃣ OBTENER PARÁMETROS
                String url = props.getProperty("url");
                String user = props.getProperty("user");
                String password = props.getProperty("password");

                System.out.println("📊 Conectando a: " + url);

                // 4️⃣ ESTABLECER CONEXIÓN
                con = DriverManager.getConnection(url, user, password);

                System.out.println("✅ Conexión a base de datos establecida correctamente");

            } catch (ClassNotFoundException ex) {
                System.err.println("❌ ERROR: Driver H2 no encontrado");
                ex.printStackTrace();
                throw new SQLException("Driver H2 no encontrado. Verifica que h2-2.3.232.jar esté en las dependencias");
            } catch (IOException ex) {
                System.err.println("❌ ERROR: No se pudo cargar JDBC.properties");
                ex.printStackTrace();
                throw new SQLException("Error cargando JDBC.properties: " + ex.getMessage());
            } catch (SQLException ex) {
                System.err.println("❌ ERROR SQL: " + ex.getMessage());
                ex.printStackTrace();
                throw ex;
            }
        }
        return con;
    }

    /**
     * Método para cerrar la conexión
     * @throws SQLException
     */
    public static void closeConnection() throws SQLException {
        if (con != null && !con.isClosed()) {
            con.close();
            con = null;
            System.out.println("✅ Conexión cerrada correctamente");
        }
    }
}