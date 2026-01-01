import 'package:flutter/material.dart';

class UniversityTile extends StatelessWidget {
  final String name;
  final String price;
  const UniversityTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Placeholder()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          title: Text(
            name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            price,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
