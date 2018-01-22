public with sharing class Demonstration {
	public void demoQueryMethod()
    {
    	//database.search method 
 		Account[] Accs = [SELECT Id FROM Account];
    	system.debug('Account Records are :' + Accs.size());
    	
    	//Adding map with Key-OppID and Value-AccID
    	Map<String,List<String>> acc_opps = new Map<String,List<String>>();
    	
    	for(Account a:Accs)
    	{
    		//List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE AccountId =: a.Id];
    		string accID = a.Id;
    		//first way - working
    		//string query = 'SELECT Id FROM Opportunity WHERE AccountId = :accID'; => pass this string to method
    		//first way in other way - working
    		List<Opportunity> opps = Database.query('SELECT Id FROM Opportunity WHERE AccountId =:accID');
    		
    		//2nd way - not working
    		//List<Opportunity> opps = Database.query('SELECT Id FROM Opportunity WHERE AccountId = ' + accID);
    		
    		//3rd way - not working
    		//string query = 'SELECT Id FROM Opportunity WHERE AccountId = ' +accID;
    		//List<Opportunity> opps = Database.query(query);
    		
    		List<String> oppIds = new List<String>();
    		for(Opportunity o:opps)
    		{
    			oppIds.add(o.Id);
    		}
    		acc_opps.put(a.Id,oppIds);
    	}
    	
    	//printing result
    	system.debug('Query Map-Acc-Opps :' + ' ' + acc_opps);
    }
	
    public void demoSearchMethod ()
    {   	
    	String searchquery='FIND\'Edge*\'IN ALL FIELDS RETURNING Account(id,name),Contact, Lead';

		List<List<SObject>> searchList=search.query(searchquery);
		//find method
		//suggest method
		
		system.debug(searchList);   
    }
    
    
    
    
    
}