public class SummeryController {
    public PageReference validateApplication() {
        
        if(appSummery.Asset__r.Price__c > appSummery.Total_Loan_Amount__c){
            return null;
        }else{
            return Page.application_list;
        }
    }
    
    public Application__c appSummery;
    
    public SummeryController (){
        Id appId= apexpages.currentpage().getparameters().get('applicationId');
        if(appId != Null){
            appSummery = [SELECT Id, Name, Address__c, App_Number__c, Contact__c, Total_Loan_Amount__c,
            Asset__r.Name, Asset__r.Price__c, Asset__r.Condition__c, Asset__r.Model__c, Asset__r.Year__c,
            Guarantor__r.Name, Guarantor__r.Contact_Number__c, Guarantor__r.isPrimary__c, Guarantor__r.Percent_of_guranty__c, Guarantor__r.Relationship__c 
            FROM Application__c WHERE Id = :appId];
        }
    }
    
    public Application__c getAppSummery(){
        return appSummery;
    }
}