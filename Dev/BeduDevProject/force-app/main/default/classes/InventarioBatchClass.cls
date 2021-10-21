public class InventarioBatchClass implements
Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful, HttpCalloutMock {
   
    public Integer recordsProcessed = 0;
    public HTTPResponse respond(HTTPRequest req) {
        return InventarioRestQuery.getResponse();
    }
    public List<Inventario__c> start(Database.BatchableContext bc) {
        return InventarioRestQuery.geetExternalInventary(respond(null));
    }
    
    public void execute(Database.BatchableContext bc, List<Inventario__c> scope){      
        InventarioHelper.nuevoRegistro(scope);
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id =: bc.getJobId()];
    }
}