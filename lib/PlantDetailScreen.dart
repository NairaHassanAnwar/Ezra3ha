import 'package:flutter/material.dart';
import 'package:application_project/Location.dart';
import 'package:application_project/BagManagar.dart';

class PlantDetailPage extends StatefulWidget {
  final Plant plant;

  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  bool isFavorite = false;
  int quantity = 1;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _addToCart() {
    BagManager().addItem({
      'name': widget.plant.name,
      'price': widget.plant.price,
      'imageUrl': widget.plant.imageUrl,
      'quantity': quantity,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.plant.name} (x$quantity) added to bag')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Center(
                              child: Image.network(
                                plant.imageUrl,
                                fit: BoxFit.contain,
                                height: 300,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: _circleButton(Icons.close, () {
                            Navigator.pop(context);
                          }),
                        ),
                        Positioned(
                          top: 76,
                          right: 16,
                          child: _circleButton(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            _toggleFavorite,
                            iconColor: isFavorite ? Colors.red : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '(${plant.family})',
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                '${plant.rating.toStringAsFixed(1)}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('/5', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                              SizedBox(width: 8),
                              ...List.generate(5, (index) {
                                double rating = plant.rating;
                                return Icon(
                                  index < rating.floor()
                                      ? Icons.star : (index == rating.floor() && rating % 1 > 0)
                                      ? Icons.star_half : Icons.star_border,
                                  color: Colors.amber,
                                  size: 24,
                                );
                              }),
                            ],
                          ),
                          Text(
                            'based on ${plant.reviewCount} reviews',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 24),
                          Text('About',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                          SizedBox(height: 8),
                          Text(
                            plant.description,
                            style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Text('Read more',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                          ),
                          SizedBox(height: 24),
                          _buildCareInstructionsRow('TEMP.', Icons.thermostat, plant.careInstructions['temperature']),
                          SizedBox(height: 12),
                          _buildCareInstructionsRow('LIGHT', Icons.wb_sunny_outlined, plant.careInstructions['light']),
                          SizedBox(height: 12),
                          _buildCareInstructionsRow(
                              'FREQUENCY', Icons.calendar_today, plant.careInstructions['frequency']),
                          SizedBox(height: 12),
                          _buildCareInstructionsRow(
                              'WATER', Icons.water_drop_outlined, plant.careInstructions['water']),
                          SizedBox(height: 12),
                          _buildCareInstructionsRow(
                              'Humidity', Icons.water_damage, plant.careInstructions['Humidity']),
                          SizedBox(height: 12),
                          _buildCareInstructionsRow(
                              'Cutting', Icons.cut_outlined, plant.careInstructions['Cutting']),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Quantity:', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _quantityButton(Icons.remove, () {
                                        if (quantity > 1) setState(() => quantity--);
                                      }),
                                      Container(
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: Text(
                                          quantity.toString().padLeft(2, '0'),
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      _quantityButton(Icons.add, () {
                                        setState(() => quantity++);
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Price:', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                                  SizedBox(height: 8),
                                  Text(
                                    'OMR ${(plant.price * quantity).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1B5E20)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1B5E20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      SizedBox(width: 8),
                      Text('Add to Bag', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed, {Color iconColor = Colors.black}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: Color(0xFF1B5E20), borderRadius: BorderRadius.circular(8)),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCareInstructionsRow(String label, IconData icon, String? value) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(icon, color: Color(0xFF1B5E20)),
                SizedBox(height: 4),
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                SizedBox(height: 4),
                Text(value ?? 'N/A', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}