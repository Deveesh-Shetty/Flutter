import 'dart:io';

void main() {
  for (int i = 0; i < 5; i++) {
    print(i);
  }

  int i = 10;
  while (i < 15) {
    stdout.write("$i ");
    i++;
  }

  print("");

  int j = 50;
  do {
    stdout.write("$j ");
    j--;
  } while (j >= 40);
}
