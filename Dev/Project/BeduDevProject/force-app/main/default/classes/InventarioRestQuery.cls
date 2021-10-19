public class InventarioRestQuery {
    public static List<Inventario__c> geetExternalInventary(){
        List<Inventario__c> output = new List<Inventario__c>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        InventaryResponseClass Inventary = InventaryResponseClass.parse(response.getBody());
        if(response.getStatusCode() == 200){
            for(InventaryResponseClass.Inventory inv : Inventary.Body.Inventory){
                Inventario__c temp = new Inventario__c(
                    Name = inv.name, 
                    Cantidad_dis__c = inv.BlockedQuan,
                    CodigoProd__c= inv.ProductID,
                    Cantidad_apart__c = inv.Quan
                );
                output.add(temp);
            }
        }
        
        return output;
    }
}