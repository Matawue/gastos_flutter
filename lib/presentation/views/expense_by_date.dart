import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/domain/entities/expense.dart';
import 'package:gastos_flutter/presentation/screens/view_expense_screen.dart';
import 'package:intl/intl.dart';



class ExpenseByDate extends StatelessWidget {

  final ExpenseProvider provider;

  const ExpenseByDate({
    super.key,
    required this.provider
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    final List<Expense> sortedByDate = List<Expense>.from(provider.expenses)
    ..sort((a, b) => int.parse(DateFormat('yyyyMMdd').format(b.date))
    .compareTo(int.parse(DateFormat('yyyyMMdd').format(a.date))));
    return (provider.expenses.isNotEmpty)
    ?ListView.builder(
            itemCount: sortedByDate.length,
            itemBuilder: (context, index){
              final expense = sortedByDate[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                elevation: 3,
                child: ListTile(
                  //contentPadding: EdgeInsets.all(20),
                  //contentPadding: EdgeInsets.fromLTRB(20, 5, 5, 10),
                  
                  tileColor: colors.inversePrimary,
                
                  title: Text('${expense.payee} - \$${expense.amount}'),
                  subtitle: Text('${DateFormat('MMM dd, yyyy').format(expense.date)} - Category: ${expense.categoryId}'),
                  trailing: IconButton(
                    onPressed: () => provider.removeExpense(expense.id),
                    icon: Icon(Icons.delete, color: Colors.red,)
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewExpenseScreen(expenseId: expense.id,)
                      )
                    );
                  },
                ),
              );
            }
          )
    :Center(
      child: Text('Click the "+" button to record expenses.', style: TextStyle(color: Colors.black45, fontSize: 20),)
    );
  }
}