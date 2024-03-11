import 'package:flutter/material.dart';
// import 'package:flutter_application_2/widgets/background.dart';
// import 'package:flutter_application_2/pages/paymentSuccessfulPage.dart';
// import 'package:flutter_application_2/widgets/appbar.dart';
import '../widgets/components.dart';
import 'drawer.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String _selectedFilter = 'All';
  late DateTime _selectedDate;

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
      // appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      // drawer: NavDrawer(),
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
                              Icon(Icons.arrow_drop_down,
                                  color: Color.fromRGBO(24, 70, 126, 1)),
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
                          items: <String>['All', 'Card', 'App', 'Load']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromRGBO(24, 70, 126, 1)),
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
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: SizedBox(
                                  width: 300, // Adjusted width
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 55),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          _buildFilteredTransactions()[index]
                                              ['details'],
                                    ),
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildFilteredTransactions() {
    List<Map<String, dynamic>> transactions = [
      {
        'Amount': '-PHP 1800.00',
        'Ref Code': 'ORNZNXS8YX7JUYBXVA2',
        'Payment Method': 'CARD',
        'Route': 'ALABANG STARMALL-NAGA, CAMARINES SUR',
        'Date': '2024-03-03',
        'Time': '3:13 PM',
        'Status': 'PAID',
      },
      {
        'Amount': '-PHP 13.00',
        'Ref Code': 'ORNWGG66P2HV6UUAQ7T',
        'Payment Method': 'LOAD',
        'Service Fee': '5.00',
        'Date': '2024-03-03',
        'Time': '11:35 PM',
        'Status': 'PAID',
      },
      {
        'Amount': '+PHP 100.00',
        'Reference Code': 'ORNZNXS8YX7JUYBXVA2',
        'Payment Method': 'CARD',
        'Service Fee': '5.00',
        'Date': '2024-03-04',
        'Time': '3:13 PM',
        'Status': 'SUCCESSFUL',
      },
      {
        'Amount': '+PHP 100.00',
        'Reference Code': 'ORNZNXS8YX7JUYBXVA2',
        'Payment Method': 'APP',
        'Service Fee': '5.00',
        'Date': '2024-03-04',
        'Time': '3:13 PM',
        'Status': 'SUCCESSFUL',
      },
    ];

    List<Map<String, dynamic>> filteredTransactions = [];

    for (var transaction in transactions) {
      DateTime transactionDate = DateTime.parse(transaction['Date']);
      if (_selectedDate.year == transactionDate.year &&
          _selectedDate.month == transactionDate.month &&
          _selectedDate.day == transactionDate.day) {
        if (_selectedFilter.toLowerCase() == 'all' ||
            transaction['Payment Method'].toLowerCase() ==
                _selectedFilter.toLowerCase()) {
          filteredTransactions
              .add({'details': _buildTransactionDetails(transaction)});
        }
      }
    }
    return filteredTransactions;
  }

  List<Widget> _buildTransactionDetails(Map<String, dynamic> transaction) {
    List<Widget> details = [];
    transaction.forEach((key, value) {
      if (key == 'Status') {
        details.add(_buildTableRow(key, value, transaction['Status']!));
      } else {
        details.add(_buildTableRow(key, value.toString(), ''));
      }
    });
    return details;
  }

  Widget _buildTableRow(String label, String value, String status) {
    bool isPaid =
        status.toLowerCase() == 'paid' || status.toLowerCase() == 'successful';
    bool isFailed = status.toLowerCase() == 'failed';
    bool isAmount = label.toLowerCase() == 'amount';
    bool isPositiveAmount = value.startsWith('+');
    bool isNegativeAmount = value.startsWith('-');

    Color? amountColor;
    if (isAmount) {
      if (isPositiveAmount) {
        amountColor = Color.fromRGBO(47, 128, 237, 1);
      } else if (isNegativeAmount) {
        amountColor = Color.fromRGBO(236, 28, 36, 1);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromRGBO(77, 76, 77, 1),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 82.0),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isPaid
                    ? Color.fromRGBO(19, 233, 109, 1)
                    : isFailed
                        ? Color.fromRGBO(236, 28, 36, 1)
                        : amountColor ?? Colors.black,
                fontStyle:
                    isPaid || isFailed ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
    );
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
              primary:
                  Color.fromRGBO(239, 139, 6, 1), // header background color
              onPrimary:
                  Color.fromARGB(255, 255, 255, 255), // header text color
              surface: const Color.fromARGB(255, 255, 255, 255),
              onSurface:
                  const Color.fromARGB(255, 30, 30, 30), // body text color
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
}
