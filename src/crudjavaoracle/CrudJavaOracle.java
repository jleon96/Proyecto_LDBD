package crudjavaoracle;
import Controlador.ConexionOracle;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 *
 * @author Juan Leon
 */
public class CrudJavaOracle {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String nombre = "" ;
        String apellido1 = "" ;
        
        // TODO code application logic here  System.out.println("Hello World!");
        //ConexionOracle conn = new ConexionOracle();
        try ( Connection connection = ConexionOracle.getConnection();
                Statement statement  = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM CLIENTES WHERE id_Cliente = 1")){
            while (rs.next()) {
                nombre = rs.getString(2);
                apellido1 = rs.getString(3);
                System.out.println("El nombre es: " + nombre + " " +apellido1);
            }
            
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}

