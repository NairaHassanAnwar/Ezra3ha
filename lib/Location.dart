import 'package:flutter/material.dart';
import 'package:application_project/BottomNavBar.dart';
import 'package:application_project/Profile.dart';
import 'package:application_project/Home.dart';
import 'package:application_project/Search.dart';
import 'package:application_project/Bag.dart';
import 'package:application_project/PlantDetailScreen.dart';

class Plant {
  final String name;
  final String family;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviewCount;
  final Map<String, String> careInstructions;

  Plant({
    required this.name,
    required this.family,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    this.description = '', // Default value
    this.rating = 0.0, // Default value
    this.reviewCount = 0, // Default value
    this.careInstructions = const {},
  });
}

final List<Plant> samplePlants = [
  Plant(
    name: 'Khalas Date Palm',
    family: 'Arecaceae',
    price: 29.99,
    originalPrice: 39.99,
    imageUrl: 'https://th.bing.com/th/id/OIP.SwEge2ZLz1WdQhrNB60L1QHaE8?rs=1&pid=ImgDetMain',
    description: 'The Khalas Date Palm is a widely cultivated date palm variety known for its sweet, delicious fruit. This palm thrives in hot, arid climates and is valued for its exceptional date production. The dates have a rich amber color and caramel-like sweetness that makes them prized across the Middle East.',
    rating: 4.8,
    reviewCount: 235,
    careInstructions: {
      'temperature': '20-35°C',
      'light': 'Full Sun',
      'frequency': '2-3/Week',
      'water': '5-8L',
      'Humidity': 'Low',
      'Cutting': 'Rarely'
    },
  ),
  Plant(
    name: 'Sweet Orange',
    family: 'Rutaceae',
    price: 24.99,
    originalPrice: 34.99,
    imageUrl: 'https://static.vecteezy.com/system/resources/previews/015/606/684/non_2x/sweet-orange-fruit-photo.jpg',
    description: 'The Sweet Orange tree produces the familiar orange fruit loved worldwide. This evergreen citrus tree features glossy leaves, fragrant white blossoms, and vitamin-rich fruit. Perfect for home gardens in suitable climates, it adds both beauty and practical harvests to your landscape.',
    rating: 4.6,
    reviewCount: 178,
    careInstructions: {
      'temperature': '15-30°C',
      'light': 'Full Sun',
      'frequency': '1-2/Week',
      'water': '4-6L',
      'Humidity': 'Medium',
      'Cutting': 'Seasonal'
    },
  ),
  Plant(
    name: 'Grapevine',
    family: 'Vitaceae',
    price: 19.99,
    originalPrice: 27.99,
    imageUrl: 'https://th.bing.com/th/id/OIP.1EuplHtE7Jh0prMvBIooAwHaIg?rs=1&pid=ImgDetMain',
    description: 'Grapevines are woody perennial vines known for producing grapes used for wine, raisins, table consumption, and juice. With their climbing habit and large, lobed leaves, grapevines make excellent ornamental plants for arbors and pergolas while also yielding delicious fruit.',
    rating: 4.3,
    reviewCount: 156,
    careInstructions: {
      'temperature': '15-25°C',
      'light': 'Full Sun',
      'frequency': '1/Week',
      'water': '4-7L',
      'Humidity': 'Medium',
      'Cutting': 'Annual'
    },
  ),
  Plant(
    name: 'Barley',
    family: 'Poaceae',
    price: 21.99,
    originalPrice: 30.99,
    imageUrl: 'https://th.bing.com/th/id/OIP.v5j-MLcgU_7DUYJvlRkg7AHaE8?rs=1&pid=ImgDetMain',
    description: 'Barley is a versatile cereal grain with an ancient history of cultivation. Known for its distinctive appearance with long awns, barley is used for animal feed, human food, and is a key ingredient in beer production. It grows quickly and is adaptable to various climates.',
    rating: 4.0,
    reviewCount: 112,
    careInstructions: {
      'temperature': '15-25°C',
      'light': 'Full Sun',
      'frequency': '3-4/Week',
      'water': '3-5L',
      'Humidity': 'Low',
      'Cutting': 'At harvest'
    },
  ),
];

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(plant.name),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                plant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.error)),
                loadingBuilder: (context, child, progress) =>
                progress == null ? child : Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
                Text(
                  '(${plant.family})',
                  style: TextStyle(fontSize: 12, color: Colors.green[600], fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'OMR${plant.price.toInt()}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'OMR${plant.originalPrice.toInt()}',
                          style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white, size: 18),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${plant.name} added to cart')),
                          );
                        },
                        constraints: BoxConstraints.tightFor(width: 34, height: 34),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(String name) {
    switch (name.toLowerCase()) {
      case 'khalas date palm':
        return Colors.lightBlue[50]!;
      case 'sweet orange':
        return Colors.orange[50]!;
      case 'grapevine':
        return Colors.deepPurple[50]!;
      case 'barley':
        return Colors.yellow[50]!;
      default:
        return Colors.grey[100]!;
    }
  }
}

class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Location()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Search()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Bag()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Profile()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('El-Zahra'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: samplePlants.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final plant = samplePlants[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant)),
                );
              },
              child: PlantCard(plant: plant),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
