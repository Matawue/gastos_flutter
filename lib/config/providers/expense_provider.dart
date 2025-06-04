import 'dart:convert';
import 'package:gastos_flutter/domain/entities/expense_category.dart';
import 'package:gastos_flutter/domain/entities/expense_tag.dart';
import 'package:localstorage/localstorage.dart';

import 'package:flutter/material.dart';

import 'package:gastos_flutter/domain/entities/expense.dart';


class ExpenseProvider with ChangeNotifier{

  final LocalStorage storage;

  List<Expense> _expenses = [];
  List<ExpenseCategory> _expenseCategories = [];
  List<ExpenseTag> _expenseTags = [];



  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get expenseCategories => _expenseCategories;
  List<ExpenseTag> get expenseTags => _expenseTags;

  ExpenseProvider(this.storage) {
    _loadExpensesFromStorage();
  }


  void _loadExpensesFromStorage() {
    //WidgetsFlutterBinding.ensureInitialized();
    //await initLocalStorage();

    var storedExpenses = storage.getItem('expenses');
    var storedExpenseCategories = storage.getItem('expenseCategories');
    var storedExpenseTags = storage.getItem('expenseTags');

    if (storedExpenses != null){
      _expenses = List<Expense>.from(
        (jsonDecode(storedExpenses) as List).map((item) => Expense.fromJson(item)),
      );
    }

    if (storedExpenseCategories != null){
      _expenseCategories = List<ExpenseCategory>.from(
        (jsonDecode(storedExpenseCategories) as List).map((item) => ExpenseCategory.fromJson(item)),
      );
    }

    if (storedExpenseTags != null){
      _expenseTags = List<ExpenseTag>.from(
        (jsonDecode(storedExpenseTags) as List).map((item) => ExpenseTag.fromJson(item)),
      );
    }

    notifyListeners();
  }

  // Expense
  void _saveExpensesToStorage() {
    final gastosJson = jsonEncode(_expenses.map((e) => e.toJson()).toList());
    storage.setItem('expenses', gastosJson);
    _loadExpensesFromStorage();
  }
  
  // Categories
  void _saveExpenseCategoriesToStorage() {
    final categoriasJson = jsonEncode(_expenseCategories.map((e) => e.toJson()).toList());
    storage.setItem('expenseCategories', categoriasJson);
    _loadExpensesFromStorage();
  }

  // Tags
  void _saveExpenseTagsToStorage() {
    final tagsJson = jsonEncode(_expenseTags.map((e) => e.toJson()).toList());
    storage.setItem('expenseTags', tagsJson);
    _loadExpensesFromStorage();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveExpensesToStorage();
    notifyListeners();
  }

  void addExpenseCategory(ExpenseCategory category) {
    _expenseCategories.add(category);
    _saveExpenseCategoriesToStorage();
    notifyListeners();
  }

  void addExpenseTag(ExpenseTag tag) {
    _expenseTags.add(tag);
    _saveExpenseTagsToStorage();
    notifyListeners();
  }

  void addOrUpdateExpense(Expense expense) {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }
    _saveExpensesToStorage();
    notifyListeners();
  }

  void addOrUpdateExpenseCategory(ExpenseCategory category) {
    int index = _expenseCategories.indexWhere((e) => e.id == category.id);
    if (index != -1) {
      _expenseCategories[index] = category;
    } else {
      _expenseCategories.add(category);
    }
    _saveExpenseCategoriesToStorage();
    notifyListeners();
  }

  void addOrUpdateExpenseTag(ExpenseTag tag) {
    int index = _expenseTags.indexWhere((e) => e.id == tag.id);
    if (index != -1) {
      _expenseTags[index] = tag;
    } else {
      _expenseTags.add(tag);
    }
    _saveExpenseTagsToStorage();
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    _saveExpensesToStorage();
    notifyListeners();
  }

  void removeExpenseCategory(String id) {
    _expenseCategories.removeWhere((e) => e.id == id);
    _saveExpenseCategoriesToStorage();
    notifyListeners();
  }

  void removeExpenseTag(String id) {
    _expenseTags.removeWhere((e) => e.id == id);
    _saveExpenseTagsToStorage();
    notifyListeners();
  }
} 