public with sharing class campaignController
{
    public Integer selectedValue = 1;
    
    public List<Campaign> campaignList{ get; set;}
     
    public List<SelectOption> listviewoptions{get;set;}
    
    public List<Campaign> populateCampaigns{get;set;}
    
    public string detailsPageURL{get;set;}
    
    public campaignController(ApexPages.StandardController controller) {
        listviewoptions = getItems();
        detailsPageURL = 'apex/CM_CampaignDetails';
        
        campaignList = retrieveCampaignCollection(selectedValue);

    }
    
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','Recently Modified'));
        options.add(new SelectOption('2','All Campaigns'));
        options.add(new SelectOption('3','All Active Campaigns'));
        options.add(new SelectOption('4','All Inactive Campaigns'));
        return options;
    }
    
     public PageReference onChange_viewSelect(){
        system.debug('This is the selected list view:' + selectedValue);
     
        campaignList = retrieveCampaignCollection(selectedValue);
       
        return null;
    }
    
    public PageReference populateCampaigns()
    {
        campaignList = retrieveCampaignCollection(selectedValue);
        return null;
    }
    
    public Integer getSelectedValue() {
            return selectedValue;
        }

    public void setSelectedValue(Integer selectedValue) {
            this.selectedValue = selectedValue;
        }

    public List<Campaign> retrieveCampaignCollection(Integer selectedValue)
    {
        List<Campaign> campaignColl = new List<Campaign>();
        
        if(selectedValue == 2)
        {
            campaignColl =[SELECT Name,Status,StartDate,isActive,Type FROM Campaign ORDER BY StartDate DESC NULLS FIRST];
            //System.debug('options : '+campaignColl);
        }
        else if(selectedValue == 3)
        {
            campaignColl =[SELECT Name,Status,StartDate,isActive,Type FROM Campaign WHERE isActive=true ORDER BY StartDate DESC NULLS FIRST];
            //System.debug('options : '+campaignList);
        }
        else if(selectedValue == 4)
        {
            campaignColl =[SELECT Name,Status,StartDate,isActive,Type FROM Campaign WHERE isActive=false ORDER BY StartDate DESC NULLS FIRST];
            //System.debug('options : '+campaignColl);
        }
        else if(selectedValue == 1)
        {
            campaignColl =[SELECT Name,Status,StartDate,isActive,Type FROM Campaign ORDER BY LastModifiedDate DESC NULLS FIRST];
            //System.debug('options : '+campaignColl);
        }
        
        return campaignColl;
    }

    




}