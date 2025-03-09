// • A group of ITI friends decide to run a Marathon. Their names and times (in minutes) are below:
//  • Name Time (minutes)
//  • Ahmed 341
//  • Mohamed 273
//  • Ismail 278
//  • Hend329
//  • Aly 445
//  • Hossam402
//  • Ola 388
//  • Alaa275
//  • Basma243
//  • Mina 334
//  • Nada 412
//  • Saad393
//  • •Find the fastest runner. Print the name and his/her time (in minutes).
//  • •Optional: Find the second fastest runner. Print the name and his/her time (in minutes)

class Student implements Comparable<Student> {
  final String name;
  final int time;

  Student(this.name, this.time);

  @override
  int compareTo(Student other) {
    if (this.time > other.time) return 1;
    else if (this.time < other.time) return -1;
    else return 0;
  }

  @override
  String toString() { return '$name: $time'; } // Fixed: lowercase 't' and proper placement
}

void main() {
  List<Student> students = [ // Fixed: commas instead of semicolons
    Student('Ahmed', 341),
    Student('Mohamed', 273),
    Student('Ismail', 278),
    Student('Hend', 329),
    Student('Aly', 445),
    Student('Hossam', 402),
    Student('Ola', 388),
    Student('Alaa', 275),
    Student('Basma', 243),
    Student('Mina', 334),
    Student('Nada', 412),
    Student('Saad', 393),
  ]; // Added missing semicolon

  students.sort(); // Sort the list based on time

  // Find fastest runner
  Student fastest = students.first;
  print('Fastest runner: ${fastest.toString()}');

  // Find second fastest runner
  if (students.length >= 2) {
    Student secondFastest = students[1];
    print('Second fastest runner: ${secondFastest.toString()}');
  }
}