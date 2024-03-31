
class CartItemModel {
  ProductDetailModel? product;
  int? quantity;
  String? sId;

  CartItemModel({this.product, this.quantity, this.sId});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? ProductDetailModel.fromJson(json['product'] as Map<String,dynamic> ) : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}

class ProductDetailModel {
  String? name;
  String? description;
  int? price;
  List<String>? images;
  int? quantity;
  String? category;
  List<Ratings>? ratings;
  String? sId;
  int? iV;

  ProductDetailModel(
      {this.name,
        this.description,
        this.price,
        this.images,
        this.quantity,
        this.category,
        this.ratings,
        this.sId,
        this.iV});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    quantity = json['quantity'];
    category = json['category'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['images'] = images;
    data['quantity'] = quantity;
    data['category'] = category;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

class Ratings {
  String? userId;
  int? rating;
  String? sId;

  Ratings({this.userId, this.rating, this.sId});

  Ratings.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rating = json['rating'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['rating'] = rating;
    data['_id'] = sId;
    return data;
  }
}
