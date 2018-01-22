public with sharing class ReplaceOccurance {
    public void replace(String c,String[] stringArray){
    	//String[] newStringArray = new String[]{'abba','styajua'};
    	String[] newStringArray = new String[]{};
    	system.debug('Previous String Array :' + ' ' + stringArray);
    	for (String i : stringArray) {
    		newStringArray.add(i.replace('a','s'));   				}
    	system.debug('new String Array :' + ' ' + newStringArray);
    	
    }
}