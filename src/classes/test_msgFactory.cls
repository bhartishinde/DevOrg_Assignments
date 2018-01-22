public with sharing class test_msgFactory {

	public Boolean wasMessageAdded(ApexPages.Message[] pageMsgs, String expectedMsg, Integer index) {
    Boolean messageFound = false;
    if(pageMsgs[index].getSummary() == expectedMsg)
     	messageFound = true;

     return messageFound;
}
    
    public Boolean wasInfoSeverity(ApexPages.Message[] pageMsgs, String expectedMsg, Integer index) {
    Boolean infoSeverity = false;
    if(pageMsgs[index].getSeverity()  == ApexPages.Severity.INFO)
     	infoSeverity = true;

     return infoSeverity;
}
    
    public Boolean wasErrorSeverity(ApexPages.Message[] pageMsgs, String expectedMsg, Integer index) {
    Boolean errorSeverity = false;
    if(pageMsgs[index].getSeverity() == ApexPages.Severity.ERROR)
     	errorSeverity = true;

     return errorSeverity;
}

}