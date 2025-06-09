import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/presentation/widgets/add_category_dialog.dart';
import 'package:provider/provider.dart';


class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text('Manage Categories', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),

      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.expenseCategories.length,
            itemBuilder: (context, index) {
              final category = provider.expenseCategories[index];
              return ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    provider.removeExpenseCategory(category.id);
                  },
                  icon: Icon(Icons.delete, color: Colors.red,)
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddCategoryDialog()
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}