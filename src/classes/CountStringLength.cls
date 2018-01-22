public with sharing class CountStringLength {
    public void count(String str){    	
    	system.debug('String is :' + ' ' + str);
    	Integer[] charArray = str.getChars();  
    	integer c = 0; 
    	for(Integer i : charArray) 	   	
    		c++;
    	system.debug('Length of string iz :' + ' ' + c);
    	
    }
}