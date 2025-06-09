

import 'package:flutter/material.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/presentation/screens/add_expense_screen.dart';
import 'package:gastos_flutter/presentation/views/expense_by_category.dart';
import 'package:gastos_flutter/presentation/views/expense_by_date.dart';
import 'package:gastos_flutter/presentation/widgets/side_menu.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final colors = Theme.of(context).colorScheme;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
      
        key: scaffoldKey,
      
        appBar: AppBar(
          backgroundColor: colors.primary,
          title: Text('Expense Tracker', style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            //indicatorColor: Colors.white,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            //physics: BouncingScrollPhysics(),
            
            tabs: [
              // TODO: hacer que el que no este elegido se vea un poco transparente
              Tab(child: Text('By Date', style: TextStyle(color: Colors.white),),),
              Tab(child: Text('By Category', style: TextStyle(color: Colors.white),),)
            ]
          ),
        ),
        
        
        body: Consumer<ExpenseProvider>(
          builder: (context, provider, child) {
            return TabBarView(
              children: <Widget>[
                ExpenseByDate(provider: provider,),
                ExpenseByCategory() // TODO: hacer funcionalidad y agregar como parametro required el provider
              ]
            );
          },
        ),
      
      
        drawer: SideMenu(scaffoldKey: scaffoldKey,),
      
      
      
      
      
      
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
      ),
    );
  }
}