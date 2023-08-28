global class Cloudinary_ServicesMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);

        String responseBody = '';

        if(req.getMethod() == 'POST'){
            System.debug('inside method');
            responseBody = '{"asset_id":"5d0d5c5ae659c95c576434df65a44598","public_id":"IMG_1701","version":1692348197,"version_id":"6bd4ae75ab88f07c25957ccd1578fa12","signature":"be7e82029373d192ec1ec0e2db3141611bb97012","width":4032,"height":3024,"format":"jpg","resource_type":"image","created_at":"2023-08-18T08:43:17Z","tags":[],"bytes":1828769,"type":"upload","etag":"624b7a8f032c691e2fee0447b73667bc","placeholder":false,"url":"http://res.cloudinary.com/dbpmfgtmu/image/upload/v1692348197/IMG_1701.jpg","secure_url":"https://res.cloudinary.com/dbpmfgtmu/image/upload/v1692348197/IMG_1701.jpg","folder":"","overwritten":true,"api_key":"697891327624145"}';           
        	response.setBody(responseBody);
        }
        if(req.getMethod() == 'GET' && (req.getEndpoint().contains('https://res.cloudinary.com/dbpmfgtmu/image/upload'))) {
        	response.setBodyAsBlob(Blob.valueOf('Mock response content'));
        }
        if(req.getMethod() == 'DELETE') {
            responseBody = '{"message":"resource has Been Deleted"}';
            response.setBody(responseBody);
        }
        
        return response; 
    }
}