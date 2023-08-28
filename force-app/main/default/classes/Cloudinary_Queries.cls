public class Cloudinary_Queries {
    
   public static String getMehodNameByName(String metadataName) {
        
        // SOQL query to retrieve the method_name__c field from Cloudnary__mdt based on the metadata name
        List<Cloudinary_API__mdt> methodsName = [Select Method_Name__c FROM Cloudinary_API__mdt Where DeveloperName =: metadataName];
        if(methodsName.size() == 0)
           throw new Cloudinary_Exception(Cloudinary_Constants.ENDPOINT_NOT_FOUND);
        return methodsName[0].Method_Name__c;
    }
    
    // SOQL query to retrieve the ContentVersion data
    public static ContentVersion getContentVersionData(Id conId) {
        return [Select Id, Title, VersionData,FirstPublishLocationId,ContentDocumentId From ContentVersion Where Id =: conId LIMIT 1];
    } 
}