public with sharing class OpportunityManipulation {
    public void opportunityOperations()
    {
    	Opportunity[] opps = [SELECT AccountId,Id FROM Opportunity WHERE AccountId != null AND IsClosed = true];
    	system.debug('Opportunity Records are from Query :' + opps.size());
    	//adding opportunity Ids to List
    	List<String> oppIds = new List<String>();
    	//Adding opportunity Account Ids to Set
    	Set<String> accIds = new Set<String>();
    	//Adding map with Key-OppID and Value-AccID
    	Map<String,String> opp_acc = new Map<String,String>();
    	for(Opportunity o : opps)
    	{
    		oppIds.add(o.Id);
    		accIds.add(o.AccountId); 
    		opp_acc.put(o.Id,o.AccountId);
    	}
    	//printing result
    	system.debug('List-Opportunity Ids are :' + ' ' + oppIds);
    	system.debug('Set-Opportunity Account Ids are :' + ' ' + accIds); 
    	system.debug('Map-Opportunity-Account map :' + ' ' + opp_acc);  	  	
    }
}