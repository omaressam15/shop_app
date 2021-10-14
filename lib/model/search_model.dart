class GetSearchModel {
  bool status;
  DataSearch dataSearch;

  GetSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataSearch = json['data'] != null ? DataSearch.fromJson(json['data']) : null;
  }
}

class DataSearch {
  int currentPage;
  List<Product> dataList;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String path;
  int perPage;
  int to;
  int total;


  DataSearch.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      dataList = <Product>[];
      json['data'].forEach((v) {
        dataList.add(Product.fromJson(v));
      });
    }
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


class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
