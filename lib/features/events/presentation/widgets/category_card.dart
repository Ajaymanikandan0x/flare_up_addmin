import 'package:flare_up_admin/features/events/presentation/widgets/add_event_type.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/app_palette.dart';
import '../../domain/entities/event_category.dart';

class CategoryCard extends StatelessWidget {
  final EventCategory category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppPalette.darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppPalette.darkDivider,
          width: 1,
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppPalette.darkText,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: category.status == 'Active'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    category.status,
                    style: TextStyle(
                      color: category.status == 'Active'
                          ? Colors.green
                          : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              category.description,
              style: const TextStyle(
                color: AppPalette.darkTextSecondary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Last updated: ${category.updatedAt.toString().split('.')[0]}',
              style: const TextStyle(
                color: AppPalette.darkHint,
                fontSize: 12,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Event Types',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppPalette.darkText,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddEventType(categoryId: category.id),
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add Type'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.gradient2,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (category.eventTypes.isEmpty)
                  const Text(
                    'No event types added yet',
                    style: TextStyle(
                      color: AppPalette.darkHint,
                      fontSize: 14,
                    ),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: category.eventTypes.map((type) => Chip(
                      label: Text(type.name),
                      backgroundColor: AppPalette.darkCard,
                      side: const BorderSide(
                        color: AppPalette.darkDivider,
                      ),
                      labelStyle: const TextStyle(
                        color: AppPalette.darkText,
                      ),
                    )).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 