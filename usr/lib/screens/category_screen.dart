import 'package:flutter/material.dart';
import '../models/admin_model.dart';
import '../widgets/document_card.dart';

class CategoryScreen extends StatelessWidget {
  final AdminCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: category.color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${category.documents.length} Dokumen Tersedia',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: category.documents.length,
              itemBuilder: (context, index) {
                final document = category.documents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: DocumentCard(
                    document: document,
                    categoryColor: category.color,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
