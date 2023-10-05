import 'dart:convert';


class Cards {
  String? name;
  String? type;
  String? desc;
  int? id;
  List<CardImage>? card_images;

  Cards({this.name, this.type, this.id, this.card_images, this.desc});

  Cards.fromJson(Map<String, dynamic> json){
        name = json['name'];
        type = json['type'];
        id = json['id'];
        desc = json['desc'];
        var list = json['card_images'] as List;
       //. print(list.runtimeType);
        List<CardImage> imagesList = list.map((i) => CardImage.fromJson(i)).toList();
        card_images = imagesList;
  }

  @override
  String toString() {
    return name!;
  }
}

class CardImage {
  int? id;
  String? img_url;
  String? img_url_small;
  String? img_url_crop;

  CardImage({ this.id, this.img_url, this.img_url_small, this.img_url_crop});

  CardImage.fromJson(Map<String, dynamic> json){
     id = json['id'];
     img_url = json['image_url'];
     img_url_small = json['img_url_small'];
     img_url_crop = json['image_url_cropped'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'image_url': img_url,
        'img_url_small': img_url_small,
        'image_url_cropped': img_url_crop,
      };
}