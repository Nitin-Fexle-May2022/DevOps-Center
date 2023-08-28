public class Cloudinary_Services {
    
    public static ContentVersion conVer = new ContentVersion(); 
    
    public static Cloudinary_Wrapper uploadResource(Id conId){
        try{ 
            conVer = Cloudinary_Queries.getContentVersionData(conId);
            // Create a new HttpRequest using the Cloudinary_ResponeParser class
            System.HttpRequest request = Cloudinary_RequestBuilder.uploadResource(conVer); 
            System.Http http = new System.Http();
            System.HttpResponse response = http.send(request);
            // Pass the response body to Cloudinary_ResponeParser to parse the JSON
            return Cloudinary_ResponeParser.parseFileResponse(conVer, response);
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
        return null;
    }
    
     public static void downloadResource(Id conId, Cloudinary_Wrapper responseWrapper){
         
         try {
             // Create a new HttpRequest using the Cloudnary_RequestBuilder class
             conVer = Cloudinary_Queries.getContentVersionData(conId);
             System.HttpRequest request = Cloudinary_RequestBuilder.downloadResource(conVer, responseWrapper);   
             // Send the request using an Http object and get the response
             HttpResponse response = new Http().send(request);
             if (response.getStatusCode() == 200) {
                 System.debug('response--->'+response.getBodyAsBlob());
                 Cloudinary_ResponeParser.downloadFileResponse(conVer, response, responseWrapper);
             }
     	}
         catch(Exception ex) {
            System.debug(ex.getMessage());
        } 
            
     }
    
    public static void deleteResource(List<String> publicIds){
        try {
            System.HttpRequest request = Cloudinary_RequestBuilder.deleteResource(publicIds);   
            // Send the request using an Http object and get the response
            System.debug(request);
            HttpResponse response = new Http().send(request);
            System.debug(response.getBody());
        }
        catch(Exception ex) {
            System.debug(ex.getMessage());
        }   
     } 
}