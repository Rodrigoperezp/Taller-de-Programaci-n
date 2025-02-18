package Finales;
public class Producto {
    private int cod;
    private double costo;
    private int etapa;

    public Producto(int cod) {
        this.cod = cod;
        this.costo = 0;
        this.etapa = 1;
    }

    public int getEtapa() {
        return etapa;
    }

    public double getCosto() {
        return costo;
    }

    public int getCod() {
        return cod;
    }

    public void setCosto(double costo) {
        this.costo = costo;
    }

    public void setEtapa(int etapa) {
        this.etapa = etapa;
    }
    
    
}
