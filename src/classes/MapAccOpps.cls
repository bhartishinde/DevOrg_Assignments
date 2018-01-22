public with sharing class MapAccOpps {
    public void mapAccOpps()
    {
    	Account[] Accs = [SELECT Id FROM Account];
    	system.debug('Account Records are :' + Accs.size());
    	
    	//Adding map with Key-OppID and Value-AccID
    	Map<String,List<String>> acc_opps = new Map<String,List<String>>();
    	//Opportunity[] opps = [SELECT Id FROM Opportunity];
    	
    	for(Account a:Accs)
    	{
    		List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE AccountId =: a.Id];
    		List<String> oppIds = new List<String>();
    		for(Opportunity o:opps)
    		{
    			oppIds.add(o.Id);
    		}
    		acc_opps.put(a.Id,oppIds);
    	}
    	
    	//printing result
    	system.debug('Map-Acc-Opps :' + ' ' + acc_opps); 
    	
    	 	
    }
}