public class Cloudinary_RequestBuilder {
    
    //Method to build request 
    public static HttpRequest buildRequest(String endpointName, String methodType, String body) {
        Cloudinary_Master_Settings__c cloudinarySettings = Cloudinary_Master_Settings__c.getOrgDefaults();
        String endPoint = cloudinarySettings.End_Point__c + cloudinarySettings.Cloud_Name__c + Cloudinary_Queries.getMehodNameByName(endpointName);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod(methodType);
        if(methodType == 'DELETE') {
            String username = cloudinarySettings.API_Key__c;
            String password = cloudinarySettings.API_Secret__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'BASIC ' +EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader); 
        }
        req.setHeader('Content-Type', 'application/json');
        if (body != null) {
            req.setBody(body);
        }
        return req;
    }
    
    public static HttpRequest uploadResource(ContentVersion conVer) {
        //Call the buildRequest method to generate the HttpRequest object
        return buildRequest(
            Cloudinary_Constants.ENDPOINT_DEVELOPER_NAME_UPLAOD_IMAGE_API,
            Cloudinary_Constants.METHOD_TYPE_POST,
            Cloudinary_JSONBodyBuilder.createJSON(conVer)
        );
    }
    
    public static HttpRequest downloadResource(ContentVersion conVer,Cloudinary_Wrapper responseFile) {
        HttpRequest imageRequest = new HttpRequest();
        imageRequest.setEndpoint(responseFile.secure_url);
        System.debug('responseFile.secure_url--->'+responseFile.secure_url);
        imageRequest.setMethod('GET'); 
        return imageRequest;
    }
    
    public static HttpRequest deleteResource(List<String> publicIds) {
       return buildRequest(
            Cloudinary_Constants.ENDPOINT_DEVELOPER_NAME_RESOURCE_API,
            Cloudinary_Constants.METHOD_TYPE_DELETE,
            Cloudinary_JSONBodyBuilder.createJSONForDeleteResource(publicIds)
        );
    }
}