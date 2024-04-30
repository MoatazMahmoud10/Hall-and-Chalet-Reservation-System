import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

   CategoryItem(this.id, this.title, this.image);

  void selectCategory(BuildContext context) {
  Navigator.of(context).pushNamed(
    '/ first one',
    arguments: {
      'id': id,
      'title': title,
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      
      child: Stack(
        children: [
          Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
            margin: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}