public class AssetController {

     public List<Asset_New__c> getAssets() {
        List<Asset_New__c> results = Database.query(
            'SELECT Id,Name, Model__c, Price__c, Year__c, Condition__c FROM Asset_New__c'
        );
        return results;
    }
    
    public PageReference newAsset() {
        return Page.asset_new;
    }
    
    public PageReference step1() {
        return Page.application_list;
    }
    
    public PageReference step2() {
        return Page.guarantor_list;
    }
    
    public Asset_New__c asset{ get; set; }
    public Application__c app;
    
    public AssetController(){
    
        Id assetId = ApexPages.currentPage().getParameters().get('assetId');
        asset= (assetId == null) ? new Asset_New__c() : 
            [SELECT Name, Model__c, Price__c, Year__c, Condition__c FROM Asset_New__c WHERE Id = :assetId];
    
        Id appId= apexpages.currentpage().getparameters().get('applicationId');
        if(appId != Null){
            app = [SELECT Id, Name, Asset__c FROM Application__c WHERE Id = :appId];
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
        
        PageReference myVFPage = new PageReference('/apex/guarantor_list');
        myVFPage.setRedirect(true);
        myVFPage.getParameters().put('applicationId', app.Id);
        return myVFPage;
    }
    
    
    
     public PageReference saveAsset() {
        try {
            upsert asset;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        return Page.asset_list;
    }
    
    public PageReference cancel(){
        return Page.asset_list;
    }
}