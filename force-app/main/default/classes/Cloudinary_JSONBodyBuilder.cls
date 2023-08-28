public with sharing class Cloudinary_JSONBodyBuilder {

    public static Cloudinary_Master_Settings__c cloudnarySettings;

    public static String createJSON(ContentVersion conVer) {
        
        cloudnarySettings = Cloudinary_Master_Settings__c.getOrgDefaults();
        String tstamp = String.valueOf(DateTime.now().getTime() / 1000);
        String base64 = EncodingUtil.base64Encode(conVer.VersionData);
        String file = 'data:image/png;base64,'+base64;
        Cloudinary_Wrapper cloudinary = new Cloudinary_Wrapper();
        cloudinary.api_key = cloudnarySettings.API_Key__c;
        cloudinary.timestamp = tstamp;
        cloudinary.file = file;
        cloudinary.public_id = conVer.Title;
        cloudinary.transformation = 'f_jpg';
        cloudinary.signature = generateSignature(cloudinary);
 
        // Serialize Cloudnary object into a JSON string
        String jsonData = JSON.serialize(cloudinary);
        return jsonData;
    }

   public static String generateSignature(Cloudinary_Wrapper cloudinary) {
        String stringToSign = 'public_id='+cloudinary.public_id+'&timestamp=' + cloudinary.timestamp+'&transformation='+cloudinary.transformation+cloudnarySettings.API_Secret__c;
        return EncodingUtil.convertToHex(Crypto.generateDigest('SHA-1', Blob.valueOf(stringToSign)));
    }
    
    public static String createJSONForDeleteResource(List<String> publicIds) { 
        Map<String, Object> requestBodyMap = new Map<String, Object>();
        requestBodyMap.put('public_ids', publicIds);
        System.debug('JSON.serialize(requestBodyMap)------->'+JSON.serialize(requestBodyMap));
        return JSON.serialize(requestBodyMap);
    }
    
}