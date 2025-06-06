import 'package:flutter/material.dart';
import 'package:application_project/BottomNavBar.dart';
import 'package:application_project/Home.dart';
import 'package:application_project/Location.dart';
import 'package:application_project/Search.dart';
import 'package:application_project/Profile.dart';
import 'package:application_project/BagManagar.dart';

class Bag extends StatefulWidget {
  const Bag({Key? key}) : super(key: key);

  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    final bagItems = BagManager().bagItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Bag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bagItems.isEmpty
            ? const Center(child: Text('Your bag is empty.'))
            : ListView.builder(
          itemCount: bagItems.length,
          itemBuilder: (context, index) {
            final item = bagItems[index];
            double totalPrice = item['price'] * item['quantity']; // Calculate total price

            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'OMR ${totalPrice.toStringAsFixed(2)} (x${item['quantity']})', // Display total price
                          style: TextStyle(fontSize: 18, color: Colors.green[800]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        BagManager().removeItem(index);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 3,
        onItemTapped: (index) {
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
        },
      ),
    );
  }
}





