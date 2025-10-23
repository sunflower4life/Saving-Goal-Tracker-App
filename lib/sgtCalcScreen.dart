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

  //store calc result
  String errorMessage = '';

  //untuk error message(border color)
  bool isTargetValid = true;
  bool isSavingValid = true;
  bool isStartingValid = true;

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
                ),),
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 130, child: Text('Target Amount')),
                    SizedBox(
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: targetAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter Target (RM)',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: isTargetValid ? Colors.grey : Colors.red,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          if (!isTargetValid)
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0, left: 4.0),
                              child: Text(
                                'Please enter a valid target amount',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
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
                      child: TextFormField(
                        controller: startingAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Starting (RM)',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isStartingValid ? Colors.grey : Colors.red,
                              width: isTargetValid ? 1.0 : 2.0,
                            ),
                          ),
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
                      width: 170,
                      child: TextFormField(
                        controller: savingPerWeekController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Saving (RM)',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isSavingValid ? Colors.grey : Colors.red,
                              width: isTargetValid ? 1.0 : 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:10),
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
                //RED INLINE BOX
                /*if (errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: errorMessage.contains('Congratulations')
                          ? Colors.green[50]
                          : Colors.red[50],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: errorMessage.contains('Congratulations')
                            ? Colors.green
                            : Colors.red,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          errorMessage.contains('Congratulations')
                              ? Icons.check_circle
                              : Icons.warning,
                          color: errorMessage.contains('Congratulations')
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: errorMessage.contains('Congratulations')
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                const SizedBox(height: 10),
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

    isTargetValid = true;
    isStartingValid = true;
    isSavingValid = true;
    errorMessage = '';

    if (target <= 0) {
      isTargetValid = false; // Highlight border in red
      errorMessage = 'Please enter a valid target amount greater than 0';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
      });
      return; // Stop execution if validation fails
    }

    // Validate starting amount (cannot be negative)
    if (starting < 0) {
      isStartingValid = false; // Highlight border in red
      errorMessage = 'Starting balance cannot be negative';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
      });
      return; // Stop execution if validation fails
    }

    // Validate weekly saving (must be > 0)
    if (weekSaving <= 0) {
      isSavingValid = false; // Highlight border in red
      errorMessage = 'Please enter a valid weekly saving amount greater than 0';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
      });
      return; // Stop execution if validation fails
    }

    // Check if goal is already reached
    if (starting >= target) {
      errorMessage = 'Congratulations! You have already reached your goal! 🎉';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
      });
      return; // Stop execution if already at goal
    }
    //handle empty input
    /*if(target.isNegative || starting.isNegative){
      SnackBar snackBar = const SnackBar(
        content: Text('Please enter valid amount. Starting balance cannot be negative.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }*/
    //validate input and show error message
    //target amount must be >0
    /*if(target<=0){
      setState(() {
        errorMessage = 'Please enter valid target amount';
        setState(){
          weeksNeeded =0;
          monthsNeeded=0;
        }
      });
      return;
    }
    //starting cannot be <0
    if(starting<0){
      errorMessage = 'Starting balance cannot be negative';
      setState((){
        weeksNeeded =0;
        monthsNeeded=0;
      });
      return;
    }*/
    //no need to save money if starting > target
    if (starting >= target) {
      errorMessage = 'Congratulations! You have already reached your goal! 🎉';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
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