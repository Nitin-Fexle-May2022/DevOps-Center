@isTest
public class Cloudinary_ServicesTest {
    
        @TestSetup
        static void makeData() {
           
            Blob imageData = Blob.valueOf('Test image content');
            // Insert ContentVersion record
            ContentVersion conToInsert = new ContentVersion();
            conToInsert.Title = 'IMG_1701';
            conToInsert.VersionData = imageData;
            conToInsert.ContentLocation = 'S';
            conToInsert.PathOnClient = 'test-image.jpg';
            
            insert conToInsert;
            
            Cloudinary_Master_Settings__c cloudinarySettings = new Cloudinary_Master_Settings__c(); 
            cloudinarySettings.API_Key__c = '697891327624145';
			cloudinarySettings.API_Secret__c = 'h40rsxdHxBf9Hg-eSVTKbwMou4c'; 
            cloudinarySettings.Cloud_Name__c = 'dbpmfgtmu'; 
            cloudinarySettings.End_Point__c = 'https://api.cloudinary.com/v1_1/';
            
            insert cloudinarySettings;
        }
    
     @isTest static void testUploadResource() {
        
        Test.setMock(HttpCalloutMock.class, new Cloudinary_ServicesMock()); 
        ContentVersion conVersion = [SELECT Id FROM ContentVersion LIMIT 1];
        Test.startTest();
        Cloudinary_Wrapper clodinaryWrapper = Cloudinary_Services.uploadResource(conVersion.Id); 
        Integer callout = Limits.getCallouts();
        Test.stopTest();
              
        System.assertEquals(1, callout);
    }
    
    @isTest static void testDownloadResource() {
        
        Test.setMock(HttpCalloutMock.class, new Cloudinary_ServicesMock()); 
        ContentVersion conVersion = [SELECT Id FROM ContentVersion LIMIT 1];
        Test.startTest();
        Cloudinary_Wrapper clodinaryWrapper = Cloudinary_Services.uploadResource(conVersion.Id);
        Cloudinary_Services.downloadResource(conVersion.Id, clodinaryWrapper);
        Integer callout = Limits.getCallouts();
        Test.stopTest();
        
        List<ContentVersion> conVersionList = [SELECT Id FROM ContentVersion];
        System.assertEquals(2, callout);
        System.assertEquals(2, conVersionList.size());
    }
    
     @isTest static void testDeleteResource() {
        
        Test.setMock(HttpCalloutMock.class, new Cloudinary_ServicesMock()); 
         List<String> publicIds = new List<String>{'Image'};
        Test.startTest();
        Cloudinary_Services.deleteResource(publicIds);
        Integer callout = Limits.getCallouts();
        Test.stopTest();
         
        System.assertEquals(1, callout);
    }
}