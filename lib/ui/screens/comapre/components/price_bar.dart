import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';
import 'dart:math' as math;

class PriceBar extends StatelessWidget {
  final String label;
  final double price1;
  final double price2;

  const PriceBar({
    super.key,
    required this.label,
    required this.price1,
    required this.price2,
  });

  @override
  Widget build(BuildContext context) {
    final maxPrice = math.max(price1, price2);
    final percent1 = (price1 / maxPrice * 100).round();
    final percent2 = (price2 / maxPrice * 100).round();
    final isCheaper1 = price1 < price2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSecondaryText(text: label, fontSize: 13,),
        const SizedBox(height: 12),
        Row(
          children: [
            // Left price
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${price1.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCheaper1 ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            // Right price
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price2.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCheaper1 ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bar visualization
        Row(
          children: [
            // Left bar
            Expanded(
              flex: percent1,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isCheaper1 ? Colors.green : Colors.orange,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            // Right bar
            Expanded(
              flex: percent2,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isCheaper1 ? Colors.orange : Colors.green,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
