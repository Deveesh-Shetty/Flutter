import 'dart:io';

void main() {
  int age;
  stdout.write("Enter age: ");
  String? input = stdin.readLineSync();
  age = int.parse(input!);

  // Or  input = int.parse(stdin.readLineSync()!);

  if (age >= 18) {
    print("Eligible to vote!!!");
  } else {
    print("Not eligible to vote :(");
  }
}
