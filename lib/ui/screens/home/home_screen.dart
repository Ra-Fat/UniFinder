import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_finder/ui/screens/dream-detail/dream_detail.dart';
import 'package:uni_finder/ui/screens/q&a/question_screen.dart';
import '../dream-detail/mock_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Your name',
                      style: TextStyle(
                        color: Color(0xFF1500FE),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Discover your dream here',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search, size: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF1500FE)),
                    ),
                  ),
                  // onChanged:,
                ),
                SizedBox(height: 10.0),
                Text('Your Dream'),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        1, // Replace with your dreams list length in the future
                    itemBuilder: (context, index) {
                      // In the future, pass dream data to DreamCard
                      return DreamCard();
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuestionScreen(),
                  ),
                );
              },
              backgroundColor: Color(0xFF1500FE),
              shape: CircleBorder(),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class DreamCard extends StatelessWidget {
  const DreamCard({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'MMM dd, yyyy',
    ).format(DateTime.now());

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                'Childhood Dream',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Created: $formattedDate',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black, // Text color
                  side: BorderSide(color: Colors.grey),
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DreamDetail(dream: dream, universityMajors: universityMajors,)));
                },
                child: Text(
                  'View Detail',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
