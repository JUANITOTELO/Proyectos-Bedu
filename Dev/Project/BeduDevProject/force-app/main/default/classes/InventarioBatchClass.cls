public class InventarioBatchClass implements
    Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public List<Inventario__c> start(Database.BatchableContext bc) {
        return InventarioRestQuery.geetExternalInventary();
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
        // call some utility to send email
        // EmailUtils.sendMessage(job, recordsProcessed);
        // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    }
}