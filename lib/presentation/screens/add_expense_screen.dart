import 'package:flutter/material.dart';
import 'package:gastos_flutter/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gastos_flutter/config/providers/expense_provider.dart';
import 'package:gastos_flutter/domain/entities/expense.dart';



class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddExpenseScreen({
    super.key,
    this.expense
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController _amountController = TextEditingController();
  //final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  //final TextEditingController _tagController = TextEditingController();
  String? _selectedCategory;
  String? _selectedTag;
  bool editExpense = false;
  String? expenseId;



  @override
  void initState() {
    super.initState();
    if(widget.expense != null){
      _amountController.text = '${widget.expense!.amount}';
      _payeeController.text = widget.expense!.payee;
      _noteController.text = widget.expense!.note;
      _dateController.text = '${widget.expense!.date}';
      _selectedCategory = widget.expense!.categoryId;
      _selectedTag = widget.expense!.tag;
      editExpense = true;
      expenseId = widget.expense!.id;
    }
  }

  



  @override
  Widget build(BuildContext context) {
  

    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (editExpense)? Text('Edit Expense') :Text('Add Expense'),
        backgroundColor: colors.primary,
      ),

      resizeToAvoidBottomInset: false,

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

            SizedBox(height: 15,),

            TextField(
              controller: _payeeController,
              decoration: InputDecoration(
                labelText: 'Payee',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 15,),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'note',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 15,),

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

            SizedBox(height: 15,),
     
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: provider.expenseCategories.any((c) => c.name == _selectedCategory)
                      ? _selectedCategory
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: provider.expenseCategories.map((category) {
                    return DropdownMenuItem(
                      value: category.name,
                      child: Text(category.name, style: TextStyle(fontWeight: FontWeight.w400),),
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

            SizedBox(height: 10,),
            
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: provider.expenseTags.any((tag) => tag.name == _selectedTag)
                  ? _selectedTag
                  : null,
                  decoration: InputDecoration(
                    labelText: 'Tag',
                    border: OutlineInputBorder()
                  ),
                  items: provider.expenseTags.map((tag) {
                    return DropdownMenuItem(
                      value: tag.name,
                      child: Text(tag.name, style: TextStyle(fontWeight: FontWeight.w400)),
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

            SizedBox(height: 5,),

            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddCategoryDialog() 
                );
              },
              child: const Text('Go to add a new category')
            ),

            SizedBox(height: 5,),

            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddTagDialog()
                );
              },
              child: Text('Go to add a new tag')
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
    if(_selectedCategory != null && _selectedTag != null){
      final expense = Expense(
      id: (editExpense) ? expenseId! : DateTime.now().millisecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text),
      categoryId: _selectedCategory!,
      payee: _payeeController.text,
      note: _noteController.text,
      date: DateTime.parse(_dateController.text),
      tag: _selectedTag!
    );
    (editExpense) ? Provider.of<ExpenseProvider>(context, listen: false).addOrUpdateExpense(expense) : Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    //_tagController.dispose();
    _amountController.dispose();
    //_categoryIdController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    _payeeController.dispose();
    super.dispose();
  }
}