class CategoriesModel {
  CategoriesModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  CategoriesData({
    required this.currentPage,
    required this.categories,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final List<Category> categories;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    categories =
        List.from(json['data']).map((e) => Category.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
