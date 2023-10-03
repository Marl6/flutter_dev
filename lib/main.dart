import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedMethod = "Please select";
  String selectedEquation = "Please select";
  double height = 0.0;
  double weight = 0.0;
  double dbw = 0.0;
  double calculatedValue = 0.0;
  double age = 0.0;

  // Controllers for text fields
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();

  // Input validation for numeric input
  final numericValidator =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  // Variables for Harris-Benedict Equation
  String gender = "Male";
  String activityLevel = "Sedentary";

  // Variables for Oxford Equation
  String ageGroup = "Age 18 - < 30";

  // Calculate BMR using the Harris-Benedict Equation
  void _calculateHarrisBenedictBMR() {
    double bmr;
    if (gender == "Male") {
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
    }

    switch (activityLevel) {
      case "Sedentary":
        bmr *= 1.2;
        break;
      case "Lightly Active":
        bmr *= 1.375;
        break;
      case "Moderately Active":
        bmr *= 1.55;
        break;
      case "Very Active":
        bmr *= 1.725;
        break;
      case "Super Active":
        bmr *= 1.9;
        break;
      default:
        break;
    }

    setState(() {
      calculatedValue = bmr;
    });
  }

  // Calculate BMR using the Mifflin-St Jeor Equation
  void _calculateMifflinStJeorBMR() {
    double bmr = 9.99 * weight + 6.25 * height - 4.92 * age + 5;
    setState(() {
      calculatedValue = bmr;
    });
  }

  // Calculate BMR using the Oxford Equation
  void _calculateOxfordBMR() {
    double bmr;
    switch (ageGroup) {
      case "Age 18 - < 30":
        bmr = (gender == "Male") ? 16.0 * dbw + 545 : 13.1 * dbw + 558;
        break;
      case "Age 30 - < 60":
        bmr = (gender == "Male") ? 14.2 * dbw + 593 : 9.74 * dbw + 694;
        break;
      case "Age 60 - 69":
        bmr = (gender == "Male") ? 13.0 * dbw + 567 : 10.2 * dbw + 572;
        break;
      case "Age 70+":
        bmr = (gender == "Male") ? 13.7 * dbw + 481 : 10.0 * dbw + 577;
        break;
      default:
        bmr = 0.0;
        break;
    }
    setState(() {
      calculatedValue = bmr;
    });
  }

  // Calculate DBW using the Tannhauser Method (Broca’s Index)
  void _calculateTannhauserDBW() {
    double heightInCM = double.tryParse(heightController.text) ?? 0.0;
    double paksiw = heightInCM - 100;
    dbw = paksiw - (0.10 * paksiw);
  }

  void _calculateHamwiWeight() {
    double heightInCM = double.tryParse(heightController.text) ?? 0.0;

    double cmToInches = heightInCM * 0.3937; // Inches VALUE
    double cmToFt = heightInCM * 0.0328084; // feet VALUE
    double male = 106;
    double female = 100;

    /////MAAAALEEEEE//////
    //Get the inches below 5ft MALE
    double mlessthan5 = cmToInches -
        5; // For example the height is 4.7ft, the answer will be -0.3
    double mlessthan5SemiFinal = (mlessthan5 * -10); //convert -0.3 to 3
    double mlessthan5Final = mlessthan5SemiFinal * 6; //Deduct 3*6= 18lbs
    double mdeductLess = male - mlessthan5Final; // (106 - 18) = 88lbs

    //Get the inches above 5ft MALE
    double mabove5 = cmToInches -
        5; // For example the height is 5.5ft, the answer will be 0.5
    double mabove5SemiFinal = mabove5 * 10; //convert 0.5 to 5
    double mabove5Final = mabove5SemiFinal * 6; // Add  5*6= 30lbs
    double maddabove = male + mabove5Final; // 106lbs + 30lbs =  136lbs

    /////FEMALEEEE//////
    //Get the inches below 5ft MALE
    double lessthan5 = cmToInches -
        5; // For example the height is 4.7ft, the answer will be -0.3
    double lessthan5SemiFinal = (lessthan5 * -10); //convert -0.3 to 3
    double lessthan5Final = lessthan5SemiFinal * 5; //Deduct 3*6= 18lbs
    double deductLess = female - lessthan5Final; // (106 - 18) = 88lbs

    //Get the inches above 5ft MALE
    double above5 = cmToInches -
        5; // For example the height is 5.5ft, the answer will be 0.5
    double above5SemiFinal = above5 * 10; //convert 0.5 to 5
    double above5Final = above5SemiFinal * 5; // Add  5*6= 30lbs
    double addabove = female + above5Final; // 106lbs + 30lbs =  136lbs

    if (gender == "Male") {
      if (cmToFt < 5) {
        mdeductLess;
      }
       else {
        maddabove;
      }
    } else {
      if (cmToFt < 5) {
        deductLess;
      } else {
        addabove;
      }
    }
  }

  // Calculate DBW using the BMI method
  void _calculateBMIWeight() {
    double heightInCM = double.tryParse(heightController.text) ?? 0.0;

    double cmToFeet = 0.0328; // 1 cm = 0.0328 ft //FT
    double cmToInch = 0.3937; // 1 cm = 1 inch // INCH
    double inchToMeters = 0.0254; // 1 inch =  0.0254 meter

    // Conversion
    double finalfeet = heightInCM * cmToFeet;
    double finalinch = heightInCM * cmToInch;

    double partial = finalfeet * finalinch;
    double semitotal = partial * inchToMeters;

    double multiply = semitotal * semitotal;
    double square = multiply * multiply;
    dbw = square * 22;
  }

  @override
  void dispose() {
    // Clean up controllers
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Calculator"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stepper(
                currentStep: currentStep,
                onStepContinue: () {
                  if (currentStep == 0) {
                    if (weightController.text.isEmpty ||
                        heightController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Please enter valid weight and height."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                  }

                  setState(() {
                    if (currentStep < 2) {
                      currentStep++;
                      if (currentStep == 1) {
                        if (selectedMethod ==
                            "Tannhauser Method (Broca’s Index)") {
                          _calculateTannhauserDBW();
                        } else if (selectedMethod == "Hamwi Formula") {
                          _calculateHamwiWeight();
                        } else if (selectedMethod == "BMI Method") {
                          _calculateBMIWeight();
                        }
                      } else if (currentStep == 2) {
                        if (selectedEquation == "Harris-Benedict Equation") {
                          _calculateHarrisBenedictBMR();
                        } else if (selectedEquation == "Oxford Equation") {
                          _calculateOxfordBMR();
                        } else if (selectedEquation ==
                            "Mifflin-St Jeor Equation") {
                          _calculateMifflinStJeorBMR();
                        }
                      }
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep--;
                    }
                  });
                },
                steps: [
                  Step(
                    title: Text("Get the Desirable Body Weight (DBW)"),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select a method:"),
                        DropdownButton<String?>(
                          value: selectedMethod,
                          items: <String?>[
                            "Please select",
                            "Tannhauser Method (Broca’s Index)",
                            "Hamwi Formula",
                            "BMI Method",
                        
                          ].map((String? value) {
                            return DropdownMenuItem<String?>(
                              value: value,
                              child: Text(value ?? ""),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMethod = newValue ?? "Please select";
                            });
                          },
                        ),
                        if (selectedMethod == "Tannhauser Method (Broca’s Index)") ...[
                          SizedBox(height: 16.0),
                          Text("Enter height in cm:"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            inputFormatters: [numericValidator],
                            decoration: InputDecoration(
                              labelText: "Height (cm)",
                            ),
                          ),
                        ],
                        if (selectedMethod == "BMI Method") ...[
                          SizedBox(height: 16.0),
                          Text("Enter height in cm:"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            inputFormatters: [numericValidator],
                            decoration: InputDecoration(
                              labelText: "Height (cm)",
                            ),
                          ),
                        ],
                        if (selectedMethod == "Hamwi Formula") ...[
                          SizedBox(height: 16.0),
                          Text("Enter height in kg: "),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            inputFormatters: [numericValidator],
                            decoration: InputDecoration(
                              labelText: "Height (cm)",
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text("Enter height in cm: "),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            inputFormatters: [numericValidator],
                            decoration: InputDecoration(
                              labelText: "Height (cm)",
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text("Select your gender:"),
                          DropdownButton<String>(
                            value: gender,
                            items: ["Male", "Female"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                gender = newValue ?? "Male";
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  Step(
                    title: Text("Estimate the Total Energy Requirement (TER)"),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select an equation:"),
                        DropdownButton<String>(
                          value: selectedEquation,
                          items: <String>[
                            "Please select",
                            "Harris-Benedict Equation",
                            "Mifflin-St Jeor Equation",
                            "Oxford Equation",
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedEquation = newValue ?? "Please select";
                            });
                          },
                        ),
                        if (selectedEquation == "Harris-Benedict Equation") ...{
                          SizedBox(height: 16.0),
                          Text("Select your gender:"),
                          DropdownButton<String>(
                            value: gender,
                            items: ["Male", "Female"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                gender = newValue ?? "Male";
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          Text("Enter age in years:"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            inputFormatters: [numericValidator],
                            onChanged: (value) {
                              setState(() {
                                age = double.tryParse(value) ?? 0.0;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Age (years)",
                            ),
                          ),
                        },
                        if (selectedEquation == "Oxford Equation") ...{
                          SizedBox(height: 16.0),
                          Text("Select age group:"),
                          DropdownButton<String>(
                            value: ageGroup,
                            items: [
                              "Age 18 - < 30",
                              "Age 30 - < 60",
                              "Age 60 - 69",
                              "Age 70+",
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                ageGroup = newValue ?? "Age 18 - < 30";
                              });
                            },
                          ),
                        },
                        if (selectedEquation == "Oxford Equation" ||
                            selectedEquation == "Mifflin-St Jeor Equation") ...{
                          SizedBox(height: 16.0),
                          Text("Enter age in years:"),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            inputFormatters: [numericValidator],
                            onChanged: (value) {
                              setState(() {
                                age = double.tryParse(value) ?? 0.0;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Age (years)",
                            ),
                          ),
                        },
                      ],
                    ),
                  ),
                  Step(
                    title: Text("Determine the amount of macronutrients"),
                    content: Column(
                      children: [
                        // Add a table for step 3 here
                      ],
                    ),
                  ),
                ],
              ),
              if (currentStep == 1 && dbw > 0.0) ...{
                SizedBox(height: 16.0),
                Text(
                  "The calculated DBW from $selectedMethod is $dbw",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              },
              if (currentStep == 2) ...{
                SizedBox(height: 16.0),
                Text(
                  "The calculated value using $selectedEquation is $calculatedValue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              },
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (currentStep < 2) {
                setState(() {
                  currentStep++;
                  if (currentStep == 1) {
                    if (selectedMethod == "Tannhauser Method (Broca’s Index)") {
                      _calculateTannhauserDBW();
                    } else if (selectedMethod == "Hamwi Formula") {
                      _calculateHamwiWeight();
                    } else if (selectedMethod == "BMI Method") {
                      _calculateBMIWeight();
                    }
                  } else if (currentStep == 2) {
                    if (selectedEquation == "Harris-Benedict Equation") {
                      _calculateHarrisBenedictBMR();
                    } else if (selectedEquation == "Oxford Equation") {
                      _calculateOxfordBMR();
                    } else if (selectedEquation == "Mifflin-St Jeor Equation") {
                      _calculateMifflinStJeorBMR();
                    }
                  }
                });
              }
            },
            child: Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Calculated Values",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text("DBW: $dbw"),
                Text("TER: $calculatedValue"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
