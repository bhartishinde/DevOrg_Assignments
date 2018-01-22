public with sharing class CS_regFormController{

    public Student__c student {get; set;}
    public String selectedValue;
    public List<SelectOption> langList{get;set;}
     
    public String getSelectedValue() {
            return selectedValue;
        }

    public void setSelectedValue(String selectedValue) {
            this.selectedValue = selectedValue;
        }
    
    public CS_regFormController(ApexPages.StandardController controller)
    {
        langList = getLang();
        this.student = (Student__c)controller.getRecord();
    }
    
    public List<SelectOption> getLang()
    {
        List<SelectOption> langOptions = new List<SelectOption>();
        langOptions.add(new SelectOption('en_US','English'));
        langOptions.add(new SelectOption('fr','French'));
        langOptions.add(new SelectOption('es','Spanish'));
        
        return langOptions;
    }
    
    public void submitForm()
    {
        Student__c std = new Student__c();
        std.Name = student.Name;
        std.Gender__c = student.Gender__c;
        std.Roll_Number__c= student.Roll_Number__c;
        
        insert std;
        PageUtility.showInfo('Your admission application has been submitted successfully');
                
        
    }
    
    public pagereference onChange_langSelect()
    {
        PageReference redirect = new PageReference ('/apex/CS_StudentRegForm?lang=' + selectedValue);
        redirect.getRedirect();
        return redirect;

        return null;
    }
    
}