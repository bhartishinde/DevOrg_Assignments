global with sharing class BatchForJSON implements Database.Batchable<sObject>,Database.Stateful{
  	public class sObjectDetails {
    	public String Name;
        public String ObjectName;
    	
	}
 
   global Database.QueryLocator start(Database.BatchableContext BC){
      //return null;
      return Database.getQueryLocator([SELECT JSON__c FROM Account]);
   }

   global void execute(Database.BatchableContext BC, List<Account> scope){
  	
     List<Account> accList = new List<Account>();
     for(Account acc:scope)
     {
         if(String.isNotEmpty(acc.JSON__c)){
             sObjectDetails jsonObj = (sObjectDetails)JSON.deserializeStrict(acc.JSON__c,sObjectDetails.class);
             //check for Object exists or not then only create
             Schema.SObjectType targetObj = Schema.getGlobalDescribe().get(jsonObj.ObjectName);
             system.debug(targetObj);
             if(targetObj == null){//create object     
                 //sObject sObj = Schema.getGlobalDescribe().newSObject();
                 //system.debug('newly created object is:' + sObj);
                 
                 //targetObj__c newObj = targetObj__c.newSObject();
             }
             else{//insert records               
                 Account a =  (Account)targetObj.newSObject();
                 a.Name = jsonObj.Name;
                 accList.add(a);
             }
         }
	 }
       system.debug(accList);
       insert accList;
       system.debug('Record inserted successfully');
    }
 
   global void finish(Database.BatchableContext BC){

       }
   
}