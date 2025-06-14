import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/presentation/screens/add_expense_screen.dart';

class ViewExpenseScreen extends StatelessWidget {

  final String expenseId;

  const ViewExpenseScreen({
    super.key,
    required this.expenseId
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final expense = provider.expenses.firstWhere((e) => e.id == expenseId);
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.075,
          size.height * 0.1,
          size.width * 0.075,
          0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.inversePrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 11,
                offset: Offset(0, 4),
                spreadRadius: 2,
              ),
            ],
          ),
          
          width: size.width * 0.85,
          height: size.height * 0.70,

          child: Column(
            children: [
              const Text(
                'Expense Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Payee: ${expense.payee}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Amount: ${expense.amount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.description, color: Colors.white),
                title: Text(
                  'note: ${expense.note}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.calendar_month, color: Colors.white),
                title: Text(
                  'Date: ${DateFormat('MMM dd, yyyy').format(expense.date)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.category, color: Colors.white),
                title: Text(
                  'Category: ${expense.categoryId}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.tag, color: Colors.white),
                title: Text(
                  'Tag: ${expense.tag}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_back_ios_outlined),
                label: Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              SizedBox(width: 20),

              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text('Edit'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddExpenseScreen(expense: expense,)
                    )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
