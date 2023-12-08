// import 'package:expense_tracker_app/widgets/expenses_item.dart';
// import 'package:flutter/material.dart';
//
// import '../model/expense.dart';
//
// class ExpensesList extends StatelessWidget {
//   const ExpensesList({
//     super.key,
//     required this.expenses,
//     required this.onRemoveExpense,
//   });
//
//   final List<Expense> expenses;
//   final void Function(Expense expense) onRemoveExpense;
//
//   @override
//   Widget build(BuildContext contex) {
//     return ListView.builder(
//         itemCount: expenses.length,
//         itemBuilder: (ctx, index) => Dismissible(
//             key: ValueKey(expenses[index]),
//             background: Container(
//               color: Theme.of(context).colorScheme
//                   .error
//                   .withOpacity(0.75),
//               margin: EdgeInsets.symmetric(
//                 horizontal: Theme.of(context)
//                     .cardTheme
//                     .margin!
//                     .horizontal,
//               ),
//             ),
//             onDismissed: (direction) {
//               onRemoveExpense(expenses[index]);
//             },
//             child: ExpensesItem(expenses[index])));
//   }
// }
import 'package:expense_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}