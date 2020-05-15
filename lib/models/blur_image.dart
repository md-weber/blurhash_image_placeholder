class BlurImage {
  String hash;
  String downloadUrl;
  String fileName;

  BlurImage({this.hash, this.downloadUrl, this.fileName});

  BlurImage.fromJson(Map<String, dynamic> json)
      : hash = json["hash"],
        downloadUrl = json["downloadUrl"],
        fileName = json["fileName"];

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "downloadUrl": downloadUrl,
        "fileName": fileName
      };
}
