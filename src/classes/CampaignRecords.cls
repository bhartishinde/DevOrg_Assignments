public with sharing class CampaignRecords {
	public void printCampaignRecords()
    {
    	//Ascending
		Campaign[] camps = [SELECT Name FROM Campaign ORDER BY Name ASC NULLS FIRST LIMIT 10];
    	system.debug('Campaign Records in ASC :' + camps);
    	system.debug('Campaign Records count :' + camps.size());
    	
    	//Descending
    	camps = [SELECT Name FROM Campaign ORDER BY Name DESC NULLS FIRST LIMIT 10];
    	system.debug('Campaign Records Desc :' + camps);
    	system.debug('Campaign Records count :' + camps.size());
    }
}