import 'package:expense_tracker/Models/expense_model.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this._onAddExpense, {super.key});
  final void Function(ExpenseModel) _onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = date;
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (enteredTitle.isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter valid title, amount, date "),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    final newExpense = ExpenseModel(
      title: enteredTitle,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget._onAddExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16 + 8 + 8),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    prefix: const Text("\$ "),
                  ),
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No Date Chosen"
                          : formatter.format(_selectedDate!),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _datePicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(categoryIcons[category]),
                        const SizedBox(width: 8),
                        Text(category.name.toUpperCase(),
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: ((value) {
                  value != null
                      ? setState(
                          () {
                            _selectedCategory = value;
                          },
                        )
                      : null;
                }),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text("Add Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
