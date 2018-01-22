public with sharing class ProgrammingModel_2 {
    public void DML_3()
    {
        //created external id field in Assets named 'Line Item Id'
	}
    
    public void DML_2()
    {
        Account[] a = [SELECT Id FROM Account WHERE Active__c = 'No' AND CreatedDate = LAST_N_DAYS:90];  
        System.debug(a);
        delete a;
        System.debug('Records deleted from Account');
	}
    
    public void DML_1()
    {
        List<Lead> leadList = new List<Lead>();
        List<Logs__c> logsList = new List<Logs__c>();
        Lead leadObj;
        Logs__c logsObj;
        for(Integer i=1;i<=1;i++)
        {
            //leadObj = new Lead(LastName = 'Test' + ' ' + String.valueOf(i));
            leadObj = new Lead(LeadName__c = 'Assign Lead',LastName = 'Last',Follow_up__c =System.today(),Status = 'Open - Not Contacted', Company = 'ESPL');
            leadList.add(leadObj);           
		}
        for(Integer i=2;i<=2;i++)
        {
          	leadObj = new Lead(LeadName__c = 'Assign Lead',LastName = 'Last',Follow_up__c =System.today(),	Status = 'Open - Not Contacted', Company = 'ESPL');
            leadList.add(leadObj);        
		}
        try
        {
        	insert(leadList);
        }
        catch(DmlException de)
        {
            logsObj = new Logs__c(Error__c = de.getMessage());
            logsList.add(logsObj); 
		}
        insert(logsList);
	}
    
    public void SOSL_2()
    {
        //SOSL Limits
		//https://developer.salesforce.com/docs/atlas.en-us.salesforce_app_limits_cheatsheet.meta/salesforce_app_limits_cheatsheet/salesforce_app_limits_platform_soslsoql.htm
    }
    
    public void SOSL_1()
    {
        List<List<SObject>> searchList = [FIND 'test' IN ALL FIELDS RETURNING Account(Name), Contact(Name),Lead(Name),User(Name)];
        System.debug(searchList);
    }
    
	public void parentToChild_1()
	{
    	 List<Account> accList = [select Name,(select Id,Name from Contacts where Name LIKE '%john%') from Account];
        System.debug(accList);
        Map<String, List<String>> aObjectMap = new Map<String,List<String>>();
        for(Account a :accList)
        {
            List<String> cont = new List<String>();
            for(Contact c : a.Contacts)
            {
                cont.add((String)c.Name);              
            }		
            if(cont.size()>0)
               aObjectMap.put((String)a.Name, cont);
        }
        System.debug(aObjectMap);
   	}
    
    public void parentToChild_2()
	{
        List<Account> accOppList = [select Name,(select Id,Name from Opportunities where StageName = 'Closed Won') from Account];
        System.debug(accOppList);
        Map<String, List<String>> aObjectMap = new Map<String,List<String>>();
        for(Account a :accOppList)
        {
            List<String> opportunities = new List<String>();
            for(Opportunity o : a.Opportunities)
            {
                opportunities.add((String)o.Name);              
            }	
            if(opportunities.size() > 0)
            	aObjectMap.put((String)a.Name, opportunities);
        }
        System.debug(aObjectMap);
   	}
    
    public void parentToChild_3()
	{
     	List<A_Object__c> aObjectList = [select Name,(select Id,Name from C_Objects_A__r where Name = 'John') from A_Object__c];
        System.debug(aObjectList);
        Map<String, String> aObjectMap = new Map<String,String>();
        for(A_Object__c a :aObjectList)
        {
            for(C_Object__c c : a.C_Objects_A__r)
            {
                aObjectMap.put((String)a.Name, (String)c.Name);
            }		
        }
        System.debug(aObjectMap);
    }
    
    public void childToParent_2()
	{
        List<C_Object__c> cObjectList = [SELECT A_Object__r.Name,B_Object__r.Name,Name FROM C_Object__c WHERE Name = 'John'];
        Map<String, String> cObjectMap = new Map<String,String>();       
        System.debug(cObjectList.size());
        for(C_Object__c c :cObjectList)
        {
			cObjectMap.put((String)c.Name, 'Parent 1:' + ' ' + (String)c.A_Object__r.Name + ','+'Parent 2:' + ' ' + (String)c.B_Object__r.Name);
        }
        System.debug(cObjectMap);
    }
    
    public void childToParent_1()
	{
        Map<String, String> contactsToAccMap = new Map<String,String>();
        List<Contact> contactList = [SELECT Contact.Name,Account.Name FROM Contact where Contact.AccountId != null AND Status__c = 'Active' AND Industry__c = 'Media'];
        System.debug(contactList);
        for(Contact c :contactList)
        {
			contactsToAccMap.put((String)c.Name, (String)c.Account.Name);
        }
        System.debug(contactsToAccMap);
    }
    
	public void Aggregate_3()
	{
		//List<Lead> leadList = [SELECT LeadSource FROM Lead];
        //system.debug(leadList.size());
		AggregateResult[] groupedResults = [SELECT Status FROM Lead Group By Status];
		system.debug(groupedResults);
        Map<String,Map<String,Integer>> leadMap = new Map<String,Map<String,Integer>>();
		for(AggregateResult g : groupedResults)
        {
            Map<String, Integer> innerMap = new Map<String, Integer>();
            String status = (String)g.get('Status');
            AggregateResult[] sourceResults = [SELECT LeadSource, count(Name) FROM Lead WHERE Status =:status Group By LeadSource];
            for(AggregateResult s : sourceResults)
            {
                innerMap.put((String)s.get('LeadSource'), (Integer)s.get('expr0'));
			}
            leadMap.put(status, innerMap);
		}
		system.debug(leadMap);
	}
	
	public void Aggregate_2()
	{
		AggregateResult[] groupedResults = [SELECT COUNT_DISTINCT(LeadSource) FROM Lead WHERE LeadSource > '10'];
						
		for (AggregateResult ar : groupedResults)  {				
			system.debug('No of distinct Leads are :' + ' ' + ar.get('expr0'));  			
  		}

	}
	
	public void Aggregate_1()
	{
		Integer currentYear = Date.Today().Year();
		system.debug('Current year iz :' + ' ' + Date.Today().Year());
		Map<Integer, Decimal> oppAmountSum = new Map<Integer, Decimal>();
		
		AggregateResult[] groupedResults = [SELECT SUM(Amount) FROM Opportunity  WHERE FiscalYear =: currentYear AND IsClosed != true];
		
		for (AggregateResult ar : groupedResults)  {
  			oppAmountSum.put(currentYear,(Decimal)ar.get('expr0'));
  		}
		system.debug('Opportunity map is :' + ' ' + oppAmountSum);
		
		//iterating throgh map for statistics
		for(Integer key :oppAmountSum.keySet()){
			system.debug('Current year iz :' + ' ' + key);
    		Decimal mapValue = oppAmountSum.get(key);
    		system.debug('Sum of Amount :' + ' ' + mapValue);
			}
		
	}
		
	public void SOQL_6()
    {    	
    	List<Opportunity> oppList = [SELECT CreatedDate,Name FROM Opportunity WHERE Amount > 10000 ORDER BY CreatedDate ASC NULLS FIRST LIMIT 100 OFFSET 5];
    	    	
    	system.debug('Count of oppList :' + ' ' + oppList.size());
    	system.debug('oppList is :' + ' ' + oppList);    	    	
    }
	
	public void SOQL_5()
    {
    	 //List<Account> exludesStateAcc = [SELECT Name, MultiState__c FROM Account where MultiState__c Excludes ('Maharashtra', 'Kerala') ORDER BY MultiState__c DESC NULLS FIRST LIMIT 10000];
    	 List<Account> exludesStateAcc = [SELECT Name, MultiState__c FROM Account where MultiState__c Excludes ('Maharashtra', 'Kerala') LIMIT 10000];
         system.debug('Count of excluding States :' + ' ' + exludesStateAcc.size());
    	 system.debug('Acc Names with States :' + ' ' + exludesStateAcc);  
    }
	
	public void SOQL_4()
    {
    	//String year1 = '2010';
    	//List<String> year2 = List<String>(){'2013','2014'};
    	List<Account> enrollYearIncludes = [SELECT Enrollment_Year__c,Name FROM Account WHERE Enrollment_Year__c INCLUDES ('2010') OR Enrollment_Year__c INCLUDES ('2013','2014')];
    	    	
    	system.debug('Count of enrollYearIncludes :' + ' ' + enrollYearIncludes.size());
    	system.debug('Acc Names of enrollYearIncludes :' + ' ' + enrollYearIncludes);    	    	
    }
	
	public void SOQL_3()
    {
    	List<Account> accList = [SELECT Id,Name FROM Account];
    	Map<String,String> accMap_1 = new Map<String,String>();
    	Map<String,Account> accMap_2 = new Map<String,Account>();
    	for(Account a : accList)
    	{
    		accMap_1.put(a.Name,a.Id);
    		accMap_2.put(a.Id,a);
    	}
    	system.debug('Count of Account_1 :' + ' ' + accMap_1.size());
    	system.debug('Map of Account_1 :' + ' ' + accMap_1);
    	
    	system.debug('Count of Account_2 :' + ' ' + accMap_2.size());
    	system.debug('Map of Account_2 :' + ' ' + accMap_2);
    }
	
	public void SOQL_2()
    {
    	List<User> userList = [SELECT Id,Name,Username FROM User WHERE IsActive = true];
    	Map<String,User> userMap = new Map<String,User>();
    	system.debug('Count of Active Users :' + ' ' + userList.size());
    	for(User u : userList)
    	{
    		userMap.put(u.Id,u);
    	}
    	system.debug('Map of Active Users :' + ' ' + userMap);
    }
	
    public void SOQL_1()
    {
    	List<Contact> contactList = [SELECT AccountId,Name FROM Contact];
    	system.debug('List of Contacts :' + ' ' + contactList);
    }
}