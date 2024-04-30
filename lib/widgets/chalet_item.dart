import 'package:flutter/material.dart';

class ChaletItem extends StatelessWidget {
  final String id;
  final String cityId;
  final String title;
  final String image;
  const ChaletItem({super.key, required this.id, required this.cityId, required this.title, required this.image});

  void selectChalet(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/data',
      arguments: {"city_id": cityId, "chalet_id": id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => selectChalet(context),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
