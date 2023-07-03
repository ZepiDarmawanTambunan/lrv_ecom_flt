String baseUrl = 'http://192.168.1.7:8000/storage/product_images';

class GalleryModel{
  int id;
  String url;

  GalleryModel({
    required this.id,
    required this.url
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json){
    return GalleryModel(id: json['id'], url: "${baseUrl}/${json['url']}");
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'url': "${baseUrl}/${url}",
    };
  }
}