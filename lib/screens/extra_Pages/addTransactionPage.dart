import 'package:_save_karo/db/catogary/catogrydb.dart';
import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction/transcationDB.dart';
import '../working_Pages/catogaryPages/catogaryPage.dart';

class TranscationPageAdd extends StatefulWidget {
  const TranscationPageAdd({Key? key}) : super(key: key);

  @override
  State<TranscationPageAdd> createState() => _TranscationPageAddState();
}

class _TranscationPageAddState extends State<TranscationPageAdd> {
  DateTime? _selectedDate;
  CatogaryType? _selectedCatogaryType;
  CatogeryModel? _selectedCatogaryModel;
  String? catogaryID;
  final _enterAmountTextEditingControler = TextEditingController();
  final _enterNotesTextEditingControler = TextEditingController();
  @override
  void initState() {
    _selectedCatogaryType = CatogaryType.icome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            //Add Transaction Heading
            Container(
              color: backroundColure,
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TranscationPageAdd()));
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: backroundUnselectedColur,
                        )),
                    const Center(
                      child: Text(
                        "Add Transcation",
                        style: TextStyle(
                            fontFamily: fontFamilyCustome,
                            color: backroundUnselectedColur,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TranscationPageAdd()));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: backroundUnselectedColur,
                      ),
                    )
                  ]),
            ),
            Row(
              children: [
                //DATE SELECT
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  // ignore: sort_child_properties_last
                  child: const Icon(
                    Icons.date_range,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                const SizedBox(
                  width: 14,
                ),
                TextButton(
                    onPressed: () async {
                      final selectedDateTemb = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        //  DateTime.now().subtract(const Duration(da)),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDateTemb == null) {
                        return;
                      } else {
                        setState(() {
                          _selectedDate = selectedDateTemb;
                        });
                      }
                    },
                    child: Text(
                        _selectedDate == null
                            ? " Click to selecte date "
                            : DateFormat('MMMMd').format(_selectedDate!),
                        style: genaralTextStyle)),
              ],
            ),

            Row(
              children: [
                //ENTER AMOUNT ROW
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.money,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: _enterAmountTextEditingControler,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter Amount",
                      border: InputBorder.none,
                    ),
                    style: genaralTextStyle,
                  ),
                ),
              ],
            ),
            Row(
              //ENTER NOTES ROW
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.notes,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _enterNotesTextEditingControler,
                    decoration: const InputDecoration(
                      hintText: "Enter Notes",
                      border: InputBorder.none,
                    ),
                    style: genaralTextStyle,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                //SELECT INCOME/EXPENSE
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  // ignore: sort_child_properties_last
                  child: const Icon(
                    Icons.task_alt_outlined,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                Radio(
                    activeColor: incomeTextColure,
                    value: CatogaryType.icome,
                    groupValue: _selectedCatogaryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCatogaryType = CatogaryType.icome;
                        catogaryID = null;
                      });
                    }),
                const Text(
                  "Income",
                  style: genaralTextStyle,
                ),
                const SizedBox(width: 20),
                Radio(
                    activeColor: expenseTextColure,
                    value: CatogaryType.expence,
                    groupValue: _selectedCatogaryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCatogaryType = CatogaryType.expence;
                        catogaryID = null;
                      });
                    }),
                const Text(
                  "Expance",
                  style: genaralTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.category_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ), //selecte catogary
                Row(
                  children: [
                    DropdownButton<String>(
                        hint: const Text("Select Catogary"),
                        value: catogaryID,
                        items: (_selectedCatogaryType == CatogaryType.icome
                                ? CatogaryDB().incomeCatogaryList
                                : CatogaryDB().expenseCatogaryList)
                            .value
                            .map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                            onTap: () {
                              _selectedCatogaryModel = e;
                            },
                          );
                        }).toList(),
                        onChanged: (selectedValue) {
                          setState(() {
                            catogaryID = selectedValue;
                          });
                        }),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CatogaryPage()));
                        },
                        child: const Icon(Icons.add))
                  ],
                ),
              ],
            ), //submit button
            SizedBox(
                width: 50,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: backroundColure,
                    ),
                    onPressed: () {
                      //nullCheck(context);
                      addCatogary();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: backroundUnselectedColur,
                          fontSize: 20,
                          fontFamily: fontFamilyCustome),
                    )))
          ],
        ),
      ),
    );
  }

  nullCheck() {
    {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backroundColure,
        content: const Text('Enter Full Details',
            style: TextStyle(fontSize: 15, fontFamily: fontFamilyCustome)),
        action: SnackBarAction(
          label: 'Undo',
          textColor: backroundUnselectedColur,
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> addCatogary() async {
    final amounttext = _enterAmountTextEditingControler.text;
    final notetext = _enterNotesTextEditingControler.text;
    final checkeAmount = double.tryParse(amounttext);
    final idd = DateTime.now().microsecondsSinceEpoch.toString();
    if (amounttext.isEmpty ||
        notetext.isEmpty ||
        _selectedCatogaryModel == null ||
        _selectedDate == null ||
        checkeAmount == null) {
      return nullCheck();
    } else {
      final model = TranscationModel(
        purpose: notetext,
        amount: checkeAmount,
        date: _selectedDate!,
        type: _selectedCatogaryType!,
        catogaryModel: _selectedCatogaryModel!,
        id: idd,
      );
      await TranscationDb.instance.addTransaction(model);
      submited();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      TranscationDb.instance.refreshUi();
    }
  }

  submited() {
    {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backroundColure,
        content: const Text('Transcation Submited',
            style: TextStyle(fontSize: 15, fontFamily: fontFamilyCustome)),
        action: SnackBarAction(
          label: 'Ok',
          textColor: backroundUnselectedColur,
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
