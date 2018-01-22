global with sharing class BatchApex implements Database.Batchable<sObject>,Database.Stateful{
   global final Map<String, Map<String,Decimal>> contactOppMap=new Map<String, Map<String,Decimal>>();
   global final String query;
  
   global Database.QueryLocator start(Database.BatchableContext BC){
      //system.debug('In start method');
      return Database.getQueryLocator([SELECT Name, (Select Email,Name from Contacts WHERE Level__c = 'Primary'), 
      (SELECT Name,Amount
       FROM Opportunities
       WHERE StageName='Closed Won' AND LastModifiedDate = TODAY)
FROM Account where Id In (Select AccountId From Opportunity WHERE StageName='Closed Won' AND LastModifiedDate = TODAY) 
               AND Id In (Select AccountId from Contact WHERE Level__c = 'Primary')]);
   }

   global void execute(Database.BatchableContext BC, List<Account> scope){
	system.debug('Scope size is:' + scope.size());
     for(Account acc : scope){
         String primaryContactEmail = '';
         Map<String,Decimal> oppMap = new Map<String,Decimal>();
		 
         for(Contact c : acc.Contacts){
             if(!String.isBlank(c.Email)){
                 primaryContactEmail = c.Email;
             }   
         }
         for(Opportunity opp: acc.Opportunities){
             oppMap.put(opp.Name,Opp.Amount);
         }     
		 
         contactOppMap.put(primaryContactEmail,oppMap);
         system.debug(contactOppMap.put(primaryContactEmail,oppMap));
     }  
     system.debug('OppMap is :' + contactOppMap);
     system.debug('OppMap size is :' + contactOppMap.size());
    }
 
   global void finish(Database.BatchableContext BC){
       
       String oppName = '';
       Decimal oppAmount = 0;
       Decimal oppAggrAmount = 0;
       for(String contactEmail : contactOppMap.keySet()) {   
           for(String opportunityName:contactOppMap.get(contactEmail).KeySet()){
   				oppName =opportunityName;
                oppAmount = contactOppMap.get(contactEmail).get(opportunityName);
                oppAggrAmount = contactOppMap.get(contactEmail).get(opportunityName);
           }
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               String[] toAddresses = new String[] {contactEmail};
   							mail.setToAddresses(toAddresses);
   mail.setSubject('Closed Won Opportunity details');
   mail.setPlainTextBody
   (' Opportunity Name is: ' + oppName +
   ' Amount is: '+ oppAmount +
   ' Aggregated Amount is: '+ oppAggrAmount);
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           
   
       }
   }
}