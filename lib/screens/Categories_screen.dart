import 'package:flutter/material.dart';
import '../widgets/app_data.dart';
import '../widgets/category_item.dart';

class CategroyScreen extends StatelessWidget {
  const CategroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          IconButton(
            onPressed:(){
           Navigator.of(context).pushNamed('/First');
            },
           icon:Icon(Icons.logout,color:Colors.white),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/history');
          },
          icon: Icon(Icons.history,color:Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "City",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: 200, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        children: Categories_data.map(
          (categoryData) => CategoryItem(
            categoryData.id,
            categoryData.title,
            categoryData.image,
          ),
        ).toList(),
      ),
    );
  }
}
