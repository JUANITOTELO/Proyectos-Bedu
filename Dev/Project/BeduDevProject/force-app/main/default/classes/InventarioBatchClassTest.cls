@isTest
public class InventarioBatchClassTest{
    @isTest static void testSuccessBatch(){
        
        Test.startTest();
        InventarioBatchClass batch = new InventarioBatchClass();
        Test.setMock(HttpCalloutMock.class, batch);
        Test.stopTest();
    }
}