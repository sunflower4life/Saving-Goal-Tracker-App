import 'package:flutter/material.dart';

class SGTCalcScreen extends StatefulWidget {
  const SGTCalcScreen({super.key});

  @override
  State<SGTCalcScreen> createState() => _SGTCalcScreenState();
}

class _SGTCalcScreenState extends State<SGTCalcScreen> {

  TextEditingController targetAmountController = TextEditingController();
  TextEditingController savingPerWeekController = TextEditingController();
  TextEditingController startingAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving Goal Tracker Screen" , style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromARGB(255, 98, 179, 213),
      ),
      body:Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  //User enter target amount
                  SizedBox(width: 130, child: Text('Target Amount')),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: targetAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Target Amount (RM)',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  //User enter amount saving/week
                  SizedBox(width: 130, child: Text('Weekly Saving')), //width 130 jarak antara kotak dengan title(text)
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: savingPerWeekController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Saving (RM)',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  //User enter starting amount
                  SizedBox(width: 130, child: Text('Starting Amount')),//width 130 jarak antara kotak dengan title(text)
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: targetAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Starting Amount',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width:10),
                  ElevatedButton(onPressed: calculateSGT,//call function
                   child: Text('Calculate'), 
                  ),
                  /*Text('Result...'
                  ),*/
                  SizedBox(height:50 ,width:20),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        savingPerWeekController.clear();
                        targetAmountController.clear();
                        startingAmountController.clear();
                      });
                    },
                    child:Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void calculateSGT(){}
}