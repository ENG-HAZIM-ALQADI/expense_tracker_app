
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpensesItem extends StatelessWidget{
  const ExpensesItem(this.expenses,{super.key});

  final Expense expenses;

  @override
  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
        child: Column(
        children: [
          Text(expenses.title,style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\$${expenses.amount.toStringAsFixed(2)}'),
             const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expenses.category]),
                  const SizedBox(width: 8,),
                  Text(expenses.formatedDate),
                ],
              ),
            ],
          ),
        ],
              ),
      ),);
  }
}