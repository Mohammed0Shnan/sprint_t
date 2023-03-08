class ProductModel{
  late int id ;
  late String name;
  late String image;
  late int addressId;

  ProductModel({required this.id , required this.name , required this.image,required this.addressId});

  ProductModel.fromMap(Map<String, dynamic> item):
        id=item["id"],
        name= item["name"],
        image= item["imageUrl"]  == null ? '':item["imageUrl"],
        addressId= item["address_id"] == null ? 0:item["address_id"];
}




