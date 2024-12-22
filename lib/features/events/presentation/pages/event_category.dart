import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_palette.dart';
import '../../domain/entities/event_category.dart';
import '../bloc/event_category_bloc.dart';
import '../bloc/event_category_event.dart';
import '../bloc/event_category_state.dart';
import '../widgets/category_card.dart';
import '../widgets/add_category.dart';

class EventCategoryPage extends StatefulWidget {
  const EventCategoryPage({Key? key}) : super(key: key);

  @override
  State<EventCategoryPage> createState() => _EventCategoryPageState();
}

class _EventCategoryPageState extends State<EventCategoryPage> {
  @override
  void initState() {
    super.initState();
    // Load categories when the page is initialized
    context.read<EventCategoryBloc>().add(GetEventCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories & Types',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Manage your website categories and their associated types',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const AddCategory(),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Category'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.gradient2,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<EventCategoryBloc, EventCategoryState>(
                builder: (context, state) {
                  if (state is EventCategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EventCategoryLoaded) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available'),
                      );
                    }
                    return _buildCategoryList(state.categories);
                  } else if (state is EventCategoryError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(List<EventCategory> categories) {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
