import 'package:flutter/material.dart';

Widget ItemDrawer({
  required String title,
  required IconData icon,
  bool isActive = false,
  VoidCallback? onTap,
}) {
  return Container(
    color: isActive ? const Color(0xFFF4D03F) : Colors.transparent, // اللون الأصفر للرئيسية
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF2C3E50), // لون النص الأزرق الداكن
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      // وضعنا الأيقونة في الـ trailing لتظهر في الجهة اليسرى (عكس بداية النص) كما في الصورة
      trailing: Icon(
        icon,
        color: const Color(0xFF2C3E50), // لون الأيقونة
        size: 28,
      ),
      onTap: onTap,
    ),
  );
}