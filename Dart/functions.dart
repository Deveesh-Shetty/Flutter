import 'dart:io';

int sum(int a, int b) {
  return a + b;
}

void main() {
  int n1, n2;
  stdout.write("Enter first number: ");
  n1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter second number: ");
  n2 = int.parse(stdin.readLineSync()!);

  print("Sum is ${sum(n1, n2)}");
}
