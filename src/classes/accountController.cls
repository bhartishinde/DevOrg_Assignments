public with sharing class accountController{

    public Integer selectedValue = 1;
    
    public List<Account> allAccounts{ get; set;}  
    public List<SelectOption> listviewoptions{get;set;}
    public string detailsPageURL{get;set;}
    public string txtToSearch{get;set;}
    
    //for alphabetical search
    public String AlphaFilter {get; set;}
    public list<String> AlphaList {get; set;}
    private String QueryAccount;
    public String SortFieldSave;
    
    public accountController() {
        listviewoptions = getItems();
        detailsPageURL = 'apex/AccountDetails';
        
        allAccounts = retrieveAllAccounts(selectedValue);
        
        AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
        SortFieldSave = SortField;

        // alpha filter, use page parameter or set default to all
        if (apexpages.currentpage().getparameters().get('alpha') == null) {
            AlphaFilter = 'All';
        } else {
            AlphaFilter = apexpages.currentpage().getparameters().get('alpha');
        }
        
         // list generation
        //BuildQuery();
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','All Accounts'));
        return options;
    }
    
    public PageReference populateAccounts(){
        allAccounts = retrieveAllAccounts(selectedValue);
        txtToSearch = '';
        return null;
    }
    
    public Integer getSelectedValue() {
            return selectedValue;
        }

    public void setSelectedValue(Integer selectedValue) {
            this.selectedValue = selectedValue;
        }

    public List<Account> retrieveAllAccounts(Integer selectedValue)
    {
        List<Account> accColl = new List<Account>();
        
        if(selectedValue == 1)
        {
            accColl =[SELECT Name,Phone,Website FROM Account ORDER BY Name asc];
        }
        
        return accColl;
    }
    
     public void searchAccounts(){
      //ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,'input min 3');
      //ApexPages.addMessage(msg);
      
         if(validate()){
            allAccounts = getSearchResult(txtToSearch);
            
         }
         else{
                PageUtility.showError('Input at least 3 characters to perform search');
             }
        //return null;
    }
    
    public boolean validate()
    {
        if(txtToSearch.length() < 3) return false;
        else return true;
    }

    public List<Account> getSearchResult(String accToSearch)
    {
        List<Account> accColl = new List<Account>();  
        string textInput = '%' + accToSearch + '%';
        accColl = [SELECT Name,Phone,Website FROM Account WHERE Name LIKE : textInput];
        if(accColl.size() > 0) PageUtility.showInfo('Your search matched ' + accColl.size() + ' ' + 'Records');
        else PageUtility.showInfo('No result found');
        return accColl;
    }
    
    public void clearSearch(){
        txtToSearch = '';
        populateAccounts();
    }
    
     public void BuildQuery() {
        //StdSetControllerAccount = null;
        //system.debug('alphafilter is:' + AlphaFilter );
        String QueryWhere = '';
        
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryAccount = 'SELECT Name,Phone,Website ' +' FROM Account'; 
        
        if (AlphaFilter == 'Other') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' < \'A\' OR ' + 
                                    String.escapeSingleQuotes(SortField) + ' > \'Z\') AND (NOT ' + 
                                    String.escapeSingleQuotes(SortField) + ' LIKE \'Z%\') ');
        } else if (AlphaFilter != 'All') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\')' );
        } 
       
        
        QueryAccount += QueryWhere;
        QueryAccount += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        
        system.debug('QueryAccount:' + QueryAccount);
        allAccounts = Database.query(QueryAccount);
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' WHERE ' + Cond;
        } else {
            return QW + ' AND ' + Cond;
        }
    }
    
    /***
    * SortDirection - return sort direction. Default ascending(asc)
    ***/
    public String SortDirection {
        get { if (SortDirection == null) {  SortDirection = 'asc'; } return SortDirection;  }
        set;
    }
    
     /***
    * SortField - return sort by field. Default to Name
    ***/
    public String SortField {
        get { if (SortField == null) {SortField = 'Name'; } return SortField;  }
        set; 
    }
    
    @RemoteAction
    public static void deleteAccount(string deleteId){
      
      Account[] doomedAcct = [SELECT Id, Name FROM Account WHERE id =: deleteId];
      delete doomedAcct;

      //List<Account> allAccounts = [SELECT Id, Name FROM Account WHERE id =: deleteId];
      
      //system.debug('account is : ' + allAccounts );
    }
    

}