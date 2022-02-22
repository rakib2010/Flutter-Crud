class ProductModel{
  late int id;
  late String name;
  late int qty;
  late double price;
  late bool isActive;
  late String category;





  ProductModel({
    required this.name,
    required this.qty,
    required this.price,
    required this.isActive,
    required this.category,
  });

  ProductModel.all({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.isActive,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          qty == other.qty &&
          price == other.price &&
          isActive == other.isActive &&
          category == other.category);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      qty.hashCode ^
      price.hashCode ^
      isActive.hashCode ^
      category.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' qty: $qty,' +
        ' price: $price,' +
        ' isActive: $isActive,' +
        ' category: $category,' +
        '}';
  }

  ProductModel copyWith({
    int? id,
    String? name,
    int? qty,
    double? price,
    bool? isActive,
    String? category,
  }) {
    return ProductModel(
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'qty': this.qty,
      'price': this.price,
      'isActive': this.isActive,
      'category': this.category,
    };
  }

  String toJson(){
    return '{' +
        ' "name": "$name",' +
        ' "qty": $qty,' +
        ' "price": $price,' +
        ' "isActive": $isActive,' +
        ' "category": "$category"' +
        '}';
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel.all(
      id: map['id'] as int,
      name: map['name'] as String,
      qty: map['qty'] as int,
      price: map['price'] as double,
      isActive: map['active'] as bool,
      category: map['category'] as String,
    );
  }

//</editor-fold>
}