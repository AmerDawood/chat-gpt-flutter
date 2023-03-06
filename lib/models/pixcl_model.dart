
class Photos {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  bool? liked;
  String? alt;


  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    liked = json['liked'];
    alt = json['alt'];
  }




  static List<Photos> modelsFromSnapshot (List modelSnapshot){
    return modelSnapshot.map((data) => Photos.fromJson(data)).toList();
  }
}

