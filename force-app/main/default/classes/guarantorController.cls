public class guarantorController {

    public List<Guarantor__c> getGuarantors() {
        List<Guarantor__c> results = Database.query(
            'SELECT Id,Name, Contact_Number__c, isPrimary__c, Percent_of_guranty__c, Relationship__c FROM Guarantor__c'
        );
        return results;
    }
    
    public PageReference newGuarantor() {
        return Page.guarantor_new;
    }
    
    public PageReference step2() {
        return Page.asset_list;
    }
    
    public PageReference step3() {
        //return Page.gurantor_list;
        return null;
    }
    
    public Guarantor__c guarantor{ get; set; }
    public Application__c app;
    
    public GuarantorController(){
        
        Id guarantorId = ApexPages.currentPage().getParameters().get('guarantorId');
        guarantor= (guarantorId == null) ? new Guarantor__c() : 
            [SELECT Name, Contact_Number__c, isPrimary__c, Percent_of_guranty__c, Relationship__c FROM Guarantor__c WHERE Id = :guarantorId];
    
        Id appId= apexpages.currentpage().getparameters().get('applicationId');
        if(appId != Null){
            app = [SELECT Id, Name, Guarantor__c FROM Application__c WHERE Id = :appId];
        }
    }
    
    public Application__c getApp(){
        return app;
    }
    
    public PageReference updateApplication(){
        try{
            update app;
        }catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        PageReference myVFPage = new PageReference('/apex/application_summery');
        myVFPage.setRedirect(true);
        myVFPage.getParameters().put('applicationId', app.Id);
        return myVFPage;
    }
    
    public PageReference saveGuarantor() {
        try {
            upsert guarantor;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        return Page.guarantor_list;
    }
    
    public PageReference cancel() {
        return Page.guarantor_list;
    }
}