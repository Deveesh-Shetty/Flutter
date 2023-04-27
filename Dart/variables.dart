void main() {
  String name = "Deveesh";
  const year = 2003;
  final currentYear = DateTime.now();

  // Final is evaluated during run time
  // Const is evaluated during compile time also they are implicitly final

  var hobbies = ["Coding", "Sketching", "Drawing"];
  var more = {
    "tags": ["letsgo", "learnmore"],
    "langauage": {
      "primary": "Tulu",
      "international": "English",
      "national": "Hindi"
    }
  };

  int age = 19;

  print(name);
  print(year);
  print(currentYear);
  print(hobbies);
  print(more);
}
