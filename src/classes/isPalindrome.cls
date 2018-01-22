public with sharing class isPalindrome {
    public void checkP(String sh){
    	Integer flag = 0;
    	String reversed = sh.reverse();
    	//to have case insensetive
    	//if(sh.toLowerCase().equals(reversed.toLowerCase()))
    	if(sh.equals(reversed))
    	  flag = 1;
    	  
    	if(flag == 1)  
    		system.debug('String' + ' ' + 'is a palindrome');
    	else	
    		system.debug('String' + ' ' + 'is not a palindrome');
    }
}