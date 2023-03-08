class ProductResponse {
  late String statusCode;
  late String msg;
  late List<Data> data;

  ProductResponse.fromJson(Map<String, dynamic> json) {

    statusCode = json['status_code'] == null? '':'';
    msg = json['msg'] == null ? '':'';
    // The second section of the condition when there are no services
    if (json['items'] != null && !(json['items'] is String)) {
      data =  <Data>[];
      json['items'].forEach((v) {
        data.add(new Data.fromJson(v));
      });

    } else {
      data = [];
    }

  }

}

class Data{
  late int id ;
  late String name;
  late String image;
  late Address address;
 // late String 
  Data.fromJson(Map<String, dynamic> data) {

    this.id = data['id'];
    this.name = data['name'];
    this.image = data['imageUrl'] == null?'': data['imageUrl']  ;
    this.address =  Address.fromJson(data['address']) ;
  //  this.createdAt=DateTime.parse( data['createdAt'].toString() ) ;

  }
}

class Address{
  late int id ;
  late double longitude;
  late double latitude;
  
  Address.fromJson(Map<String, dynamic> data) {

    this.id = data['id'];
    this.longitude = data['longitude'];
    this.latitude = data['latitude'];

  }
}





