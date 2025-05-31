
class Product{
  String id;
  String uId;
  String name;
  String? image;
  int price;


  Product(this.id, this.uId,this.name,this.price);

   static Product fromMap(Map<String,dynamic>map){
    Product p=Product(map["id"],map["uId"],map["name"],map['price'],);
    p.image=map["image"];
    return p;
  }
  Map<String,dynamic> toMap(){
    return{
      "id":id,
      "uId":uId,
      "name":name,
      "image":image,
      "price":price,
    };
  }

}