package Finales;
public class Empleado {
    private String nom;
    private String ape;
    private int antiguedad;

    public Empleado(String nom, String ape, int antiguedad) {
        this.nom = nom;
        this.ape = ape;
        this.antiguedad = antiguedad;
    }

    public String getNom() {
        return nom;
    }

    public String getApe() {
        return ape;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    @Override
    public String toString() {
        return "nombre" + nom + ", apellido: " + ape + ", antiguedad: " + antiguedad;
    }
    
    
}
