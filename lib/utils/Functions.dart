
import 'package:firebase_auth/firebase_auth.dart';

class Functions{
  static bool isShop(User? user){
if (user==null) return false;
return user.email=="muhammadtariqkhan971@gmail.com";
  }
}
