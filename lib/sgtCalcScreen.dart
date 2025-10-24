import 'package:flutter/material.dart';

class SGTCalcScreen extends StatefulWidget {
  const SGTCalcScreen({super.key});

  @override
  State<SGTCalcScreen> createState() => _SGTCalcScreenState();
}

class _SGTCalcScreenState extends State<SGTCalcScreen> {

  String typeSaving = 'Weekly';//for dropdown of type saving(weekly/daily)

  //untuk retrieve user input drp textfields
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController savingPerWeekController = TextEditingController();
  TextEditingController startingAmountController = TextEditingController();

  //variable to store calc results, initially 0
  double weeksNeeded =0;
  double monthsNeeded =0;

  // FocusNode to set focus back to first field after reset
  FocusNode targetFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving Goal Tracker" , style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromARGB(255, 117, 187, 217),
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Container(
            //padding: const EdgeInsets.fromLTRB(20, 16, 0 , 100),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            //margin: const EdgeInsets.fromLTRB(16, 80, 16, 80),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 229, 229),
            ),
            
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Calculate Your Saving Goal' , 
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 42, 76, 136),
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
                SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width:130, child: Text('Type Saving')),
                    DropdownButton<String>(
                      value: typeSaving,
                      items: <String>['Weekly','Monthly'].map((String value){
                        return DropdownMenuItem<String>(
                          value:value,
                          child: Text(value) ,
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        typeSaving = newValue!;
                        setState(() {});
                      }
                    ),
                  ],
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    //User enter amount saving/week
                    SizedBox(width: 130, child: Text('Saving Amount')), //width 130 jarak antara kotak dengan title(text)
                    SizedBox(
                      width: 170,
                      child: TextFormField(
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
                SizedBox(height: 10),
                //Calculate and reset button
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width:10),
                    ElevatedButton(
                      onPressed: calculateSGT, 
                      /*style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 117, 187, 217),
                        foregroundColor: Colors.white,
                      ),*///call function
                      child: Text('Calculate'), 
                    ),
                    SizedBox(height:20 ,width:20),
                    ElevatedButton(
                      onPressed: () {
                        //clear all input
                        savingPerWeekController.clear();
                        targetAmountController.clear();
                        startingAmountController.clear();

                        //reset dropdownbutton to default
                        typeSaving = 'Weekly';

                        //set focus back to first field 
                        FocusScope.of(context).requestFocus(targetFocusNode);
                        targetFocusNode.requestFocus();

                        //reset all variable
                        weeksNeeded =0;
                        monthsNeeded=0;

                        setState((){});
                      },
                      /*style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 117, 187, 217),
                        foregroundColor: Colors.white,
                      ),*/
                      child:Text('Reset'),
                    ),
                  ],
                ),
                //untuk display result
                //SizedBox(height:10),
                SizedBox(height: 10),
                Container(
                  //width: double.infinity,
                  margin: const EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(164, 131, 151, 161),
                  ),
                  child: Column(children: [
                    const Text(
                      'Result:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 28, 26, 149),
                      ),
                    ),
                    SizedBox(height: 10),
                    //Display with 2 decimal places
                    Text(
                      'Weeks Needed: ${weeksNeeded.toStringAsFixed(2)} weeks ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Months Needed: ${monthsNeeded.toStringAsFixed(2)} months',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void calculateSGT(){
    double target = double.tryParse(targetAmountController.text)??0;
    double starting = double.tryParse(startingAmountController.text) ?? 0; 
    double weekSaving = double.tryParse(savingPerWeekController.text) ?? 0;
    //String errorMessage = '';

    //Input validatin 1: Check if field empty for each text
    if(target==0){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter target amount.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //update ui =0
      setState(() {
        weeksNeeded=0;
        monthsNeeded=0;
      });
      return;
    }
    if(starting ==0){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter starting amount.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //update ui =0
      setState(() {
        weeksNeeded=0;
        monthsNeeded=0;
      });
      return;
    }
    if(weekSaving ==0){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter saving.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //update ui =0
      setState(() {
        weeksNeeded=0;
        monthsNeeded=0;
      });
      return;
    }
    
    //Input validation 2: Check if value is -ve @ buat satu2
    if(target.isNegative || starting.isNegative || weekSaving.isNegative){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter positive value.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //update ui =0
      setState(() {
        weeksNeeded=0;
        monthsNeeded=0;
      });
      return;
    }

     //calculate amount to be saved
    double amountNeed = target - starting;
    //adjust saving/week base on type saving
    double savingPerWeek = weekSaving;

    if(typeSaving == 'Weekly'){ //no change
      savingPerWeek = weekSaving;
    } else if (typeSaving == 'Monthly'){
      savingPerWeek = weekSaving/4;
    }
    //calc no of week needed to reach goal
    double weeks = amountNeed/savingPerWeek;

    //convert week to month
    double months = weeks/4;

    double finalWeeks = double.parse(weeks.toStringAsFixed(2));
    double finalMonths = double.parse(months.toStringAsFixed(2));

    //output where ui is updated
    setState(() {
      weeksNeeded = finalWeeks;
      monthsNeeded = finalMonths;
    });
  }
}