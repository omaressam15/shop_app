
class ProductModelDetails{

  bool status ;

  String message ;

  DataProducts data;


  ProductModelDetails.fromJson(Map<String,dynamic>json){

    status =json['status'];
    message =json['message'];

    data = json['data'] !=null ? DataProducts.fromJson(json['data']) : null ;

  }


}

class DataProducts {

  int id;

  String name;

  String description;

  dynamic oldPrice;

  dynamic discount;

  dynamic price;

  List<String> image;


  DataProducts.fromJson(Map<String,dynamic>json){

    var imageList = json['images'];

    List<String> images = imageList.cast<String>();


    id =json['id'];
    image = images;
    name =json['name'];
    price =json['price'];

    description =json['description'];

    oldPrice =json['old_price'];

    discount = json['discount'];





  }
}