import 'package:flutter/material.dart';
import 'package:chalet_sharks/models/chalet.dart';

import '../widgets/app_data.dart';
import '../widgets/chalet_item.dart';

class ChaletScreen extends StatefulWidget {
  const ChaletScreen({Key? key}) : super(key: key);

  @override
  _ChaletScreenState createState() => _ChaletScreenState();
}

class _ChaletScreenState extends State<ChaletScreen> {
  final TextEditingController textEditingController = TextEditingController();
  List<Chalet> filteredList = [];
  List<Chalet> searchedList = [];

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      setState(() {
        searchedList = filteredList.where((chalet) {
          return chalet.title.toLowerCase().contains(textEditingController.text.toLowerCase());
        }).toList();
        if (searchedList.isEmpty) {
          searchedList = filteredList;
        }
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgument = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    final categoryTitle = routeArgument['title'];
    filteredList = Chalets_data.where((chalet) {
      return chalet.categories.contains(categoryId);
    }).toList();
    if (searchedList.isEmpty) {
      searchedList = filteredList;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Chalets",style: TextStyle(
          color:Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  searchedList = filteredList.where((chalet) {
                    return chalet.title.toLowerCase().contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),
            GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                childAspectRatio: 4 / 5,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: searchedList.length,
              itemBuilder: (context, i) {
                List list = searchedList;
                return ChaletItem(
                  id: list[i].id,
                  cityId: categoryId!,
                  title: list[i].title,
                  image: list[i].image,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
