import "dart:io";

void main() {
  stdout.write("Enter your name: ");
  var name = stdin.readLineSync();
  // Reads a single byte if I enter Dev it will only take D as 68
  // It reads ascii character of all values
  // var name = stdin.readByteSync();

  print("Hello $name!!");
}
