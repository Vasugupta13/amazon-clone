
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
  String? id;
  String? name;
  String? description;
  int? price;
  List<String>? images;
  int? quantity;
  String? category;
  String? waxType;
  String? burnTime;
  List<String>? availableFragrances;
  String? netWeight;
  List<dynamic>? ratings;
  int? iV;


  ProductDetailModel.name(
      this.id,
      this.name,
      this.description,
      this.price,
      this.images,
      this.quantity,
      this.category,
      this.waxType,
      this.burnTime,
      this.availableFragrances,
      this.netWeight,
      this.ratings,
      this.iV);

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
    id = json['_id'];
    iV = json['__v'];
    waxType = json['waxType'];
    burnTime = json['burnTime'];
    availableFragrances = json['availableFragrances'].cast<String>();
    netWeight = json['netWeight'];
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
    data['_id'] = id;
    data['__v'] = iV;
    data['availableFragrances'] = availableFragrances;
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
