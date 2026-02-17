import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ws_cube/crud/product-screen.dart';


class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();

  Future<void> addProduct(BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('products').add(
          {
            'name' : nameController.text,
            'price' : priceController.text,
            'imgUrl' : imgUrlController.text
          }
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Added')));
      nameController.clear();
      priceController.clear();
      imgUrlController.clear();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  label: Text('Product Name'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                  label: Text('Product Price'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: imgUrlController,
              decoration: InputDecoration(
                  label: Text('Image Url'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: () {
                  addProduct(context);
                }, child: Text('Add')),

                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(),));
                }, child: Text('Product Screen')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
