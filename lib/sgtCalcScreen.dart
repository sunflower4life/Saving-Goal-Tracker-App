import 'package:flutter/material.dart';

class SGTCalcScreen extends StatefulWidget {
  const SGTCalcScreen({super.key});

  @override
  State<SGTCalcScreen> createState() => _SGTCalcScreenState();
}

class _SGTCalcScreenState extends State<SGTCalcScreen> {

  //untuk retrieve user input drp textfields
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController savingPerWeekController = TextEditingController();
  TextEditingController startingAmountController = TextEditingController();

  //variable to store calc results, initially 0
  int weeksNeeded =0;
  int daysNeeded = 0;

  // FocusNode to set focus back to first field after reset
  FocusNode targetFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving Goal Tracker" , 
        style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(232, 240, 215, 161),
      ),
      body:Container(
        color: const Color.fromARGB(255, 247, 237, 215),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(20.0),
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white70,
                //color: const Color.fromARGB(255, 234, 229, 229),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //header title
                  Text('Calculate Your Saving Goal' , 
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color:Colors.brown,
                  ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      //User enter starting amount
                      SizedBox(width: 130, child: Text('Target Amount')),//width 130 jarak antara kotak dengan title(text)
                      SizedBox(
                        width: 170,
                        child: TextField(
                          controller: targetAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Target(RM)',
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
                        width: 170,
                        child: TextField(
                          controller: startingAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Starting(RM)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      //User enter amount saving/week
                      SizedBox(width: 130, child: Text('Weekly Saving')), //width 130 jarak antara kotak dengan title(text)
                      SizedBox(
                        width: 170,
                        child: TextField(
                          controller: savingPerWeekController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Saving(RM)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Calculate and reset button
                  SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //button for calculate Saving goal + icon calculate
                      ElevatedButton.icon(
                        onPressed: calculateSGT, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(232, 240, 215, 161),
                          foregroundColor: Color.fromARGB(255, 99, 74, 38),
                        ),
                        //call function
                        icon: Icon(Icons.calculate),
                        label: Text('Calculate'),
                      ),
                      //button for Reset + icon reset
                      ElevatedButton.icon(
                        onPressed: () {
                          //clear all input
                          savingPerWeekController.clear();
                          targetAmountController.clear();
                          startingAmountController.clear();

                          //set focus back to first field 
                          FocusScope.of(context).requestFocus(targetFocusNode);
                          targetFocusNode.requestFocus();

                          //reset all output variable
                          weeksNeeded =0;
                          daysNeeded = 0;

                          setState((){});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(232, 240, 215, 161),
                          foregroundColor:Color.fromARGB(255, 99, 74, 38),
                        ),
                        icon: Icon(Icons.refresh),
                        label:Text('Reset'),
                        
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //result display container
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromARGB(255, 240, 222, 168),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Time Needed:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 99, 74, 38),
                          ),
                        ),
                        SizedBox(height: 10),
                        //Display with 2 decimal places
                        Text(
                          '$weeksNeeded weeks and $daysNeeded days',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void calculateSGT(){
    // Parse inputs using double.tryParse with ?? 0
    double target = double.tryParse(targetAmountController.text)??0;
    double starting = double.tryParse(startingAmountController.text) ?? 0; 
    double weekSaving = double.tryParse(savingPerWeekController.text) ?? 0;

    //Input validatin 1: Check if field empty for each text
    if (target == 0 || weekSaving == 0) {
      // Show SnackBar for empty fields
      SnackBar snackBar = const SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Reset result to 0
      setState(() {
        weeksNeeded = 0;
        daysNeeded = 0;
      });
      return; // Stop execution if validation fails
    }
    
    //Input validation 2: Check if value is -ve @ buat satu2
    if(target.isNegative || starting.isNegative || weekSaving.isNegative){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter positive value.'),
        //backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //update ui, result set to 0
      setState(() {
        weeksNeeded=0;
        daysNeeded = 0;
      });
      return;
    }
     //calculate amount to be saved, how much money still needed
    double amountNeed = target - starting;

    //calc no of week needed to reach goal, week = amount needed / money saved/ week
    double totalWeeks = amountNeed/weekSaving;

    //seperate into weeks and days
    int fullWeeks = totalWeeks.floor(); //get whole no (2.5 = 2)
    double remainingWeeks = totalWeeks - fullWeeks; //get decimal
    int extraDays = (remainingWeeks * 7).round(); //convert to days
    //output where ui is updated
    setState(() {
      weeksNeeded = fullWeeks;
      daysNeeded = extraDays;
    });
  }
}