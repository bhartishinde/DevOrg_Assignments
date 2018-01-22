//trigger caseUpdate on Case (before Update,before Insert, after Update, after Insert) {
trigger caseUpdate on Case (before Update,before Insert, after Update, after Insert) {
    TriggerSetting__c settings = TriggerSetting__c.getInstance();
    Boolean triggerToEnable = settings.caseUpdate__c;
    
    if(triggerToEnable == true){
    List<Case> cObj = new List<Case>();
    if(Trigger.isInsert)
    {
        if(Trigger.isBefore)
            {               
                //cObj = ProgrammingModel_3.returnCaseList(Trigger.new);
                ProgrammingModel_3.returnCaseList(Trigger.new);
            }
        if(Trigger.isAfter)
            {
                //ProgrammingModel_3.updateCaseList(cObj);
            }
    }
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
            {
                 //cObj = ProgrammingModel_3.returnCaseList(Trigger.new);
                 ProgrammingModel_3.returnCaseList(Trigger.new);
            }
        if(Trigger.isAfter)
            {
                ProgrammingModel_3.updateCaseList(cObj);
            }
    }
   }
}