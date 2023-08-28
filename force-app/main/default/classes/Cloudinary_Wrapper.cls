public with sharing class Cloudinary_Wrapper {
   
    public String file {get; set;}
    public String timestamp {get; set;}
    public String asset_id { get; set; }
    public String public_id { get; set; }
    public Integer version { get; set; }
    public String version_id { get; set; }
    public String transformation { get; set; }
    public String signature { get; set; }
    public Integer width { get; set; }
    public Integer height { get; set; }
    public String format { get; set; }
    public String resource_type { get; set; }
    public Datetime created_at { get; set; }
    public List<String> tags { get; set; }
    public Integer bytes { get; set; }
    public String type { get; set; }
    public String etag { get; set; }
    public Boolean placeholder { get; set; }
    public String url { get; set; }
    public String secure_url { get; set; }
    public String folder { get; set; }
    public String original_filename { get; set; }
    public String original_extension { get; set; }
    public String api_key { get; set; }
    public Boolean overwritten { get; set; }
}