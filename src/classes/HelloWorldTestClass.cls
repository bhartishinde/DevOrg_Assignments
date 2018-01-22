@isTest
private class HelloWorldTestClass {
static testMethod void validateHelloWorld() {
       Account b = new Account(Name='Behind the Cloud');
       //System.debug('Price before inserting new book: ' + b.Price__c);
       insert b;
       b = [SELECT Name FROM Account WHERE Id =:b.Id];
       System.debug('Account: ' + b.Name);
       System.assertEquals('Behind the Cloud', b.Name);
    }

}