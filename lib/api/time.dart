class Time {
  int minute;
  int second;

  int inSeconds() {
    return minute * 60 + second;
  }

  Time(this.minute, this.second);

  static String dateTimeToHourOfDayString(DateTime time) {
    String h = time.hour.toString().padLeft(2, '0');
    String m = time.minute.toString().padLeft(2, '0');
    String s = time.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Time.fromDuration(Duration duration) {
    minute = duration.inMinutes;
    second = duration.inSeconds - duration.inMinutes * 60;
  }
}
