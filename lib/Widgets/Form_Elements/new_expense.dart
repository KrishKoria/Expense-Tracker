import 'package:expense_tracker/Models/expense_model.dart';
import 'package:expense_tracker/main.dart';
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
          title: Text(
            "Invalid Input",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: kColorScheme.primary,
                ),
          ),
          content: Text(
            "Please Enter Valid Data",
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18),
          ),
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
    final overlappedSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + overlappedSpace),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 50,
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: "Amount",
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              prefix: const Text("\$ "),
                            ),
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      maxLength: 50,
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  if (width >= 600)
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontSize: 16)),
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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No Date Chosen"
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: _datePicker,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: "Amount",
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              prefix: const Text("\$ "),
                            ),
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No Date Chosen"
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 13),
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
                  if (width >= 600)
                    Row(
                      children: [
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
                    )
                  else
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
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
            ),
          ),
        );
      },
    );
  }
}
