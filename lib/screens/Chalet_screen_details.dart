import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/app_data.dart';

class ChaletDetails extends StatefulWidget {
  const ChaletDetails({Key? key});

  @override
  _ChaletDetailsState createState() => _ChaletDetailsState();
}

class _ChaletDetailsState extends State<ChaletDetails> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final dataId = data['chalet_id'];
    final selectedChalet = Details_data.firstWhere((data) => data.equivelent == dataId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chalet Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedChalet.image.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: Image.asset(
                    selectedChalet.image[i],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Center(
            child: AnimatedSmoothIndicator(
              curve: Curves.bounceIn,
              effect: WormEffect(
                activeDotColor: Colors.blue,
              ),
              activeIndex: _currentPage,
              count: selectedChalet.image.length,
            ),
          ),
          Divider(),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "overview",
              style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
            height: 200, // Adjust height as needed
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    selectedChalet.overview,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "details",
              style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            height: 200, // Adjust height as needed
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    selectedChalet.details,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 3),
          Center(
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/booking',
                  arguments: {"city_id": data['city_id'], "chalet_id": dataId},
                );
              },
              child: Text(
                "book now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
