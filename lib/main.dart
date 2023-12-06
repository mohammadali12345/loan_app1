import 'package:flutter/material.dart';
import 'payment_page.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController _controller1 =new TextEditingController();
  TextEditingController _controller2 =new TextEditingController();
  TextEditingController _controller3 =new TextEditingController();
  String selected='';
  double totalInterest=0;
  double monthlyInterest=0;
  double monthlyInstallment=0;

  void loancalculation(){
    final amount =int.parse(_controller1.text)-int.parse(_controller2.text);
    final total_interest = amount * (double.parse(_controller3.text)/100)*int.parse(selected);
    final monthly_interest=total_interest/(int.parse(selected)*12);
    final monthly_payment =(amount+total_interest) /(int.parse(selected)*12);
    setState(() {
      totalInterest=total_interest;
      monthlyInterest=monthly_interest;
      monthlyInstallment=monthly_payment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Icon(Icons.notes,
            size: 30,
            color:Colors.black),
        toolbarHeight: 60,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
              padding:const EdgeInsets.only(right:15.0),
              child:
              Icon(
                Icons.info,
                size: 30,
                color: Colors.black,
              )
          )],
      ),
      body: SingleChildScrollView(
        child:body(),
      ),
    );
  }
  Widget body(){
    return Container(
      color: Colors.grey[100],
      child: Column(children: [
        Container(height: 170,decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius:BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
          child:Padding(
            padding:const EdgeInsets.only(top:20.0),

            child:Align(
              alignment: Alignment.center,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children:[
                  Text("Car Loan",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Calculator",
                    style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),

          ),
        ),
        SizedBox(height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30,10,40,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputForm(title:"Car Price",hinText:"ex: 90000\$",
                  controller: _controller1),
              inputForm(title:"Down Payment",hinText:"ex: 9000\$",
                  controller: _controller2),
              inputForm(title:"Interest Rate",hinText:"ex: 3.5",
                  controller: _controller3),
              Text("Loan Period",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,

              ),
              Row(
                children: [
                  loanPeriod("1"),
                  loanPeriod("2"),
                  loanPeriod("3"),
                  loanPeriod("4"),
                  loanPeriod("5"),



                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  loanPeriod("6"),
                  loanPeriod("7"),
                  loanPeriod("8"),
                  loanPeriod("9"),



                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (){
                  loancalculation();


                  showModalBottomSheet(
                      isDismissible: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      context: context, builder: (BuildContext context){
                    return Container(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,30,0,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("Result",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            result(
                              title: "Total Interest",
                              amount: totalInterest,
                            ),
                            result(
                              title: "Monthly Interest",
                              amount: monthlyInterest,
                            ),
                            result(
                              title: "Monthly Installment",
                              amount: monthlyInstallment,
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: ()  {
                                Navigator.pop(context);
                                // Navigate to PaymentPage and await the result
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PaymentPage()),
                                ).then((result) {
                                // Check if payment was accepted
                                if (result == true) {
                                // Clear data if payment was accepted
                                _controller1.clear();
                                _controller2.clear();
                                _controller3.clear();
                                setState(() {
                                selected = '';
                                });
                                }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),);
                  });
                },

                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(child :
                  Text("Calculate",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),




                  ),
                ),
              )
            ],

          ),
        )




      ],

      ),
    );
  }
  Widget result({required String title,required double amount}){
    return  ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),

      trailing: Padding(
        padding:const EdgeInsets.only(right: 20.0),
        child:Text(
          "\$" +amount.toStringAsFixed(2),
          style: TextStyle(
              fontSize: 20),
        ),
      ),
    );
  }


  Widget loanPeriod( String title){
    return  GestureDetector(
      onTap: (){
        setState(() {
          selected=title;
        });

      },

      child:Padding(padding: const EdgeInsets.fromLTRB(0,2 ,10 ,0 ),
        child: Container(
          height: 40,
          width:40,
          decoration: BoxDecoration(
            border: title==selected
                ?Border.all(color: Colors.red,width: 2)
                :null,
            color: Colors.blue,borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
  Widget inputForm({required String title,required TextEditingController controller,required  hinText}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none),
                hintText: hinText),
          ),
        ),
        SizedBox(height:
        10,)



      ],
    );
  }
}

