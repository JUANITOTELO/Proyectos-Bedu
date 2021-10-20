@isTest
public class QuoteTriggerTest {
    
    public TestMethod static void insertQuote(){
        Quote prQuote = new Quote();
        Opportunity prOpp = new Opportunity();
        prOpp.Name = 'PruebaOpp';
        prOpp.CloseDate = date.newInstance(2022, 11, 11);
        prOpp.Amount = 1000;
        prOpp.StageName = 'Prospecting';
        insert prOpp;
        prQuote.Name = 'prQuote';
        prQuote.OpportunityId = prOpp.Id;
        prQuote.ExpirationDate = date.newInstance(2021, 11, 30);
        Test.startTest();
        Database.SaveResult str = database.insert(prQuote , False);
        System.assertEquals(True, str.isSuccess());
        Test.stopTest();
    }
    
    public TestMethod static void insertFailQuote(){
        Quote prQuote = new Quote();
        Opportunity prOpp = new Opportunity();
        prOpp.Name = 'PruebaOpp';
        prOpp.CloseDate = date.newInstance(2022, 11, 11);
        prOpp.Amount = 1000;
        prOpp.StageName = 'Prospecting';
        insert prOpp;
        prQuote.Name = 'prQuote';
        prQuote.OpportunityId = prOpp.Id;
        prQuote.ExpirationDate = date.newInstance(2021, 11, 30);
        prQuote.Status = 'Approved';
        Test.startTest();
        Database.SaveResult str = database.insert(prQuote , False);
        System.assertEquals(False, str.isSuccess());
        Test.stopTest();
    }
    
    public TestMethod static void updateFailQuote(){
        Quote prQuote = new Quote();
        Opportunity prOpp = new Opportunity();
        prOpp.Name = 'PruebaOpp';
        prOpp.CloseDate = date.newInstance(2022, 11, 11);
        prOpp.Amount = 1000;
        prOpp.StageName = 'Prospecting';
        insert prOpp;
        prQuote.Name = 'prQuote';
        prQuote.Status = 'In Review';
        prQuote.OpportunityId = prOpp.Id;
        prQuote.ExpirationDate = date.newInstance(2021, 11, 30);
        insert prQuote;
        Quote prUpdateQuo = new Quote(
            Id = prQuote.Id, 
            Name = prQuote.Name, 
            OpportunityId = prQuote.OpportunityId,
            Status = 'Approved'	
        );
        Test.startTest();
        Database.SaveResult str = database.update(prUpdateQuo , False);
        System.assertEquals(False, str.isSuccess());
        Test.stopTest();
    }
    
    public TestMethod static void updateSuccessQuote(){
        Quote prQuote = new Quote();
        Opportunity prOpp = new Opportunity();
        prOpp.Name = 'PruebaOpp';
        prOpp.CloseDate = date.newInstance(2022, 11, 11);
        prOpp.Amount = 1000;
        prOpp.StageName = 'Prospecting';
        insert prOpp;
        prQuote.Name = 'prQuote';
        prQuote.Status = 'In Review';
        prQuote.OpportunityId = prOpp.Id;
        prQuote.ExpirationDate = date.newInstance(2021, 11, 30);
        insert prQuote;
        Quote prUpdateQuo = new Quote(
            Id = prQuote.Id, 
            Name = prQuote.Name, 
            OpportunityId = prQuote.OpportunityId,
            Status = 'Draft'
        );
        Test.startTest();
        Database.SaveResult str = database.update(prUpdateQuo , False);
        System.assertEquals(False, str.isSuccess());
        Test.stopTest();
    }
    
    Public TestMethod static void approvedSuccessQuote(){
        //Pricebook
        Pricebook2 prPricebook = new Pricebook2();
        prPricebook.Name = 'Standard';
        prPricebook.IsActive = true;
        insert prPricebook;
        id standardPB = Test.getStandardPricebookId();
        //Producto
        Product2 prProduct = new Product2();
        prProduct.Name = 'Producto 1';
        prProduct.IsActive = true;
        prProduct.ExternalId = 'PR';
        insert prProduct;
        //PricebookEntry
        PricebookEntry prPriceBE = new PricebookEntry();
        prPriceBE.Pricebook2Id = standardPB;
        prPriceBE.Product2Id = prProduct.Id;
        prPriceBE.IsActive = true;
        prPriceBE.UnitPrice = 1200;
        insert prPriceBE;
        //Inventario
        Inventario__c prInv = new Inventario__c();
        prInv.Name = 'Inventario 1';
        prInv.CodigoProd__c = prProduct.ExternalId;
        prInv.Cantidad_dis__c = 1000;
        insert prInv;
        //Opportunity
        Opportunity prOpp = new Opportunity();
        prOpp.Name = 'PruebaOpp';
        prOpp.CloseDate = date.newInstance(2022, 11, 11);
        prOpp.Amount = 1000;
        prOpp.StageName = 'Prospecting';
        insert prOpp;
        //Quote
        Quote prQuote = new Quote();
        prQuote.Pricebook2Id = standardPB;
        prQuote.Name = 'prQuote';
        prQuote.Status = 'In Review';
        prQuote.OpportunityId = prOpp.Id;
        prQuote.ExpirationDate = date.newInstance(2021, 11, 30);
        insert prQuote;
        //QuoteLineItem
        QuoteLineItem prQLI = new QuoteLineItem();
        prQLI.QuoteId = prQuote.Id;
        prQLI.PricebookEntryId = prPriceBE.Id;
        prQLI.Product2Id = prProduct.Id;
        prQLI.Quantity = 10;
        prQLI.UnitPrice = prPriceBE.UnitPrice;
        insert prQLI;
        Quote prUpdateQuo = new Quote(
            Id = prQuote.Id, 
            Name = prQuote.Name, 
            OpportunityId = prQuote.OpportunityId,
            Status = 'Approved'
        );
        Test.startTest();
        Database.SaveResult str = database.update(prUpdateQuo , False);
        System.assertEquals(True, str.isSuccess());
        Test.stopTest();
        
    }
}