public with sharing class UpdateAccountName {
    public void updateAccounts()
    {
    	Account[] accs = [SELECT Name FROM Account WHERE Name LIKE 'a%'];
    	system.debug('Account Records to be updated are :' + accs.size());
    	
    	List<Account> updateAccs = new List<Account>();
    	Integer updates = 0;
    	for(Account a:accs)
    	{
    		a.Name = 'Updated via update DML Operation';
    		updateAccs.add(a);
    		updates++;
    	}
    	update updateAccs;
    	system.debug('No of Account Records updated are :' + updates);
	}
	


}