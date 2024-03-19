package Controlador;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Juan Leon
 */
public class ConexionOracle {
//    private Connection conn = null;
//    private String url, user, pass;
//     
//    public ConexionOracle(){
//        conectar();
//    };
//    
//    private void conectar(){
//    try{
//    Class.forName("oracle.jdbc.driver.OracleDriver");
//    url = "jdbc:oracle:thin:@localhost:1521/inventario";
//    user = "proyecto";
//    pass = "inv123";
//    
//    /*
//    url = "jdbc:oracle:thin:@localhost:1521/inventario";
//    user = "proyecto";
//    pass = "inv123";
//    */
//    /*
//    url = "jdbc:oracle:thin:@localhost:1521/inventario";
//    user = "proyecto";
//    pass = "inv123";
//    */
//    /*
//    url = "jdbc:oracle:thin:@localhost:1521/inventario";
//    user = "proyecto";
//    pass = "inv123";
//    */
//    String resultado = null;
//    conn = DriverManager.getConnection(url,user, pass);
//    System.out.println("Conexion con la BD ORACLE establecida con exito.");
//    }catch (Exception e){
//    System.out.println("Error en la conexion." + e);
//    }
//    }
    
    private static final String URL = "jdbc:oracle:thin:@localhost:1521/inventario";
    private static final String USER = "proyecto";
            private static final String PASS = "inv123";
            
            public static Connection getConnection () throws SQLException {
                return DriverManager.getConnection(URL, USER, PASS);
            }
}

     
   



