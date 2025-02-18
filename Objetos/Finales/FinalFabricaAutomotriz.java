package Finales;
public class FinalFabricaAutomotriz {
    public static void main(String[] args) {
        Sector s= new Sector("culo", 3);
        Empleado jefe = new Empleado ("carlos", "bilardo", 30);
        Empleado e1= new Empleado ("pito","teta",40);
        Empleado e2= new Empleado ("caca","pis",7);
        Producto p1= new Producto (123);
        Producto p2= new Producto (456);
        
        s.agregarEmpleado(jefe, true);
        s.agregarEmpleado(e1, false);
        s.agregarEmpleado(e2, false);
        
        s.agregarProducto(p1);
        s.agregarProducto(p2);
        
        s.cambiarEtapa(456, 50);
        s.cambiarEtapa(456, 50);
        s.cambiarEtapa(456, 50);
        s.cambiarEtapa(456, 50);        
        
        System.out.println(s.toString());
    }
    
}
