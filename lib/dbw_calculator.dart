double dbw = 0.0;

class DBWCalculator {
  double calculateTannhauserDBW(double heightInCM) {
    dbw = heightInCM - 100;
    // Deduct 10% from the calculated DBW
    dbw = dbw - (0.10 * dbw);
    return dbw;
  }

  double calculateHamwiDBW(double heightInCM, double weight, String gender) {
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
        return mdeductLess;
      } else {
        return maddabove;
      }
    } else {
      if (cmToFt < 5) {
        return deductLess;
      } else {
        return addabove;
      }
    }
  }

  double calculateBMIWeight(double heightInCM) {
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
    return dbw;
  }
}
