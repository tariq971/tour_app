
class Product{
  String id;
  String uId;
  String name;
  int price;


  Product(this.id, this.uId,this.name,this.price);

   static Product fromMap(Map<String,dynamic>map){
    return Product(map["id"],map["uId"],map["name"],map['price']);
  }
  Map<String,dynamic> toMap(){
    return{
      "id":id,
      "uId":uId,
      "name":name,
      "price":price,
    };
  }

}