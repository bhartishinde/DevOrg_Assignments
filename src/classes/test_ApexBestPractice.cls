@isTest
public with Sharing class test_ApexBestPractice
{  
    /*
		//Author : Bharati Shinde
		//this test class is to test the printInvoiceController written for Print Invoice on Invoice Statement Object
	*/
    static testmethod void testprintInvoiceController(){
        //create account
        //create invoice items  - assign account also
        //create line items
        printInvoiceController printInvoiceController = new printInvoiceController();
        List<Account> accList = test_Factory.createAccounts(1);
  
        Test.startTest(); 
        insert accList; 
        List<Invoice_Statement__c> invoiceList = test_Factory.createInvoiceStatements(1,accList);
        insert invoiceList; 
        List<Line_Item__c> lineItemsList = test_Factory.createLineItems(3,invoiceList);
        Test.stopTest();
        
        system.debug('controller instance:' + printInvoiceController);
        string invoiceID = invoiceList[0].id;
        printInvoiceController.lineItems = printInvoiceController.getLineItems(invoiceID);
        //printInvoiceController.sumTotal();
        system.debug('Line Items are:'+printInvoiceController.lineItems);

        //system.assertEquals('270', printInvoiceController.grandTotal, 'grand Total of Invoice is not correct');

    }
    
    /*
		//Author : Bharati Shinde
		//this test class is to test the AccountController written for custom page of Account Object
	*/
    static testmethod void testAccountController()
    {
        List<Account> accList = test_Factory.createAccounts(3);
        accountController accController = new accountController();
        test_msgFactory msgFactory = new test_msgFactory();
        Boolean messageFound = false;
        Boolean infoSeverity = false;
        Boolean errorSeverity = false;
        string infoSearchMsg = 'Your search matched 3 Records';
        string errorMinCharMsg = 'Input at least 3 characters to perform search';
		
        Test.startTest();
        insert accList; 
        
        //to search valid accounts
        accController.txtToSearch = 'Acc';
        accController.searchAccounts();
        
        //to check blank search text
        accController.txtToSearch = '';
        accController.validate();
        
        //to check - min search characters
        accController.txtToSearch = 'ac';
        accController.searchAccounts();

        //check msgs on page
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        
        //clear search text and result
        accController.clearSearch();
        
        //alphabetical search
        accController.AlphaFilter = 'a';
        accController.BuildQuery();
        
        //delete
        for(Account a :accList)
        {
            //accController.deleteAccount(a.id);
            break;
        }
        
		Test.stopTest();
          
        //to search valid accounts
        system.assertEquals(3, accController.allAccounts.size(), 'Search accounts count does not match');
        
        //to check blank search text
        system.assertEquals(false, accController.validate(), 'Did not validate search text');
        
		//check msg count on page
		System.assertEquals(2, pageMessages.size(),'Pagemessages count mismatch');
            
		//check msgs and their severuties
        messageFound = msgFactory.wasMessageAdded(pageMessages,infoSearchMsg,0);
        System.assertEquals(true, messageFound,'Search msg text mismatch');
        messageFound = false;
        
        infoSeverity = msgFactory.wasInfoSeverity(pageMessages,infoSearchMsg,0);
        System.assertEquals(true, infoSeverity,'Search msg severity mismatch');
        infoSeverity = false;
        
        messageFound = msgFactory.wasMessageAdded(pageMessages,errorMinCharMsg,1);
        System.assertEquals(true, messageFound,'Error msg for min search char text mismatch');
        messageFound = false;
        
        errorSeverity = msgFactory.wasErrorSeverity(pageMessages,errorMinCharMsg,1);
        System.assertEquals(true, errorSeverity,'Error msg severity mismatch');
        errorSeverity = false;
       
		System.assertEquals('', accController.txtToSearch, 'txtToSearch does not get cleared');
        //check msg count on page after clear serach
		//System.assertEquals(0, pageMessages.size(),'Pagemessages count mismatch');

        System.assertEquals(3, accController.allAccounts.size(), 'Alphabetical search did not work for lettr:' + ' ' + accController.AlphaFilter);
    	
        system.assertEquals(2, accController.allAccounts.size(), 'Account does not get deleted');
    	
    }
    
    static testmethod void test()
    {
        List<Contact> contList = test_Factory.createContacts(1);
		List<Case> casesList = test_Factory.createCases(1);
        
        Test.startTest();
        insert contList;
        Test.stopTest();

        Test.startTest();
        insert casesList;
        Test.stopTest();
        
       
        
    }
    
    
	
}