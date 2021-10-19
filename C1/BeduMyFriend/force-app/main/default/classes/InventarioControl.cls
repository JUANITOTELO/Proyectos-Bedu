public with sharing class InventarioControl {
    private Inventario__c inventario;

    public Inventario__c getInventario(){
        return this.inventario;
    }

    public InventarioControl() {
        id idInventario = ApexPages.currentPage().getParameters().get('id');
    }
}
