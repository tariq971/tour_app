

class OrderItem{

String name;
int price;
String? image;
int quantity;

OrderItem(this.name,this.price,this.image,this.quantity);
static OrderItem fromMap(Map<String,dynamic>map){
  OrderItem p= OrderItem(map["name"], map["price"],map["image"], map["quantity"]);
  return p;
}
Map<String,dynamic>toMap(){
  return {
    "name":name,"price":price,"image":image,"quantity":quantity
  };
}
}
