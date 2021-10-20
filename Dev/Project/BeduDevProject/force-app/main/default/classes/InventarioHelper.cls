public class InventarioHelper {
    
    public static void nuevoRegistro(List<Inventario__c> inventario){
        List<Inventario__c> newInv = inventario;
        List<Inventario__c> exisInv = [SELECT Id, Name, CodigoProd__c, Cantidad_dis__c, Cantidad_apart__c 
                                       FROM Inventario__c];
        List<Inventario__c> actuInv = new List<Inventario__c>();
        List<Inventario__c> inseInv = new List<Inventario__c>();
        
        for(Inventario__c invN : newInv){
            for(Inventario__c invE : exisInv){
                if(invE.CodigoProd__c == invN.CodigoProd__c && invN.Cantidad_apart__c < invN.Cantidad_dis__c){
                    Inventario__c temp = new Inventario__c(
                        Id = invE.Id,
                        Cantidad_dis__c = invN.Cantidad_dis__c,
                        Cantidad_apart__c = invN.Cantidad_apart__c
                    );
                    actuInv.add(temp);
                }
            }
            
        }     
        Update actuInv;     
    }
}