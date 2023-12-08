import 'package:flutter/material.dart';

import '../model/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key ,required this.onAddExpense});

  final void Function(Expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose(); //مسح البيانات من الذاكره المحجوزه
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePocker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final packerDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = packerDate;
    });
  }

  void _submitExpenseData() {
    final _enteredAmount = double.tryParse(_amountController
        .text); // tryParse اذا كان المدخل غير رقمي يرجع لنا فاضي واذا كام المدخل رقمي ولكن مكتوبه بشكل غير صحيح فانه يصلحه
    final amountIsInvalid = _enteredAmount == null || _enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please make sure a valid title, amount, date and category was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: _enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,46,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Selected Date'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePocker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase().toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
