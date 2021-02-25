import 'package:cloud_firestore/cloud_firestore.dart';





class ItemModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  int price;
  int qtyitems;
  String productId;
  String color;

  ItemModel(
      {this.title,
        this.shortInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.longDescription,
        this.status,
        this.qtyitems,
        this.productId,
        this.color,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    qtyitems = json["qtyitems"];
    productId =json["productId"];
    color = json["color"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    data["qtyitems"] = this.qtyitems;
    data["productId"] = this.productId;
    data["color"] = this.color;    
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}


class ItemColorModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  int price;
  int qtyitems;
  String productId;
  String color;

  ItemColorModel(
      {this.title,
        this.shortInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.longDescription,
        this.status,
        this.qtyitems,
        this.productId,
        this.color,
        });

  ItemColorModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    qtyitems = json["qtyitems"];
    productId =json["productId"];
    color = json["color"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    data["qtyitems"] = this.qtyitems;
    data["productId"] = this.productId;
    data["color"] = this.color;
    return data;
  }
}

class ColorPublishedDate {
  String date;

  ColorPublishedDate({this.date});

  ColorPublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}