global with sharing class SOAPExecution
{
    global class LeadResponse
    {
        webservice string lead;
        webservice string status;
        webservice string isSuccess;
    }
    
    webservice static string getLead()
    {
        return 'SOAP Get method';
    }
    
    webservice static LeadResponse createLead(string firstName,string lastName, Date follwUpDate, String company, String email, string phone)
    {
        Lead thisLead = new Lead();
        
        thisLead.FirstName = firstName;
        thisLead.LastName = lastName;
        thisLead.Follow_up__c= follwUpDate;
        thisLead.Company= company;
        thisLead.Email= email;
        thisLead.Phone= phone;
        
        LeadResponse res = new LeadResponse();
        
        try{
            insert thisLead;
            res.status ='Status:Success'; res.isSuccess = 'isSuccess:true';    
            }
        catch(DMLException ex){
            res.status ='Status:Failure'; res.isSuccess = 'isSuccess:false,'+ex.getMessage();
        }
        
        res.lead=thisLead.Id;
        return res;
    }
    
    webservice static LeadResponse deleteLead(string firstName, string lastName, string email, string phone)
    {   
        LeadResponse res = new LeadResponse();
        Lead thisLead = [SELECT Name FROM Lead WHERE FirstName =:firstName  AND LastName =:lastName  AND Email =:email  AND Phone =:phone ];
        
         try{
                res.lead = thisLead.Name;
                delete thisLead;
                res.status ='Status:Success'; res.isSuccess = 'isSuccess:true';
            }
        catch(DMLException ex){
            res.status ='Status:Failure'; res.isSuccess = 'isSuccess:false,'+ex.getMessage();
        } 
        return res;
    }
    
    webservice static LeadResponse updateLead(string firstName, string lastName , string newEmail, string newPhone)
    {
        LeadResponse res = new LeadResponse();
        Lead thisLead = [SELECT Name FROM Lead WHERE FirstName =:firstName  AND LastName =:lastName];
        
         try{
                thisLead.Email = newEmail;
                thisLead.Phone = newPhone;
                update thisLead;
                res.status ='Status:Success'; res.isSuccess = 'isSuccess:true';
            }
        catch(DMLException ex){
            res.status ='Status:Failure'; res.isSuccess = 'isSuccess:false,'+ex.getMessage();
        }
        
        res.lead=thisLead.Id;
        return res;
    }
}