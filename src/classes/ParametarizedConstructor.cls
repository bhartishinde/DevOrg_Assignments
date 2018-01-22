public with sharing class ParametarizedConstructor {   
		public ParametarizedConstructor()
    	{
    		system.debug('Constructor with No paramerer');
    	}  
    	public ParametarizedConstructor(String str)
    	{
    	 	String printPara = str;
    		system.debug(printPara + ' ' + 'in' + ' ' + 'parametarized Constructor');
    	}  	   
}