trigger QuoteTrigger on Quote (before update) {
    new ActualizarInventario(Trigger.new, Trigger.old);
}