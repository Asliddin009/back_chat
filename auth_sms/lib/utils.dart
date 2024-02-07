abstract class Utils {
  static DateTime convertStringToDateTime(String yyyymmdd) {
    int yyyy = int.parse(yyyymmdd.substring(0, 4));
    int mm = int.parse(yyyymmdd.substring(5, 7));
    int dd = int.parse(yyyymmdd.substring(8, 10));
    late DateTime dateTimeObject;
    dateTimeObject = DateTime(yyyy, mm, dd);
    return dateTimeObject;
  }

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
    String ddmmyyyyhhmm = "$year-$month-$day  $hour:$minute";
    return ddmmyyyyhhmm;
  }
}
