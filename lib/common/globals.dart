/// Greetings
String getGreeting() {
  int hour = DateTime.now().hour;

  if (hour < 12) {
    return "Good Morning User";
  } else if (hour < 18) {
    return "Good Afternoon User";
  } else {
    return "Good Evening User";
  }
}
