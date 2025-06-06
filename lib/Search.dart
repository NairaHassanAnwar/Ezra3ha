import 'package:application_project/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:application_project/Home.dart';
import 'package:application_project/Location.dart';
import 'package:application_project/Bag.dart';
import 'package:application_project/Profile.dart';
import 'package:application_project/PlantDetailScreen.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Plant> plants = samplePlants; // Assuming samplePlants is defined in Location.dart
  List<Plant> filteredPlants = [];

  @override
  void initState() {
    super.initState();
    filteredPlants = plants; // Initialize filteredPlants with all plants
  }

  void _onSearch(String query) {
    final filtered = plants.where((plant) {
      return plant.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPlants = filtered;
    });
  }

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
        title: const Text('Search Plants'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Search for a plant...',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: filteredPlants.isEmpty
          ? const Center(child: Text('No plants found'))
          : GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filteredPlants.length,
        itemBuilder: (context, index) {
          final plant = filteredPlants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlantDetailPage(plant: plant)),
              );
            },
            child: PlantCard(plant: plant), // Assuming PlantCard is defined in Location.dart
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}