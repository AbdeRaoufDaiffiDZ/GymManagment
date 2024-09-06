import 'package:admin/data/mongo_db.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  final String Income;
  final String password;
  final BuildContext Connttexxt;
  final String gender;
  const Calculator(
      {super.key,
      required this.gender,
      required this.Connttexxt,
      required this.Income,
      required this.password});
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  @override
  void initState() {
    _expression = widget.Income;
    _output = widget.Income;
    super.initState();
  }

  _changePassCheck(String pass1, String pass2, BuildContext conteext) async {
    MongoDatabase mg = MongoDatabase();

    if (pass1 == pass2) {
      final data = await mg.ChangePassword(pass1,
          context: conteext, gender: widget.gender);
      if (data.isRight && data.right == "done") {
        textController.clear();
        textController2.clear();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "password changed sucessfully",
                    style: TextStyle(color: Colors.green),
                  )),
            );
          },
        );
        Future.delayed(Duration(seconds: 3), () {
          if (Navigator.canPop(context)) {
            Navigator.of(context)
                .pop(); // Close the dialog without doing anything
            if (Navigator.canPop(context)) {
              Navigator.of(context)
                  .pop(); // Close the dialog without doing anything
            }
            if (Navigator.canPop(context)) {
              Navigator.of(context)
                  .pop(); // Close the dialog without doing anything
            }
          }
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Password not the same",
                  style: TextStyle(color: Colors.red),
                )),
          );
        },
      );
    }
  }

  void _buttonPressed(String buttonText, BuildContext Contttext) {
    MongoDatabase mg = MongoDatabase();
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
      } else if (buttonText == "=") {
        // Evaluate the expression
        try {
          _output = _expression.isEmpty ? "0" : _evaluateExpression();
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "مسح جميع معلومات الدين، المداخيل و المصروفات") {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter Your Input'),
              content: TextField(
                obscureText: true, // Obscures the text input
                controller: textController,
                onSubmitted: (value) async {
                  if (textController.text == widget.password) {
                    final message =
                        await mg.eraseAllDate(false, context: Contttext, gendeer: widget.gender);
                    if (message.isRight) {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context)
                            .pop(); // Close the dialog without doing anything
                      }
                    } else if (message.isLeft) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text("Try again...")),
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Password Error Try again...")),
                        );
                      },
                    );
                  }
                  textController.clear();
                },
                decoration: InputDecoration(hintText: "Type password..."),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the dialog without doing anything
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (textController.text == widget.password) {
                      mg.eraseAllDate(false, context: Contttext, gendeer: widget.gender);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text("Password Error Try again...")),
                          );
                        },
                      );
                    }
                    textController.clear();

                    if (Navigator.canPop(context)) {
                      Navigator.of(context)
                          .pop(); // Close the dialog without doing anything
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      } else if (buttonText == "مسح جميع معلومات") {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter Your Input'),
              content: TextField(
                obscureText: true, // Obscures the text input
                controller: textController,
                onSubmitted: (value) {
                  if (textController.text == widget.password) {
                    mg.eraseAllDate(true, context: Contttext, gendeer: widget.gender);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Password Error Try again...")),
                        );
                      },
                    );
                  }
                  textController.clear();

                  if (Navigator.canPop(context)) {
                    Navigator.of(context)
                        .pop(); // Close the dialog without doing anything
                  }
                },
                decoration: InputDecoration(hintText: "Type password..."),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the dialog without doing anything
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (textController.text == widget.password) {
                      mg.eraseAllDate(true, context: Contttext, gendeer: widget.gender);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text("Password Error Try again...")),
                          );
                        },
                      );
                    }
                    textController.clear();

                    if (Navigator.canPop(context)) {
                      Navigator.of(context)
                          .pop(); // Close the dialog without doing anything
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      } else if (buttonText == "تغير كلمة السر") {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Change Password'),
              content: Column(
                children: [
                  TextField(
                    obscureText: true, // Obscures the text input
                    controller: textController,
                    onSubmitted: (value) async {
                      _changePassCheck(
                          textController.text, textController2.text, Contttext);
                    },
                    decoration: InputDecoration(hintText: "Type password..."),
                  ),
                  TextField(
                    obscureText: true, // Obscures the text input
                    controller: textController2,
                    onSubmitted: (value) async {
                      _changePassCheck(
                          textController.text, textController2.text, Contttext);
                    },
                    decoration:
                        InputDecoration(hintText: "Type again the password..."),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the dialog without doing anything
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _changePassCheck(
                        textController.text, textController2.text, Contttext);
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      } else if (buttonText == "Ok") {
        _output = _expression.isEmpty ? "0" : _evaluateExpression();

        editIncome(_output, widget.gender);
        Future.delayed(Duration(seconds: 2));
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      } else {
        if (_expression.length > 0 || buttonText != "0") {
          _expression += buttonText;
        }
        _output = _expression;
      }
    });
  }

  void editIncome(String value, String gender) {
    MongoDatabase mongoDatabase = MongoDatabase();
    mongoDatabase.EditIncome(value, context: context, gendeer: gender);
  }

  String _evaluateExpression() {
    // This is a simple implementation. In a real-world scenario, you would want to use a more robust math parser.
    try {
      final result = calculateExpression(_expression).toInt().toString();
      return result;
    } catch (e) {
      return "Error";
    }
  }

  double calculateExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();
    return exp.evaluate(EvaluationType.REAL, contextModel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildButtonRow([
                "7",
                "8",
                "9",
              ]),
              _buildButtonRow([
                "4",
                "5",
                "6",
              ]),
              _buildButtonRow([
                "1",
                "2",
                "3",
              ]),
              _buildButtonRow([
                "C",
                "0",
                "=",
              ]),
              _buildButtonRow(["Ok", "+", "-"]),
              _buildButtonRow([""]),
              _buildButtonRow(["مسح جميع معلومات الدين، المداخيل و المصروفات"]),
              _buildButtonRow(["مسح جميع معلومات"]),
              _buildButtonRow([""]),
              _buildButtonRow(["تغير كلمة السر"]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((String buttonText) {
          return Expanded(
            child: MaterialButton(
              color: Colors.grey,
              onPressed: () => _buttonPressed(buttonText, widget.Connttexxt),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
