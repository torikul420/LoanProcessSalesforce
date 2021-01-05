public class ApplicationController {
    
    public List<Application__c> getApplications() {
        List<Application__c> results = Database.query(
            'SELECT Id,Name, Address__c, App_Number__c, Asset__c, Contact__c, Guarantor__c, Total_Loan_Amount__c FROM Application__c'
        );
        return results;
    }
    
    public Application__c app { get; set; }
    public Application__c appSummery;
    
    public ApplicationController(){
        app = new Application__c();

        Id appId= apexpages.currentpage().getparameters().get('applicationId');
        if(appId != Null){
            appSummery = [SELECT Id, Name, Address__c, App_Number__c, Asset__c, Contact__c, Guarantor__c, Total_Loan_Amount__c  FROM Application__c WHERE Id = :appId];
        }
    }
    
    public Application__c getAppSummery(){
        return appSummery;
    }
    
    public PageReference newApplication(){
        return Page.application_new;
    }
    
    public PageReference saveApplication() { 
        try{
            insert app;
        }catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        PageReference myVFPage = new PageReference('/apex/asset_list');
        myVFPage.setRedirect(true);
        myVFPage.getParameters().put('applicationId', app.Id);
        return myVFPage;
    }
}