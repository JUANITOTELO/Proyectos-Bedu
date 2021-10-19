@RestResource(urlMapping='/Inventario/*')
global with sharing class InventarioService {
    //Consultar por el productId
    @HttpGet
    global static List<Inventario__c> getInventario() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String InventarioIdFilter= req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Inventario__c> result = [SELECT CodigoProd__c, Name, Cantidad_dis__c, Cantidad_apart__c 
                                      FROM Inventario__c WHERE Id = :InventarioIdFilter];
        return result;
    }
    
    //Crear inventario
    @HttpPost
    global static String PostInventario(String Name, Decimal Cantidad_dis, String CodigoProducto, Decimal Cantidad_apartada) {
        Inventario__c inventario = new Inventario__c(
                                                    Name = name, 
                                                    Cantidad_dis__c = Cantidad_dis,
                                                     CodigoProd__c = CodigoProducto,
                                                     Cantidad_apart__c = Cantidad_apartada
                                                     );
        insert inventario;
        return inventario.Id;
    }
}