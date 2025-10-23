import 'package:flutter/material.dart';

class SGTCalcScreen extends StatefulWidget {
  const SGTCalcScreen({super.key});

  @override
  State<SGTCalcScreen> createState() => _SGTCalcScreenState();
}

class _SGTCalcScreenState extends State<SGTCalcScreen> {

  String typeSaving = 'Weekly';//for dropdown of type saving(weekly/daily)

  TextEditingController targetAmountController = TextEditingController();
  TextEditingController savingPerWeekController = TextEditingController();
  TextEditingController startingAmountController = TextEditingController();

  double weeksNeeded =0;
  double monthsNeeded =0;

  FocusNode targetFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saving Goal Tracker" , style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromARGB(255, 117, 187, 217),
      ),
      body:Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 0 , 100),
          //padding: const EdgeInsets.all(40.0),
          //margin: const EdgeInsets.all(40.0),
          margin: const EdgeInsets.fromLTRB(16, 80, 16, 80),
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
                children: [
                  //User enter target amount
                  SizedBox(width: 130, child: Text('Target Amount')),
                  SizedBox(
                    width: 170,
                    child: TextField(
                      controller: targetAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Target (RM)',
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
                    width: 170,
                    child: TextField(
                      controller: startingAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Starting (RM)',
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
                    items: <String>['Weekly','Daily'].map((String value){
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
              //Calculate and reset button
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width:10),
                  ElevatedButton(
                    onPressed: calculateSGT, 
                    /*style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 117, 187, 217),
                      foregroundColor: Colors.white,
                    ),*///call function
                    child: Text('Calculate'), 
                  ),
                  /*Text('Result...'
                  ),*/
                  SizedBox(height:50 ,width:20),
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
              Container(
                //width: double.infinity,
                margin: const EdgeInsets.all(10.0),
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
                  Text(
                    'Time Needed: ${weeksNeeded.toStringAsFixed(1)} weeks ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Approximately: ${monthsNeeded.toStringAsFixed(1)} months',
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
    );
  }
  void calculateSGT(){
    double target = double.tryParse(targetAmountController.text)??0;
    double starting = double.tryParse(savingPerWeekController.text)??0;
    double weekSaving = double.tryParse(startingAmountController.text)??0;

    String errorMessage = '';
    //validate input and show error message
    //target amount must be >0
    if(target<=0){
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
    }
    //no need to save money if starting > target
    if (starting >= target) {
      errorMessage = 'Congratulations! You have already reached your goal! 🎉';
      setState(() {
        weeksNeeded = 0;
        monthsNeeded = 0;
      });
      return;
    }

    double amountNeed = target - starting;
    double savingPerWeek = weekSaving;

    if(typeSaving == 'Weekly'){
      savingPerWeek = weekSaving;
    }
  }
}