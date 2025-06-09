import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/presentation/widgets/add_tag_dialog.dart';
import 'package:provider/provider.dart';


class TagManagementScreen extends StatelessWidget {
  const TagManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text('Manage Tags', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.expenseTags.length,
            itemBuilder: (BuildContext context, int index){
              final tag = provider.expenseTags[index];
              return ListTile(
                title: Text(tag.name),
                trailing: IconButton(
                  onPressed: () => provider.removeExpenseTag(tag.id),
                  icon: Icon(Icons.delete, color: Colors.red,)
                ),
              );
            }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTagDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}