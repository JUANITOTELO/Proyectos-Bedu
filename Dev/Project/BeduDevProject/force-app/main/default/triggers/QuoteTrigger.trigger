trigger QuoteTrigger on Quote (before update, before insert) {
    if(Trigger.isUpdate){
    	new ActualizarInventario(Trigger.new, Trigger.old);    
    }
    if(Trigger.isInsert){
        new VerificarInventario(Trigger.new);
    }
}