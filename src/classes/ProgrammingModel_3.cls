public with sharing class ProgrammingModel_3 {
	public static void returnCaseList(List<Case> caseList)
    {
        List<Case> casesToUpdate = new List<Case>();

        Map<String, String> emailContactMap = new Map<String, String>();
        for(Case caseObj : caseList)
   		 {
             if (!String.isBlank(caseObj.SuppliedEmail)) {
             	emailContactMap.put(caseObj.SuppliedEmail,null);
             }
         }
        System.debug('Set of Email IDs' + ' ' + emailContactMap.keySet());

        For(Contact contactObj : [Select Email,AccountId From Contact Where Email IN : emailContactMap.keySet()])
        {
            emailContactMap.put(contactObj.Email,contactObj.Id);
        }
      	system.debug('emailContactMap' + ': ' + emailContactMap);
    	for (Case caseObj: caseList) {
  			if (!emailContactMap.isEmpty()) {
   				if (emailContactMap.containskey(caseObj.SuppliedEmail)) {
    				caseObj.ContactId = emailContactMap.get(caseObj.SuppliedEmail);
   					}
  				}
 		casesToUpdate.add(caseObj);
 		}
      
        //return casesToUpdate;
	}
    
    public static void updateCaseList(List<Case> caseList)
    {
        system.debug('in updateCaseList method');
        system.debug(caseList);
        update caseList;
    }
    
    private static boolean run = true;
    public static boolean runOnce(){
    if(run){
     	run=false;
     	return true;
    	}
        else{
        return run;
    		}
    	}
    
    public void trigger_1(Account[] acc)
    {
        //Account[] acc = Trigger.new;
        system.debug('in trigger 1 method');
		system.debug(acc);
	}
   
}