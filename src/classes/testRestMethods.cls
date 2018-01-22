@IsTest
private class testRestMethods {
    @isTest static void testCreateLead() {
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"FirstName": "test","LastName":"Lead","Email":"test@gmail.com","Phone":"030-1234","Follow_up__c":"10/14/2017","Company" : "ESPL"}');
        RestContext.request = request;
    
        // Call the method to test
        Map<String, Map<String,String>> responseMap = RESTExecution.createLead();
        system.debug('responseMap is:'+responseMap);

		for(string lead :responseMap.keySet()){
            System.assert(lead!=null);
            Lead thisLead = [SELECT Id FROM Lead WHERE Id=:lead];
            System.assert(thisLead != null);
            for(string success : responseMap.get(lead).keySet()){
            	System.assertEquals(success,'Status:Success','Success string is not returned');
            	System.assertEquals(responseMap.get(lead).get(success),'isSuccess:true','isSuccess boolean is not set');
                }
        }       
    }
    
    @isTest static void testUpdateLead() {
        test_Factory.createLead();
        
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'PUT';     
        request.params.put('FirstName','test');
		request.params.put('LastName','Lead');
		request.params.put('NewEmail','paramemail@gmail.com');
		request.params.put('NewPhone','080-223355');

        RestContext.request = request;
    
        // Call the method to test
        Map<String, Map<String,String>> responseMap = RESTExecution.updateLead();
        system.debug('responseMap is:'+responseMap);

		for(string lead :responseMap.keySet()){
            System.assert(lead!=null);
            Lead thisLead = [SELECT Id,Email,Phone FROM Lead WHERE Id=:lead];
            System.assert(thisLead != null);
            System.assertEquals('paramemail@gmail.com', thisLead.Email, 'Email is not been updated');
            System.assertEquals('080-223355', thisLead.Phone, 'Phone is not been updated');
            for(string success : responseMap.get(lead).keySet()){
            	System.assertEquals(success,'Status:Success','Success string is not returned');
            	System.assertEquals(responseMap.get(lead).get(success),'isSuccess:true','isSuccess boolean is not set');
                }
        }
    }
    
    @isTest static void testDeleteLead() {
        test_Factory.createLead();
        
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'DELETE';     
        request.params.put('FirstName','test');
		request.params.put('LastName','Lead');
		request.params.put('Email','myemail@gmail.com');
		request.params.put('Phone','020-33214');

        RestContext.request = request;
    
        // Call the method to test
        Map<String, Map<String,String>> responseMap = RESTExecution.deleteLead();
        system.debug('responseMap is:'+responseMap);

		for(string lead :responseMap.keySet()){
            System.assertEquals(lead,'test lead','Lead name is not correct');
            Lead thisLead = [SELECT Id FROM Lead WHERE Name=:lead];
            system.debug(thisLead);
            System.assert(thisLead == null);
            
            for(string success : responseMap.get(lead).keySet()){
            	System.assertEquals(success,'Status:Success','Success string is not returned');
            	System.assertEquals(responseMap.get(lead).get(success),'isSuccess:true','isSuccess boolean is not set');
                }
        }
    }
}