public with sharing class ContactRecords {
    public void printPersonAccount()
    {
    	Contact[] cont = [SELECT LastName FROM Contact WHERE LastModifiedDate = TODAY];
    	system.debug('Contact Records count is :' + cont.size());
    	system.debug('Contact Records are :' + cont);
    }
}