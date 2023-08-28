public class CloudinaryBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    private String dynamicQuery;
    public CloudinaryBatch(String query) {
        dynamicQuery = query;
    }

    public Iterable<sObject> start(Database.BatchableContext context) {
        return Database.query(dynamicQuery);
    }

    public void execute(Database.BatchableContext context, List<sObject> scope) {
        Set<Id> recordIds = new Set<Id>();
        for (sObject record : scope) {
            Cloudinary_Wrapper responseFile = Cloudinary_Services.uploadResource((Id)record.get('Id'));
            Cloudinary_Services.downloadResource((Id)record.get('Id'),responseFile);
        }
    }

    public void finish(Database.BatchableContext context) {
        // Batch finish logic if needed'
        
    }
}