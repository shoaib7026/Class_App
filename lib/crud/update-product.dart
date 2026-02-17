import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatelessWidget {
  UpdateProduct(this.product, {super.key});
  Map product;

  late TextEditingController nameController = TextEditingController(text: product['name']);
  late TextEditingController priceController = TextEditingController(text: product['price']);
  late TextEditingController imgUrlController = TextEditingController(text: product['imgUrl']);

  Future<void> updateProduct(BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('products').doc(product['id']).set(
          {
            'name':nameController.text,
            'price' : priceController.text,
            'imgUrl' : imgUrlController.text
          }
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Updated')));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Failed')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Update Product'),
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
                  Navigator.pop(context);
                }, child: Text('Cancel')),

                ElevatedButton(onPressed: () {
                  updateProduct(context);
                }, child: Text('Update')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
