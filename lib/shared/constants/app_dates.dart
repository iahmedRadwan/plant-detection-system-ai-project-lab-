import 'package:intl/intl.dart';

import 'app_constant.dart';

class AppDateTimeHelper {

  // Example: January, February
  static String getFullMonthName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat.MMMM(AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: Jan, Feb
  static String getAbbreviationMonthName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat.MMM(AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 1, 2, 15, 30
  static String getDayNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat("d", AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: Monday, Tuesday
  static String getFullDayName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat.EEEE(AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: Mon, Tue
  static String getAbbreviationDayName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat.E(AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 15,January
  static String getDayNumberAndFullMonthName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat("dd,MMMM", AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 15,Jan
  static String getDayNumberAndAbbreviationMonthName(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat("dd,MMM", AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 3:45 PM, 11:30 AM
  static String getHoursWithAmPm(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat('h:mm a', AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: January,2024
  static String getFullMonthNameAndYearNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat('MMMM,yyyy', AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: Jan,2024
  static String getAbbreviationMonthNameAndYearNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat('MMM,yyyy', AppConstantsHelper.language??"en").format(dateTime);
  }
  ///////////////////////////////////////////////////////////////////////////////
  // Example: 15,January,2024
  static String getDayNumberAndFullMonthNameAndYearNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat('d,MMMM,yyyy', AppConstantsHelper.language??"en").format(dateTime);
  }
  ///////////////////////////////////////////////////////////////////////////////
  // Example: 15,Jan,2024
  static String getDayNumberAndAbbreviationMonthNameAndYearNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat('d,MMM,yyyy', AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 15/01/2024
  static String getDayNumberAndMonthNumberAndYearNumber(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat("dd/MM/yyyy", AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  // Example: 15/01/2024 03:45 PM
  static String getDayNumberAndMonthNumberAndYearNumberAndHours(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    return DateFormat("dd/MM/yyyy hh:mm a", AppConstantsHelper.language??"en").format(dateTime);
  }
  //////////////////////////////////////////////////////////////////////////////
  static String calculateDaysAgo(String appointmentTimestamp) {
    DateTime dateTime = DateTime.parse(appointmentTimestamp);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return Intl.message(
        'Today',
        name: 'today',
        locale: AppConstantsHelper.language??"en",
      );
    } else if (difference.inDays == 1) {
      return Intl.message(
        'Yesterday',
        name: 'yesterday',
        locale: AppConstantsHelper.language??"en",
      );
    } else if (difference.inDays <= 7) {
      return Intl.message(
        '${difference.inDays} days ago',
        args: [difference.inDays],
        name: 'daysAgo',
        locale: AppConstantsHelper.language??"en",
      );
    } else {
      // Format the date in a specific format if more than a week ago
      return getDayNumberAndMonthNumberAndYearNumber(appointmentTimestamp);
    }
  }
}
