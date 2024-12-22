import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_palette.dart';
import '../bloc/event_category_bloc.dart';
import '../bloc/event_category_event.dart';
import '../bloc/event_category_state.dart';

class AddEventType extends StatefulWidget {
  final int categoryId;
  
  const AddEventType({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddEventType> createState() => _AddEventTypeState();
}

class _AddEventTypeState extends State<AddEventType> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    _nameFocusNode.unfocus();
    _descriptionFocusNode.unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);
      context.read<EventCategoryBloc>().add(
            CreateEventType(
              name: nameController.text.trim(),
              description: descriptionController.text.trim(),
              categoryId: widget.categoryId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventCategoryBloc, EventCategoryState>(
      listener: (context, state) {
        print('Current state: $state'); // Debug print
        if (state is EventCategoryLoading) {
          setState(() => isLoading = true);
        } else if (state is EventCategoryError) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EventCategoryLoaded) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Event Type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppPalette.darkText,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: nameController,
                  focusNode: _nameFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Type Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Type name is required';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  focusNode: _descriptionFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isLoading ? null : () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: isLoading ? Colors.grey : AppPalette.darkText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: isLoading ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.gradient2,
                        foregroundColor: Colors.white,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 