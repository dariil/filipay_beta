import 'package:flutter/material.dart';
import '../widgets/components.dart';

class AccountLimitsPage extends StatefulWidget {
  const AccountLimitsPage({super.key});
  

  @override
  State<AccountLimitsPage> createState() => _AccountLimitsPageState();
}

class _AccountLimitsPageState extends State<AccountLimitsPage> {
  pageComponents myComponents = pageComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back_sharp,
                )
              ),
              myComponents.background(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Jeepney"),
                    Text("Transaction Completed"),
                    Text("Payment Successful"),
                    Container(
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}