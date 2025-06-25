
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware/model/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

 FirebaseFirestore firestore = FirebaseFirestore.instance;
 late CollectionReference productCollection;

 TextEditingController productNameCtrl =TextEditingController();
 TextEditingController productDecriptionCtrl =TextEditingController();
 TextEditingController productImgCtrl =TextEditingController();
 TextEditingController productPriceCtrl =TextEditingController();

 String category = 'general';
 String brand = 'un branded';
 bool offer = false;

 List<Product> products=[];



 @override
  void onInit() async{
    // TODO: implement onInit
   productCollection=firestore.collection('products');
   await fetchproducts();
    super.onInit();
  }
 addProduct(){
   try {
     DocumentReference doc=productCollection.doc();
     Product product = Product(
         id: doc.id,
         name: productNameCtrl.text,
         category: category,
         description: productDecriptionCtrl.text,
         price: double.tryParse(productPriceCtrl.text),
         brand: brand,
         image: productImgCtrl.text,
         offer:offer,

        );
     final productJson=product.toJson();
     doc.set(productJson);
     Get.snackbar('Sucess', 'Product added Successfully',colorText: Colors.green );
     setValuesDefault();
   } catch (e) {
     Get.snackbar('Error', e.toString(),colorText: Colors.green );
     print(e);
   }

 }

 fetchproducts() async{
   try {
     QuerySnapshot productSnapshot = await  productCollection.get();
     final Iterable<Product> retrievedProducts=productSnapshot.docs.map((doc)=> Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
     products.clear();
     products.assignAll(retrievedProducts);
     Get.snackbar('Sucess', 'Product Fetched sucessfully',colorText: Colors.green);
   } catch (e) {
     Get.snackbar('Error', 'Product Fetched sucessfully',colorText: Colors.green);
     print(e);
   }finally{
     update();
   }

}

deleteProduct(String id) async {
   try {
     await productCollection.doc(id).delete();
     fetchproducts();
     Get.snackbar('Sucess', 'Product Fetched sucessfully',colorText: Colors.green);
   } catch (e) {
     Get.snackbar('Error', e.toString(),colorText: Colors.red);
     print(e);
   }

}

 setValuesDefault(){
   productNameCtrl.clear();
   productPriceCtrl.clear();
   productDecriptionCtrl.clear();
   productImgCtrl.clear();

   category = 'general';
    brand = 'un branded';
   offer = false;
   update();

 }


}