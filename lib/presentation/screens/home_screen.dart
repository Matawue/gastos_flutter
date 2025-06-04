import 'package:flutter/material.dart';
import 'package:gastos_flutter/presentation/screens/add_expense_screen.dart';
import 'package:gastos_flutter/presentation/screens/category_management_screen.dart';
import 'package:gastos_flutter/presentation/screens/tag_management_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text('Expense Tracker', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryManagementScreen() 
                )
              );
            },
            icon: Icon(Icons.track_changes_rounded)
          ),

          SizedBox(width: 20,),


          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TagManagementScreen()
                )
              );
            },
            icon: Icon(Icons.tag)
          )
        ],
      ),






      floatingActionButton: FloatingActionButton(
        onPressed: (){ 
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen()
            )
          );
        },
        child: Icon(Icons.add,),
      ),
    );
  }
}