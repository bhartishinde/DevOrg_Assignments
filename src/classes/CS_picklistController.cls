public with sharing class CS_picklistController{

    public String selectedValue;
       
    public List<SelectOption> countryList{get;set;}
    public List<SelectOption> cityList{get;set;}
    
    public String getSelectedValue() {
            return selectedValue;
        }

    public void setSelectedValue(String selectedValue) {
            this.selectedValue = selectedValue;
        }
        
     public CS_picklistController()
     {
         countryList = getCountryList();
         cityList = getCities(selectedValue);
     }
     
     public List<SelectOption> getCountryList() {
        List<Country__c> cs_Country = Country__c.getall().values(); 
        List<SelectOption> options = new List<SelectOption>();
        selectedValue = cs_Country[0].Name;
        for(Country__c country : cs_Country){
            options.add(new SelectOption(country.Name,country.Name));
        }  
      
        return options;
    }
    
     public PageReference onChange_viewSelect(){     
        cityList = getCities(selectedValue); 
       
        return null;
    }
    
    public List<SelectOption> getCities(String selectedValue) {
        List<SelectOption> cityOptions = new List<SelectOption>();   
        List<City__c> respectiveCities = [SELECT Name FROM City__c WHERE Country__c =:selectedValue];     
        
        for(City__c city : respectiveCities)
        {
            cityOptions.add(new SelectOption(city.Name, city.Name));
        } 
      
        return cityOptions;
    }
    
    

}