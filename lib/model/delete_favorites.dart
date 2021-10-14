class DeleteFavorites {

  String message;

  bool status;

  Data data;

  DeleteFavorites.fromJson(Map<String,dynamic>json){

    status = json['status'];

    message = json['message'];

    data = json['data'] !=null ? data = Data.fromJson(json['data']):null;

  }


}

class Data {

  String id;

  Data.fromJson(Map<String,dynamic>json){

    id = json['id'];

  }
}
