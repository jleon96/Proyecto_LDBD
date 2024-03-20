/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Juan Leon
 */
public class Devoluciones {
    private int idDevolucion;
    private int idProducto;
    private String motivo;

    public Devoluciones() {
    }

    public Devoluciones(int idDevolucion, int idProducto, String motivo) {
        this.idDevolucion = idDevolucion;
        this.idProducto = idProducto;
        this.motivo = motivo;
    }

    public int getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(int idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }
    
       
}
