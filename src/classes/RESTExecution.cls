@RestResource(urlMapping='/Leads/*')
global with sharing class RESTExecution
{
     global static Map<String, Map<String,String>> responseMap = new Map<String, Map<String,String>>();
     global static Map<String,String> innerMap = new Map<String,String>();
        
    @HttpGet
    global static Map<String, Map<String,String>> getLeads()
    {
        innerMap.put('Status','isSuccess');
        responseMap.put('Lead Name',innerMap);
        
        return responseMap;
        //return 'in REST Get method';
    }
    
    @HttpPost
    global static Map<String, Map<String,String>> createLead()
    {  
        RestRequest request = RestContext.request;
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        Lead thisLead = new Lead();
        for(String fieldName : params.keySet()) {
            String checkForDate = (String)params.get(fieldName);
            if(checkForDate.containsAny('/'))
                thisLead.put(fieldName, Date.parse(checkForDate));
            else
                thisLead.put(fieldName, params.get(fieldName));
        }
        try{
            insert thisLead;
            innerMap.put('Status:Success','isSuccess:true');
            }
        catch(DMLException ex){
            innerMap.put('Status:Failure','isSuccess:false,'+ex.getMessage());
        }
        
        responseMap.put(thisLead.Id,innerMap);
        return responseMap;
        //return 'in REST Post method';
    }
    
    @HttpDelete
    global static Map<String, Map<String,String>> deleteLead()
    {
        RestRequest request = RestContext.request;
        Map<string,string> paramsMap = request.params;
        String firstName = paramsMap.get('FirstName');
        String lastName = paramsMap.get('LastName');
        String email = paramsMap.get('Email');
        String phone = paramsMap.get('Phone');
        
        string leadName = '';
        Lead thisLead = [SELECT Name FROM Lead WHERE FirstName =:firstName  AND LastName =:lastName  AND Email =:email  AND Phone =:phone ];
        
         try{
                leadName = thisLead.Name;
                delete thisLead;
                innerMap.put('Status:Success','isSuccess:true');
            }
        catch(DMLException ex){
            innerMap.put('Status:Failure','isSuccess:false,'+ex.getMessage());
        }
        
        responseMap.put(leadName,innerMap);
        return responseMap;

    }
    
    @HttpPut
    global static Map<String, Map<String,String>> updateLead()
    {
        RestRequest request = RestContext.request;
        Map<string,string> paramsMap = request.params;
        String firstName = paramsMap.get('FirstName');
        String lastName = paramsMap.get('LastName');
        String newEmail = paramsMap.get('NewEmail');
        String newPhone = paramsMap.get('NewPhone');

        Lead thisLead = [SELECT Name FROM Lead WHERE FirstName =:firstName  AND LastName =:lastName];
        
         try{
                thisLead.Email = newEmail;
                thisLead.Phone = newPhone;
                update thisLead;
                innerMap.put('Status:Success','isSuccess:true');
            }
        catch(DMLException ex){
            innerMap.put('Status:Failure','isSuccess:false,'+ex.getMessage());
        }
        
        responseMap.put(thisLead.id,innerMap);
        return responseMap;
    }
    
    
}