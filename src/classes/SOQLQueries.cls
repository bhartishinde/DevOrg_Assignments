public with sharing class SOQLQueries {	
	//Account ID printing
    public void printPersonAccount()
    {
    	Account[] accs = [SELECT Id FROM Account WHERE Name LIKE '%Account%' ORDER BY Name ASC NULLS FIRST];
    	system.debug('Account Records are :' + accs.size());
    	//traditional for loop
    	for(Integer i=0;i<accs.size();i++)
    	{
    		system.debug('Traditional For Loop Result :' + ' ' + accs[i].id);
    	}
    	//Advanced for loop
    	for(Account a : accs)
    	{
    		system.debug('Advanced For Loop Result :' + ' ' + a.id);
    	}
    }
       
}