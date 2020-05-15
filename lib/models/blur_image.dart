class BlurImage {
  String hash;
  String url;
  String fileName;

  BlurImage({this.hash, this.url, this.fileName});

  BlurImage.fromJson(Map<String, dynamic> json)
      : hash = json["hash"],
        url = json["url"],
        fileName = json["fileName"];

  Map<String, dynamic> toJson() =>
      {"hash": hash, "url": url, "fileName": fileName};
}
