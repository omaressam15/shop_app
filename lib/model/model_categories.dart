class CategoriesModel {
  bool status;

  DataCategories dataCategories;

  CategoriesModel.fromJson(Map<String,dynamic>json){

    status = json['status'];
    dataCategories = DataCategories.fromJson(json['data']);

  }

}

class DataCategories {
  int currentPage;

  List<Data> data = [];

  DataCategories.fromJson(Map<String,dynamic>json){

    currentPage = json['current_page'];

    json['data'].forEach((element){
      
      data.add(Data.fromJson(element));
      
    });
  }
}

class Data {
  int id;

  String name;

  String image;

  Data.fromJson(Map<String,dynamic>json){

    id = json['id'];
    name = json['name'];
    image = json['image'];

  }

}
