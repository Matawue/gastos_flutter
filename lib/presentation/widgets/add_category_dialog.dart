import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/domain/entities/expense_category.dart';


class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Category'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Category Name'),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            final categoryName = _nameController.text;
            if(categoryName.isNotEmpty){
              // Add category logic here
              final ExpenseCategory category = ExpenseCategory(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: categoryName
              );
              Provider.of<ExpenseProvider>(context, listen: false).addExpenseCategory(category);
              Navigator.of(context).pop(categoryName);
            }
          },
          child: Text('Add'),
        )
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}