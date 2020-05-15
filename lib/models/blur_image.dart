class BlurImage {
  String hash;
  String url;
  String filePath;

  BlurImage({this.hash, this.url, this.filePath});

  BlurImage.fromJson(Map<String, dynamic> json)
      : hash = json["hash"],
        url = json["url"],
        filePath = json["filePath"];

  Map<String, dynamic> toJson() =>
      {"hash": hash, "url": url, "filePath": filePath};
}
