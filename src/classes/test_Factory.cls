public with sharing class test_Factory {
	public static void createLead()
    {
		Lead newLead = new Lead();
        newLead.FirstName = 'test';
        newLead.LastName = 'lead';
        newLead.Follow_up__c = date.ValueOf('2017-09-21');
        newLead.Company = 'Espl';
        newLead.Email = 'myemail@gmail.com';
        newLead.Phone = '020-33214';
        insert newLead;
    }
    
    public static List<Invoice_Statement__c> createInvoiceStatements(Integer counter,List<Account> acList)
    {
        List<Invoice_Statement__c> invoiceList = new List<Invoice_Statement__c>();
         for(Integer i=0; i<counter;i++){
            string accID = acList[0].Id;
            Invoice_Statement__c invoiceRecord = new Invoice_Statement__c(Account__c = accID);
            invoiceList.add(invoiceRecord);
        }
        return invoiceList;
    }
    
    public static List<Line_Item__c> createLineItems(Integer counter,List<Invoice_Statement__c> invoiceList)
    {
        List<Line_Item__c> lineItemsList = new List<Line_Item__c>();
         for(Integer i=0; i<counter;i++){
            string invoiceID = invoiceList[0].id;
            Line_Item__c lineItemRecord = new Line_Item__c(Invoice_Statement__c = invoiceID, Unit_Price__c=30,Unit_Sold__c=3,Description__c = 'Test Line Item'+ ' '+ i);
            lineItemsList.add(lineItemRecord);
        }
        return lineItemsList;
    }
    
    
    public static List<Account> createAccounts(Integer counter)
    {
        List<Account> accList = new List<Account>();
         for(Integer i=0; i<counter;i++){
            Account accRecord = new Account(Name = 'Account' + ' ' + i);
            accList.add(accRecord);
        }
        return accList;
    }
    
    public static List<Contact> createContacts(Integer counter)
    {
        List<Contact> contList = new List<Contact>();
         for(Integer i=1; i<=counter;i++){
            Contact contRecord = new Contact(LastName = 'Contact from Test' + ' ' + i,Email = 'myofficialemail160@gmail.com', AccountId='0017F00000M4ush');
            contList.add(contRecord);
        }
        return contList;
    }
    
    public static List<Case> createCases(Integer counter)
    {
        List<Case> casesList = new List<Case>();
         for(Integer i=1; i<=counter;i++){
            Case caseRecord = new Case(Origin = 'Web' + '' + i, SuppliedEmail = 'myofficialemail160@gmail.com');
            casesList.add(caseRecord);
        }
        return casesList;
    }
    
 }