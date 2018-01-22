trigger cloneRecord on Lead (after Insert) {

    TriggerSetting__c settings = TriggerSetting__c.getInstance();
    Boolean triggerToEnable = settings.cloneRecord__c;
    
    if(triggerToEnable == true){
    if(ProgrammingModel_3.runOnce())
    {
        List<Lead> leadsList = new List<Lead>();
        for(Lead leadObj : Trigger.new)
        {
            Lead cloneLead = leadObj.clone(false,false,false,false);
            leadsList.add(cloneLead );
        }
        system.debug(leadsList);
        insert leadsList;
    }
  }
}