package Finales;
public class Sector {
    private String nom;
    private Empleado  jefe;
    private Empleado vecE[];
    private Producto vecP[];
    private int maxP;
    private int dlE;
    private int dlP;

    public Sector(String nom, int maxP) {
        this.nom = nom;
        this.maxP = maxP;
        this.vecE = new Empleado[50];
        this.vecP = new Producto[maxP];
        this.dlE=0;
        this.dlP=0;
        
    }
    
    public void agregarEmpleado(Empleado e, boolean esJefe){
        if (esJefe==true){
            this.jefe=e;
        }
        else{
            vecE[dlE]=e;                   
            dlE++;
        }           
    }
    
    public void agregarProducto (Producto p){
        this.vecP[dlP]=p;
        dlP++;
    }
    
    public double costoTotal (int etapa){
        double aux=0;
        for (int i=0;i<dlP;i++){
            if (vecP[i].getEtapa()==etapa)
                aux+=vecP[i].getCosto();
        }
        return aux;
    }
    
    public void cambiarEtapa (int cod, double cost){
        int i=0;
        while ((i<dlP)&(vecP[i].getCod()!=cod)){
            i++;
        }
           if(vecP[i].getCod()==cod){
                vecP[i].setEtapa(vecP[i].getEtapa()+1);
                vecP[i].setCosto(vecP[i].getCosto()+cost);
            }        
    }
    
    public String impEmpleados(){
        String aux="";
        for (int i=0;i<dlE; i++){
            if (vecE[i].getAntiguedad()>10){
                aux+=vecE[i].toString();
            }
        }
        return aux;
    }
    


    
    public String toString() {
        String aux="";
        aux+="nombre del sector: " + nom + ", jefe:" +jefe.getNom()+ jefe.getApe() + jefe.getAntiguedad()
                + "la cantidad total de los productos en los que trabaja: "+ dlP+
                "el costo total del los productos finalizados: "+this.costoTotal(5)+
                "Empleados con una antiguedad mayor a 10 años: " 
                + this.impEmpleados();                
        return aux;
    }
    
    
    
}
