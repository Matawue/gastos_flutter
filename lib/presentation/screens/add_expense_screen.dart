import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/domain/entities/expense.dart';



class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  String? _selectedCategory;
  String? _selectedTag;







  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        backgroundColor: colors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20,),

            TextField(
              controller: _payeeController,
              decoration: InputDecoration(
                labelText: 'Payee',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'note',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () async{
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100)
                    );
                    if(pickedDate != null){
                      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      _dateController.text = formattedDate;
                    }
                  },
                )
              ),            
              readOnly: true,
            ),

            SizedBox(height: 20,),
     
            // TODO: Quiero que si esta vacio, mande a agregar una categoria al category management por medio de un boto 
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder()
                  ),
                  items: provider.expenseCategories.map((category) {
                    return DropdownMenuItem(
                      value: category.name,
                      child: Text(category.name),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                );
              },
            ),

            SizedBox(height: 20,),
            
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: _selectedTag,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder()
                  ),
                  items: provider.expenseTags.map((tag) {
                    return DropdownMenuItem(
                      value: tag.name,
                      child: Text(tag.name),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      _selectedTag = value;
                    });
                  }
                );
              },
            ),

         

            Spacer(),

            FilledButton(
              onPressed: () => _saveExpense(context),
              style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: size.width*0.354, vertical: size.height*0.02))),
              child: Text('Save Expense',)
            ),
          ],
        ),
      ),

    );
  }

  void _saveExpense(BuildContext context){
    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text),
      categoryId: _categoryIdController.text,
      payee: _payeeController.text,
      note: _noteController.text,
      date: DateTime.parse(_dateController.text),
      tag: _tagController.text
    );
    Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tagController.dispose();
    _amountController.dispose();
    _categoryIdController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    _payeeController.dispose();
    super.dispose();
  }
}