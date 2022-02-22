class CategoryModel{
  late int id;
  late String categoryName;


  CategoryModel._(); //<editor-fold desc="Data Methods">



  CategoryModel({
    required this.id,
    required this.categoryName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          categoryName == other.categoryName);

  @override
  int get hashCode => id.hashCode ^ categoryName.hashCode;

  @override
  String toString() {
    return 'CategoryModel{' +
        ' id: $id,' +
        ' categoryName: $categoryName,' +
        '}';
  }

  CategoryModel copyWith({
    int? id,
    String? categoryName,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'categoryName': this.categoryName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      categoryName: map['categoryName'] as String,
    );
  }

//</editor-fold>
}