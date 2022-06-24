import 'package:_save_karo/db/catogary/catogrydb.dart';
import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction/transcationDB.dart';
import 'addTransactionPage.dart';

// ignore: must_be_immutable
class EditAndDelet extends StatefulWidget {
  EditAndDelet({Key? key, required this.dats}) : super(key: key);
  TranscationModel dats;

  @override
  State<EditAndDelet> createState() => _EditAndDeletState();
}

class _EditAndDeletState extends State<EditAndDelet> {
  DateTime? _selectedDate;
  CatogaryType? _selectedCatogaryType;
  CatogeryModel? _selectedCatogaryModel;
  TranscationModel? transactionMOdel;

  String? catogaryID;
  final _enterAmountTextEditingControler = TextEditingController();
  final _enterNotesTextEditingControler = TextEditingController();

  @override
  void initState() {
    _selectedCatogaryType = widget.dats.type;
    _enterAmountTextEditingControler.text = widget.dats.amount.toString();
    _enterNotesTextEditingControler.text = widget.dats.purpose;
    _selectedDate = widget.dats.date;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
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
                      icon: const Icon(Icons.arrow_back),
                      color: backroundUnselectedColur,
                    ),
                    const Center(
                      child: Text(
                        "Add Transcation",
                        style: TextStyle(
                            fontFamily: fontFamilyCustome,
                            fontSize: 20,
                            color: backroundUnselectedColur,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
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
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.date_range,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  child: Text(
                      _selectedDate == null
                          ? " Click to selecte date "
                          : DateFormat('MMMMd').format(_selectedDate!),
                      style: genaralTextStyle),
                  onPressed: () async {
                    final selectedDateTemb = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    {
                      setState(() {
                        _selectedDate = selectedDateTemb;
                      });
                    }
                  },
                )
              ],
            ),
            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  // ignore: sort_child_properties_last
                  child: const Icon(
                    Icons.money,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: _enterAmountTextEditingControler,
                    //   autofocus: true,
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
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  // ignore: sort_child_properties_last
                  child: const Icon(
                    Icons.notes,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(20),
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
                    value: CatogaryType.icome,
                    groupValue: _selectedCatogaryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCatogaryType = CatogaryType.icome;
                        catogaryID = null;
                      });
                    }),
                const Text("Income"),
                const SizedBox(width: 20),
                Radio(
                    value: CatogaryType.expence,
                    groupValue: _selectedCatogaryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCatogaryType = CatogaryType.expence;
                        catogaryID = null;
                      });
                    }),
                const Text("Expance"),
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
                ),
                //CATOGARY SELECTION-----------------------------------------------------
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 190,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: backroundColure,
                        ),
                        onPressed: () {
                          editCatogary();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20, fontFamily: fontFamilyCustome),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 90,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: backroundColure,
                        ),
                        onPressed: () {
                          showConfrom(
                            context,
                          );
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 20, fontFamily: fontFamilyCustome),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showConfrom(
    context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete  Transcation',
            style: genaralTextStyle,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text(
                  'Are you sure want to delete this  Transaction',
                  style: genaralTextStyle,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: expenseTextColure, fontFamily: fontFamilyCustome),
              ),
              onPressed: () {
                TranscationDb.instance.deleteTransaction(widget.dats.id);
                deleted();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: totelTextColure, fontFamily: fontFamilyCustome),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> editCatogary() async {
    final amounttext = _enterAmountTextEditingControler.text;
    final notetext = _enterNotesTextEditingControler.text;
    final id = widget.dats.id;
    final checkeAmount = double.tryParse(amounttext);
    if (amounttext.isEmpty ||
        notetext.isEmpty ||
        _selectedCatogaryModel == null ||
        _selectedDate == null ||
        checkeAmount == null) {
      return nullCheck();
    }

    final model2 = TranscationModel(
      purpose: notetext,
      amount: checkeAmount,
      date: _selectedDate!,
      type: _selectedCatogaryType!,
      catogaryModel: _selectedCatogaryModel!,
      id: id,
    );
    await TranscationDb.instance.editTransaction(widget.dats.id, model2);
    TranscationDb.instance.refreshUi();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
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
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  deleted() {
    {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backroundColure,
        content: const Text('Transcation Deleted',
            style: TextStyle(fontSize: 15, fontFamily: fontFamilyCustome)),
        action: SnackBarAction(
          label: 'Ok',
          textColor: backroundUnselectedColur,
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
