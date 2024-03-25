import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';
import 'dart:convert';
import 'dart:math';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final _filipay = Hive.box("filipay");
  late DateTime _selectedDate;
  String _selectedFilter = 'All';
  pageFunctions _functions = pageFunctions();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    pageComponents myComponents = pageComponents();
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.3,
                child: myComponents.background(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Color.fromARGB(255, 24, 70, 126),
                  size: 30,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(239, 239, 139, 6),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              bottom: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: 270,
                    height: 39,
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color.fromRGBO(24, 70, 126, 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                '${_formatDate(_selectedDate)}',
                                style: TextStyle(
                                  color: Color.fromRGBO(24, 70, 126, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, color: Color.fromRGBO(24, 70, 126, 1)),
                            ],
                          ),
                        ),
                        VerticalDivider(color: Color.fromRGBO(24, 70, 126, 1)),
                        DropdownButton<String>(
                          value: _selectedFilter,
                          onChanged: (value) {
                            setState(() {
                              _selectedFilter = value!;
                            });
                          },
                          items: <String>['All', 'Online', 'App', 'Load'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromRGBO(24, 70, 126, 1)),
                              ),
                            );
                          }).toList(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromRGBO(24, 70, 126, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: _buildFilteredTransactions().isEmpty
                          ? Center(
                              child: Text(
                                'There are no transactions to display.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(24, 70, 126, 1),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _buildFilteredTransactions().length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> transactionDetails = _buildFilteredTransactions()[index]['details'];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: SizedBox(
                                    width: 300, // Adjusted width
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.symmetric(horizontal: 55),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(242, 249, 255, 1),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: _buildTransactionWidgets(transactionDetails),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                            )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildFilteredTransactions() {
    List<Map<String, dynamic>> filteredTransactions = [];

    int _currently_logged_user = _functions.current_user_id;

    List<dynamic>? hiveTransactionHistory = _filipay.get('user_transactions_$_currently_logged_user', defaultValue: []);

    for (var transaction in hiveTransactionHistory ?? []) {
      String amount = transaction['amount'].toString();
      String referenceCode = transaction['referenceCode'];
      String date = transaction['date'];
      String time = transaction['time'];

      if (transaction['userId'] == _currently_logged_user && (_selectedFilter == 'All' || transaction['Payment Method'] == _selectedFilter)) {
        Map<String, dynamic> transactionDetails = {
          'Amount': '+₱$amount',
          'Reference Code': '$referenceCode',
          'Payment Method': 'Online',
          'Service Fee': '₱5.00',
          'Date': '$date',
          'Time': '$time',
          'Status': 'SUCCESSFUL',
        };

        DateTime transactionDate = DateTime.parse(date);
        if (_selectedDate.year == transactionDate.year && _selectedDate.month == transactionDate.month && _selectedDate.day == transactionDate.day) {
          filteredTransactions.add({'details': transactionDetails});
        }
      }
    }

    print('Filtered Transactions: $filteredTransactions');

    return filteredTransactions;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(239, 139, 6, 1), // header background color
              onPrimary: Color.fromARGB(255, 255, 255, 255), // header text color
              surface: const Color.fromARGB(255, 255, 255, 255),
              onSurface: const Color.fromARGB(255, 30, 30, 30), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromRGBO(24, 70, 126, 1),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  List<Widget> _buildTransactionWidgets(Map<String, dynamic> transactionDetails) {
    List<Widget> widgets = [];

    transactionDetails.forEach((key, value) {
      Color valueColor = Colors.black; // Default color
      if (key == 'Amount' || key == '₱') {
        valueColor = Colors.blue;
      } else if (key == 'Status' && value == 'SUCCESSFUL') {
        valueColor = Colors.green;
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to the end
            children: [
              Text(
                '$key: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.end, // Aligns the text to the right
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: valueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return widgets;
  }
}
