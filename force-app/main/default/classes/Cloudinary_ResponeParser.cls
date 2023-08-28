public with sharing class Cloudinary_ResponeParser {

     public static Cloudinary_Wrapper parseFileResponse(ContentVersion conVer, HttpResponse response) {
        
        // Deserialize the JSON response
         if (response.getStatusCode() == 200) {             
             Cloudinary_Wrapper responseFile = (Cloudinary_Wrapper)JSON.deserialize(response.getBody(), Cloudinary_Wrapper.class);
             return responseFile;
         }
         else {
             return null;
         }
    }
    
    public static void downloadFileResponse(ContentVersion conVer, HttpResponse imageResponse, Cloudinary_Wrapper responseWrapper) {
        
        Blob imageData = imageResponse.getBodyAsBlob();
        ContentVersion conToInsert = new ContentVersion();
        conToInsert.Title = responseWrapper.public_id;
        conToInsert.FirstPublishLocationId = conVer.FirstPublishLocationId;
        conToInsert.VersionData = imageData;
        conToInsert.ContentLocation = 'S';
        conToInsert.PathOnClient = responseWrapper.secure_url;      
        insert conToInsert;                
    }
}