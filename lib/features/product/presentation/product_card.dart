import 'package:flutter/material.dart';
import 'package:maps/features/product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl ?? '',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  height: 150,
                  width: double.infinity,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Product Title
            Text(
              product.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Product Description
            Text(
              product.body ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Distance Information
            Text(
              "Distance: ${product.distance?.toStringAsFixed(2)} km",
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 8),

            // View Directions Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  onTap();
                },
                child: const Text("View Directions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
