import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ws_cube/crud/update-product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  Stream<List<Map<String, dynamic>>> fetchData(){
    return  FirebaseFirestore.instance.collection('products').snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data()
    },).toList(),);
  }

  void deleteProduct(String id){
    showDialog(
      context:context,
      builder: (context) => AlertDialog(
        title: Text('Product Delete...!'),
        icon: Icon(Icons.warning, color: Colors.red,),
        content: Text('Are you sure .....?'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Cancel')),
          ElevatedButton(onPressed: () {
            try {
              FirebaseFirestore.instance.collection('products').doc(id).delete();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Deleted')));
              Navigator.pop(context);
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Failed')));
            }
          }, child: Text('Delete'))
        ],
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Product Screen'),
      ),
      body: Center(
          child: StreamBuilder(
            stream: fetchData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError || snapshot.data == null){
                return Text('Data Not Found');
              }else{
                List data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.yellow,
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(data[index]['imgUrl']),),
                      title: Text(data[index]['name']),
                      subtitle: Text('Rs : ${data[index]['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct(data[index])));
                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: () {
                            deleteProduct(data[index]['id']);
                          }, icon: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          )
      ),
    );
  }
}
