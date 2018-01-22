public with sharing class CampaignDetailsController {

     public boolean viewMode{get;set;}
     public boolean editMode{get;set;}
     
     public CampaignDetailsController(ApexPages.StandardController controller) {
         viewMode = true;
         editMode = true;
     }

}