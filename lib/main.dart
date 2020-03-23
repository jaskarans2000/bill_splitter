import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()=> runApp(
  MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  )
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double billAmount=0;
  int tipPercentage=0;
  double personAmount=0;
  int personCount=1;
  double tipAmount=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:40),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  width: 600.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.purpleAccent.shade100.withOpacity(0.2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Total per person",
                      style: TextStyle(
                       color: Colors.indigo,
                       fontSize: 16.0
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("\$${personAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 55.0,
                          color: Colors.indigo,
                        ),),
                      ),
                    ],
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left:10.0,right: 10.0,top: 40.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        prefixText: "Bill Amount",
                        prefixStyle: TextStyle(
                          color: Colors.grey,
                        )
                      ),
                      onChanged: (value){
                        setState(() {
                          billAmount=double.parse(value);
                          personAmount=(billAmount+tipAmount)/personCount;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Split",
                            style: TextStyle(color: Colors.grey,
                            fontSize: 16.0),),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(personCount>1)
                                      personCount=personCount-1;
                                      personAmount=(billAmount+tipAmount)/personCount;
                                    });
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.purpleAccent.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Icon(Icons.remove,size: 20.0,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Text("${personCount}",
                                style: TextStyle(color: Colors.purpleAccent,
                                fontSize: 18.0,fontWeight: FontWeight.w600),),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    personCount=personCount+1;
                                    personAmount=(billAmount+tipAmount)/personCount;
                                  });
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.purpleAccent.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                  child: Icon(Icons.add,size: 20.0,),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tip",
                          style: TextStyle(color: Colors.grey,fontSize: 16.0),),
                          Text("\$${tipAmount}",
                            style: TextStyle(color: Colors.purpleAccent,fontSize: 18.0),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text("$tipPercentage %",
                          style: TextStyle(color: Colors.purpleAccent,fontSize: 18.0),),
                          Slider(value: tipPercentage.toDouble(),
                              onChanged: (value){
                            setState(() {
                              tipPercentage=value.toInt();
                              tipAmount=(tipPercentage/100)*billAmount;
                              personAmount=(billAmount+tipAmount)/personCount;
                            });
                              },
                          max: 100,
                            activeColor: Colors.purpleAccent,
                          min: 0,
                          divisions: 20,)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}