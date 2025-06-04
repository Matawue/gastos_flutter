import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/domain/entities/expense_tag.dart';
import 'package:provider/provider.dart';


class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // despues probar con Dialog normal
    return AlertDialog(
      title: Text('Add New Tag'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Tag Name'),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel')
        ),

        TextButton(
          onPressed: () {
            final tagName = _nameController.text;
            if(tagName.isNotEmpty){
              // Add tag logic here
              final ExpenseTag tag = ExpenseTag(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: tagName
              );
              Provider.of<ExpenseProvider>(context, listen: false).addExpenseTag(tag);
              Navigator.of(context).pop(tagName);
            }
          },
          child: Text('Add')
        ),




      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}