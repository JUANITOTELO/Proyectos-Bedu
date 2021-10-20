global class ScheduleInventarioBatch implements Schedulable{
    global void execute(SchedulableContext SC){
        
        InventarioBatchClass batch = new InventarioBatchClass();
        Id batchId = Database.executeBatch(batch);
    }
}