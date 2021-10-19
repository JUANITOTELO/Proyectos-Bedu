public class InventarioHelper {
	
    public static Boolean cantidadDisponible(List<Inventario__c> inventario){
        for (Inventario__c inv : inventario){
            if(inv.Cantidad_dis__c < inv.Cantidad_apart__c){
                inv.AddError('La cantidad apartada no puede ser mayor a la disponible.');
                return false;
            }
        }
        return true;
    }
    
    public static void nuevoRegistro(List<Inventario__c> inventario){
        for (Inventario__c inv : inventario){
            Product2 newPro = new Product2(
                                                        Name = inv.Name+'Product', 
                                                        ProductCode = inv.CodigoProd__c, 
                                                        ExternalId = inv.CodigoProd__c, 
                                                        IsActive = true
                                                    );
            insert newPro;
        }
    }
}