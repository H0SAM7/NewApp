import 'package:flutter/material.dart';
import 'package:my_visitor/core/utils/assets.dart';


class screenTSt extends StatelessWidget {
  const screenTSt({super.key});
static String id='screenTSt';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
             Assets.imagesBooks, // Replace with actual image URL
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Women Printed Kurta",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Neque porro quisquam est qui dolorem ipsum quia",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₹1500",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "₹2499",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "40% Off",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star_half, color: Colors.amber, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "56890",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        ],
      ),
    );
  }
}


// clean archi.
// 