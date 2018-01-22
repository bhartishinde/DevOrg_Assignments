public with sharing class UniqueNumbers {
    public void check(List<Integer> numberArray){
		system.debug('Previous No array was :'+ ' ' + numberArray);		
		Set<Integer> uniqueNumbers = new Set<Integer>();
		for (Integer i : numberArray){
    		uniqueNumbers.add(i); // contains distict numbers
			}
		system.debug('Unique No array is :'+ ' ' + uniqueNumbers);
    }
}