abstract class Utils {
  static String convertDateTimeToString(DateTime dateTime) {
    String year = dateTime.year.toString();

    String month = dateTime.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = dateTime.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    String hour = dateTime.hour.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }

    String minute = dateTime.minute.toString();
    if (minute.length == 1) {
      minute = '0$minute';
    }
    String ddmmyyyyhhmm = "$day.$month.$year $hour:$minute";
    return ddmmyyyyhhmm;
  }
}
