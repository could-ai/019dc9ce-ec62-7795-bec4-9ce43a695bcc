import 'package:flutter/material.dart';

class AdminCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<AdminDocument> documents;

  const AdminCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.documents,
  });
}

class AdminDocument {
  final String id;
  final String title;
  final String description;
  final DocumentFormat format;
  final String size;

  const AdminDocument({
    required this.id,
    required this.title,
    required this.description,
    required this.format,
    required this.size,
  });
}

enum DocumentFormat {
  docx,
  pdf,
  xlsx,
}

extension DocumentFormatExtension on DocumentFormat {
  String get name {
    switch (this) {
      case DocumentFormat.docx:
        return 'DOCX';
      case DocumentFormat.pdf:
        return 'PDF';
      case DocumentFormat.xlsx:
        return 'XLSX';
    }
  }

  Color get color {
    switch (this) {
      case DocumentFormat.docx:
        return Colors.blue;
      case DocumentFormat.pdf:
        return Colors.red;
      case DocumentFormat.xlsx:
        return Colors.green;
    }
  }
}
