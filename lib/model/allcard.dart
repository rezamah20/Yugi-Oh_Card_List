class Cards {
  String? name;
  String? type;
  String? desc;
  int? id;
  List<CardImage>? card_images;
  List<CardSet>? cardSet;

  Cards({this.name, this.type, this.id, this.card_images, this.desc, this.cardSet});

  Cards.fromJson(Map<String, dynamic> json){
        name = json['name'];
        type = json['type'];
        id = json['id'];
        desc = json['desc'];

        var list = json['card_images'] as List;
        List<CardImage> imagesList = list.map((i) => CardImage.fromJson(i)).toList();
        card_images = imagesList;

        final carddata = json['card_sets'] as List<dynamic>?;
        cardSet = carddata?.map((e) => CardSet.fromJson(e as Map<String, dynamic>)).toList();

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

class DetailCards {
  String? name;
  String? type;
  String? desc;
  int? id;
  String? race;
  int? level;
  List<DetailCardImage>? detail_card_images;

  DetailCards({this.name, this.type, this.id, this.detail_card_images, this.desc, this.race, this.level});

  DetailCards.fromJson(Map<String, dynamic> json){
    name = json['name'];
    type = json['type'];
    id = json['id'];
    desc = json['desc'];
    var list = json['card_images'] as List;
    //. print(list.runtimeType);
    List<DetailCardImage> imagesList = list.map((i) => DetailCardImage.fromJson(i))
        .toList();
    detail_card_images = imagesList;
    race = json['race'];
    level = json['level'];
  }

}

class DetailCardImage {
  int? id;
  String? img_url;
  String? img_url_small;
  String? img_url_crop;

  DetailCardImage({ this.id, this.img_url, this.img_url_small, this.img_url_crop});

  DetailCardImage.fromJson(Map<String, dynamic> json){
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

class CardSet {
  String? set_name;
  String? set_code;
  String? set_rarity;
  String? set_rarity_code;
  String? set_price;

  CardSet({this.set_name, this.set_code, this.set_rarity, this.set_rarity_code, this.set_price});

  CardSet.fromJson(Map<String, dynamic> json){
    set_name = json['set_name'];
    set_code = json['set_code'];
    set_rarity = json['set_rarity'];
    set_rarity_code = json['set_rarity_code'];
    set_price = json['set_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['set_name'] = this.set_name;
    data['set_code'] = this.set_code;
    data['set_rarity'] = this.set_rarity;
    data['set_rarity_code'] = this.set_rarity_code;
    data['set_price'] = this.set_price;
    return data;
  }
}

class BannerCard {
  String? name;
  String? type;
  String? desc;
  int? id;
  List<CardImage>? card_images;

  BannerCard({this.name, this.type, this.id, this.card_images, this.desc});

  BannerCard.fromJson(Map<String, dynamic> json){
    name = json['name'];
    type = json['type'];
    id = json['id'];
    desc = json['desc'];

    var list = json['card_images'] as List;
    List<CardImage> imagesList = list.map((i) => CardImage.fromJson(i)).toList();
    card_images = imagesList;

  }

  @override
  String toString() {
    return name!;
  }
}