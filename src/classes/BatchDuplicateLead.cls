global with sharing class BatchDuplicateLead implements Database.Batchable<sObject>,Database.Stateful{   
    global Set<String> fieldValues;
    global Map<String , Lead> leadMap = new Map<String , Lead>();
    String fieldToCompare = '';
 
   global Database.QueryLocator start(Database.BatchableContext BC){
      LeadUniqueness__c settings = LeadUniqueness__c.getInstance();
      fieldToCompare = settings.FieldName__c;
      string query = 'Select' + ' ' + fieldToCompare + ' ' + 'from Lead where' + ' ' +fieldToCompare + ' ' + '!= null';
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Lead> scope){
        Set<String> fieldValues = new Set<String>();
        List<Lead> duplicatelist = new List<Lead>();
       
       for(Lead s : scope){
           if(!leadMap.containsKey((String)s.get(fieldToCompare))){
                leadMap.put((String)s.get(fieldToCompare) , s);
            }
            else{
                duplicatelist.add(s);          
            }                       
        }
       system.debug('duplicatelist is :' + duplicatelist);
        if(duplicatelist.size() > 0){
            delete duplicatelist;
        }

    }
 
   global void finish(Database.BatchableContext BC){
       system.debug('JOb ID id:' + BC.getJobId());
    }

}