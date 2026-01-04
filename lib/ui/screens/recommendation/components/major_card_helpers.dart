import 'package:flutter/material.dart';

Widget skillsCard(String skill) {
  return Container(
    decoration: BoxDecoration(
      // ignore: deprecated_member_use
      color: Color(0xFF334155).withOpacity(0.5),
      borderRadius: BorderRadius.circular(20),
      // ignore: deprecated_member_use
      border: Border.all(color: Color(0xFF475569).withOpacity(0.3), width: 1),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(
      skill,
      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 10),
    ),
  );
}

// Widget categoryCard(String title, String subTitle) {
//   return Container(
//     decoration: BoxDecoration(
//       // ignore: deprecated_member_use
//       color: Color(0xFF334155).withOpacity(0.5),
//       borderRadius: BorderRadius.circular(12),
//       // ignore: deprecated_member_use
//       border: Border.all(color: Color(0xFF475569).withOpacity(0.3), width: 1),
//     ),
//     padding: EdgeInsets.all(10),
//     child: Column(
//       children: [
//         Icon(Icons.access_time, color: Color(0xFF93C5FD), size: 20),
//         SizedBox(height: 4),
//         Text(
//           title,
//           // ignore: deprecated_member_use
//           style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11),
//         ),
//         SizedBox(height: 2),
//         Text(
//           subTitle,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//       ],
//     ),
//   );
// }
