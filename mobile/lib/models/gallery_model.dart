class GalleryModel{
  int id;
  String url;

  GalleryModel({
    required this.id,
    required this.url
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json){
    return GalleryModel(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'url': url,
    };
  }
}