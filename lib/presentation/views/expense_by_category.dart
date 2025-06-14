import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/presentation/screens/view_expense_screen.dart';
import 'package:intl/intl.dart';



class ExpenseByCategory extends StatelessWidget {
  final ExpenseProvider provider;

  const ExpenseByCategory({
    super.key,
    required this.provider
  });


  @override
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  return (provider.expenses.isNotEmpty)
  ?ListView.builder(
    itemCount: provider.expenseCategories.length,
    itemBuilder: (context, index) {
      final category = provider.expenseCategories[index];
      final expenses = provider.expenses.where((e) => e.categoryId == category.name).toList();
      final double totalAmount = expenses.fold<double>(0, (sum, e) => sum + e.amount);

      return ExpansionTile(
        title: Text(
          '${category.name} - Total \$$totalAmount',
          style: TextStyle(color: colors.primary, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        children: expenses.map((expense) => ListTile(
          leading: Icon(Icons.monetization_on, color: colors.primary,),
          title: Text('${expense.payee} - \$${expense.amount}'),
          subtitle: Text(DateFormat('MMM dd, yyyy').format(expense.date)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ViewExpenseScreen(expenseId: expense.id))
            );
          },
        )).toList(),
      );
    },
  )
  :Center(
    child: Text('Click the "+" button to record expenses.', style: TextStyle(color: Colors.black45, fontSize: 20),),
  );
}
}