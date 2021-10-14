
class ShopUserData{

  bool status ;

  String message ;

  DataUser data;


  ShopUserData.fromJson(Map<String,dynamic>json){

    status =json['status'];
    message =json['message'];

    data = json['data'] !=null ? DataUser.fromJson(json['data']) : null ;

  }


}

class DataUser {

  int id;

  String name;

  String email;

  String phone;

  String token;

  DataUser.fromJson(Map<String,dynamic>json){

    id =json['id'];

    name =json['name'];

    email =json['email'];

    phone =json['phone'];

    token =json['token'];

  }
}