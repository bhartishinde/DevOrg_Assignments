public with sharing class printInvoiceController
{
    public List<Line_Item__c> lineItems{get;set;}
    public String grandTotal{get;set;}
    
    public printInvoiceController(){}
    
    public printInvoiceController(ApexPages.StandardController controller) {
        String invoiceID = ApexPages.currentPage().getParameters().get('id');
        lineItems =  getLineItems(invoiceID);
        sumTotal();
    }   
    
    public List<Line_Item__c> getLineItems(String invoiceID){
        
        List<Line_Item__c> fetchLineItems = [SELECT Description__c,Amount__c FROM Line_Item__c WHERE Invoice_Statement__c =: invoiceID ];
        return fetchLineItems;
    }
    
     public String getgrandTotal() {
            return grandTotal;
        }

    public void setgrandTotal(String grandTotal) {
            this.grandTotal= grandTotal;
        } 
    
     public void sumTotal(){
       Double total = 0.00;
       
        for(Line_Item__c obj : lineItems){          
            total += obj.Amount__c;           
        }
        
        grandTotal = String.valueOf(total);
    }



    
}