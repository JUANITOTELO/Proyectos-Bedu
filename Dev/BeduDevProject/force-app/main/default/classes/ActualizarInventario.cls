public class ActualizarInventario {
    public ActualizarInventario(List<Quote> newTrgQuote, List<Quote> oldTrgQuote){
        for(Quote oldQuote : oldTrgQuote){
            for(Quote newQuote : newTrgQuote){
                if(oldQuote.LineItemCount > 0){
                    if(newQuote.Status == 'Approved' || newQuote.Status == 'Accepted'){
                        List<QuoteLineItem> Items = [SELECT Id, Quantity, Product2Id
                                                     FROM QuoteLineItem 
                                                     WHERE QuoteId =: newQuote.Id];
                        List<Product2> pro = new List<Product2>();
                        List<Decimal> quantities = new List<Decimal>();
                        for(QuoteLineItem item : Items){
                            List<Product2> temp = [SELECT ExternalId 
                                                   FROM Product2 
                                                   WHERE Id =: item.Product2Id AND ExternalId <> null Limit 1];
                            if(temp.size() > 0){
                                pro.add(temp[0]); 
                                quantities.add(item.Quantity);
                            }
                        }
                        
                        List<Inventario__c> nInv = new List<Inventario__c>();
                        Integer counter = 0;
                        for(Product2 p : pro){
                            
                            List<Inventario__c> inv = [SELECT Id, Cantidad_dis__c
                                                       FROM Inventario__c 
                                                       WHERE CodigoProd__c =: p.ExternalId  LIMIT 1];
                            
                            for(Inventario__c i : inv){
                                
                                Inventario__c temp = new Inventario__c(
                                    Id = i.Id, 
                                    Cantidad_dis__c = i.Cantidad_dis__c - quantities[counter]
                                );
                                nInv.add(temp);
                                
                            } 
                            counter += 1;
                        }
                        upsert nInv;
                    }
                }
                else if(oldQuote.LineItemCount == 0 && newQuote.LineItemCount >= 1){
                    continue;   
                }
                else{
                    newTrgQuote[0].addError('La cotización no tiene '+ newQuote.LineItemCount + 'productos.');   
                }
            }
        }
    }
}