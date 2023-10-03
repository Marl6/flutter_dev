class TERCalculator {
  double calculateHarrisBenedictTER(String gender, double weight, double height,
      double age, String activityLevel) {
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

    return bmr;
  }

  double calculateMifflinStJeorTER(double weight, double height, double age) {
    double bmr = 9.99 * weight + 6.25 * height - 4.92 * age + 5;
    return bmr;
  }

  double calculateOxfordTER(String gender, double dbw, String ageGroup) {
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
    return bmr;
  }
}
