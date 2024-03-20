/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Juan Leon
 */
public class IngresoMercaderia {
    
    private int idIngreso;
    private int idProveedor;
    private String descripcion;

    public IngresoMercaderia() {
    }

    public IngresoMercaderia(int idIngreso, int idProveedor, String descripcion) {
        this.idIngreso = idIngreso;
        this.idProveedor = idProveedor;
        this.descripcion = descripcion;
    }

    public int getIdIngreso() {
        return idIngreso;
    }

    public void setIdIngreso(int idIngreso) {
        this.idIngreso = idIngreso;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
}
