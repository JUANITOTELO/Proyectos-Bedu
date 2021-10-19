public class BuscarProductoControllerExtension {
    
    private Boolean showProduct = false;
    private Boolean showSearchError = false;
    private Boolean showUpdateError = false;
    public String valorBusqueda {get; set;}
    public Decimal nApart {get; set;}
    public Valores valor = new Valores();
    
    private final Quote Qut;
    
    public BuscarProductoControllerExtension(ApexPages.StandardController stdController) {
        this.Qut = (Quote)stdController.getRecord();
    }
    
    public Valores getValor(){
        return valor;
    }
    
    public class Valores {
        public string PBEId {get; set;}
        public string name {get; set;}
        public Decimal Unitp {get; set;}
        public string externalcode {get; set;}
        public Decimal dis {get; set;}
        public Decimal apart {get; set;}
    }
    
    public Boolean getShowProduct(){
        return showProduct;
    }
    
    public Boolean getShowSearchError(){
        return showSearchError;
    }
    
    public Boolean getShowUpdateError(){
        return showUpdateError;
    }
    
    
    public void SearchProduct(){
        
        if(valorBusqueda != null){
            List<PricebookEntry> quote = [SELECT Id, Product2.Name, UnitPrice, Product2.ExternalId
                                          FROM PriceBookEntry 
                                          WHERE Product2.ExternalId =: valorBusqueda AND isActive = true LIMIT 1];
            if(quote.size()>0){
                showSearchError = false;
                List<Inventario__c> inventario = [SELECT Cantidad_dis__c, Cantidad_apart__c 
                                                  FROM Inventario__c 
                                                  WHERE CodigoProd__c =: valorBusqueda];
                for(PricebookEntry item : quote){
                    valor.PBEId = item.Id;
                    valor.name = item.Product2.Name;
                    valor.Unitp = item.UnitPrice;
                    valor.externalcode = item.Product2.ExternalId;
                }
                for(Inventario__c item : inventario){
                    valor.dis = item.Cantidad_dis__c;
                    valor.apart = item.Cantidad_apart__c;
                }
                showProduct = true;
                // valorBusqueda = null;
            }else{
                showSearchError = true;
                showProduct = false;
                noExisteError();
            }
        }
    }
    
    private void noExisteError(){
        ApexPages.addMessage(
            new ApexPages.Message(
                ApexPages.Severity.ERROR,
                'No existe un producto para el código ingresado.'
            )
        );
    }
    
    private void menorACeroUpdateError(){
        ApexPages.addMessage(
            new ApexPages.Message(
                ApexPages.Severity.ERROR,
                'El valor tiene que ser mayor a 0.'
            )
        );
    }
    
    private void mayorADispUpdateError(){
        ApexPages.addMessage(
            new ApexPages.Message(
                ApexPages.Severity.ERROR,
                'El valor no puede exceder la cantidad disponible.'
            )
        );
    }
    
    public PageReference doSave(){
        nApart = valor.apart;
        if(nApart > 0 && nApart <= valor.dis){
            List<Product2> pro = [SELECT Id FROM Product2 WHERE ExternalId =: valor.externalcode];
            showUpdateError = false;
            List<Quote> tempQ = [SELECT Pricebook2Id FROM Quote WHERE Id =: Qut.Id];
            
            for(Quote tempQut: tempQ){
                if(TempQut.Pricebook2Id == null){
                    List<Pricebook2> standardPrk = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard' LIMIT 1];
                    for(Pricebook2 p : standardPrk){
                        Quote AddPriceBook = new Quote(Id = Qut.Id, Pricebook2Id = p.Id);
                    	update AddPriceBook;
                    }  
                }
            }
            
            QuoteLineItem line = new QuoteLineItem();
            for(Product2 item: pro){
                line.UnitPrice = valor.Unitp;
                line.QuoteId = Qut.Id;
                line.PricebookEntryId = valor.PBEId;
                line.Quantity = nApart;
                line.Product2Id = item.Id;
            }
            
            insert line;
            
            
            String url = '/' + line.Id;
            PageReference pr = new PageReference(url);
            pr.setRedirect(true);
            return pr;
        }
        else if(nApart > valor.dis){
            mayorADispUpdateError();
            showUpdateError = true;
        }
        else if(nApart <= 0){
            menorACeroUpdateError();
            showUpdateError = true;
        }
        return null;
    }
    
    public PageReference doReturn(){
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
    public PageReference doCancel(){
        PageReference pr = new PageReference('/'+qut.Id);
        pr.setRedirect(true);
        return pr;
    }
    
}