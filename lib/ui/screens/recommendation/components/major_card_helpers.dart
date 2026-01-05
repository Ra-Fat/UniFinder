import 'package:flutter/material.dart';


Widget skillsCard(String skill) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF334155).withOpacity(0.5),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xFF475569).withOpacity(0.3), width: 1),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(
      skill,
      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 10),
    ),
  );
}