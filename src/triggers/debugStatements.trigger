trigger debugStatements on Account (before Insert,after Insert,
                                 before Update, after Update, 
                                 before Delete, after Delete,
                                 after unDelete) {
    TriggerSetting__c settings = TriggerSetting__c.getInstance();
    Boolean triggerToEnable = settings.debugStatements__c;
      
    if (triggerToEnable == true){  
    if(Trigger.isInsert)
    {
        if(Trigger.isBefore)
        {
            system.debug('before Insert : Trigger.new');
            system.debug(Trigger.new);
            system.debug('before Insert : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('before Insert : Trigger.old');
            system.debug(Trigger.old);
            system.debug('before Insert : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
        if(Trigger.isAfter)
        {
            system.debug('after Insert : Trigger.new');
            system.debug(Trigger.new);
            system.debug('after Insert : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('after Insert : Trigger.old');
            system.debug(Trigger.old);
            system.debug('after Insert : Trigger.oldMap');
            system.debug(Trigger.oldMap);
            
            //create task
            List<Task> newTasks = new List<Task>();
            for(Account a : Trigger.new)
            { 
                Task t = new Task();
                
                t.Subject = 'Meeting with' + ' ' + a.Name;
                t.OwnerID = a.OwnerID;
                t.WhatID=a.Id;
                t.Status = 'Not Started';
                
                newTasks.add(t);
            }
            system.debug(newTasks);
            insert newTasks;
        }
    }
                                     
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            system.debug('before Update : Trigger.new');
            system.debug(Trigger.new);
            system.debug('before Update : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('before Update : Trigger.old');
            system.debug(Trigger.old);
            system.debug('before Update : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
        if(Trigger.isAfter)
        {
            system.debug('after Update : Trigger.new');
            system.debug(Trigger.new);
            system.debug('after Update : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('after Update : Trigger.old');
            system.debug(Trigger.old);
            system.debug('after Update : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
    }
     
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
            system.debug('before Delete : Trigger.new');
            system.debug(Trigger.new);
            system.debug('before Delete : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('before Delete : Trigger.old');
            system.debug(Trigger.old);
            system.debug('before Delete : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
        if(Trigger.isAfter)
        {
            system.debug('after Delete : Trigger.new');
            system.debug(Trigger.new);
            system.debug('after Delete : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('after Delete : Trigger.old');
            system.debug(Trigger.old);
            system.debug('after Delete : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
    }
     
    if(Trigger.isUndelete)
    {
        //will not show any result bcoz - only after is supported in undelete
        /*if(Trigger.isBefore)
        {
            system.debug('before unDelete : Trigger.new');
            system.debug(Trigger.new);
            system.debug('before unDelete : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('before unDelete : Trigger.old');
            system.debug(Trigger.old);
            system.debug('before unDelete : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }*/
        if(Trigger.isAfter)
        {
            system.debug('after unDelete : Trigger.new');
            system.debug(Trigger.new);
            system.debug('after unDelete : Trigger.newMap');
            system.debug(Trigger.newMap);
            system.debug('after unDelete : Trigger.old');
            system.debug(Trigger.old);
            system.debug('after unDelete : Trigger.oldMap');
            system.debug(Trigger.oldMap);
        }
    }
   }
}