import 'dart:io';

void main() {
  runTask1();
  runTask2And3();
  runTask4();
  runTask5();
}

// 2.2. Task 1. Welcome and Environment Info
void runTask1() {
  print('=== Project: BookShelf Console App ===');
  print('Dart Version: ${Platform.version}');
  print('OS: ${Platform.operatingSystem}');
  print('');
}

// 2.3. Task 2 & 2.4. Task 3. Book Data Input & Calculations
void runTask2And3() {
  print('--- Tasks 2 & 3: Book Information Input ---');

  stdout.write('Book Title: ');
  final String title = stdin.readLineSync() ?? 'No Title';

  stdout.write('Book Author: ');
  final String author = stdin.readLineSync() ?? 'Unknown';

  stdout.write('Publication Year: ');
  final int year = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  stdout.write('Number of Pages: ');
  final int pages = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  stdout.write('Rating (0-5): ');
  final double rating = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  stdout.write('Is it read? (yes/no): ');
  final String readAnswer = stdin.readLineSync() ?? 'no';

  final bool isRead =
      readAnswer.trim().toLowerCase() == 'yes' ||
      readAnswer.trim().toLowerCase() == 'y';

  String category;
  if (pages < 150) {
    category = 'brochure';
  } else if (pages <= 399) {
    category = 'book';
  } else {
    category = 'volume';
  }

  final double timeHours = pages / 50;
  final int currentYear = DateTime.now().year;
  final int bookAge = currentYear - year;

  final List<String> authorWords = author.split(' ');
  String initials = '';
  for (final String word in authorWords) {
    if (word.isNotEmpty) {
      initials = '$initials${word.substring(0, 1).toUpperCase()}. ';
    }
  }

  print('');
  print('  Title: $title');
  print('  Author: $author ($initials)');
  print('  Year: $year ($bookAge years ago)');
  print('  Pages: $pages ($category)');
  print('  Rating: $rating / 5');
  print('  Estimated Reading Time: ${timeHours.toStringAsFixed(1)} hours');

  if (isRead) {
    print('  Status: Read');
  } else {
    print('  Status: Not Read');
  }
  print('');
}

// 2.5. Task 4. Collections
void runTask4() {
  print(' Task 4: Collections ');

  final List<String> shelf = [
    'Crime and Punishment',
    '1984',
    'The Master and Margarita',
    'The Hobbit',
    'Dune',
  ];
  print('My book list: $shelf');
  print('Books on shelf: ${shelf.length}');
  print('First book: ${shelf.first}');
  print('Last book: ${shelf.last}');

  shelf.insert(0, 'The Old Man and the Sea');
  shelf.add('The Idiot');
  shelf.remove('1984');
  print('Updated book list: $shelf');
  print('');

  stdout.write('Enter genres separated by comma (e.g. drama,sci-fi,drama): ');
  final String genresLine = stdin.readLineSync() ?? '';
  final List<String> temporaryList = genresLine.split(',');
  final Set<String> genres = temporaryList.toSet();
  print('Unique genres: $genres');
  print('');

  final Map<String, int> pagesByBook = {
    'Crime and Punishment': 600,
    '1984': 320,
    'The Master and Margarita': 500,
    'The Hobbit': 280,
    'Dune': 700,
  };
  print('Pages map: $pagesByBook');

  int totalPages = 0;
  int maxPages = 0;
  String maxBookTitle = '';

  for (final String key in pagesByBook.keys) {
    final int currentBookPages = pagesByBook[key] ?? 0;
    totalPages += currentBookPages;

    if (currentBookPages > maxPages) {
      maxPages = currentBookPages;
      maxBookTitle = key;
    }
  }

  final double averagePages = totalPages / pagesByBook.length;
  print('Thickest book: $maxBookTitle ($maxPages pages)');
  print('Total pages: $totalPages');
  print('Average pages: ${averagePages.toStringAsFixed(1)}');
  print('');

  const bool addBonus = true;
  final List<String> extraBooks = ['Fahrenheit 451', 'Brave New World'];

  final List<String> all = [
    ' START ',
    ...shelf,
    if (addBonus) 'Bonus Book',
    for (final String singleBook in extraBooks) 'Extra: $singleBook',
  ];
  print('Final big list "all": $all');
  print('');
}

// 2.6. Task 5. Operators
void runTask5() {
  print('Task 5: Operators Test ');

  print('7 / 2 = ${7 / 2}');
  print('7 ~/ 2 = ${7 ~/ 2}');
  print('7 % 2 = ${7 % 2}');

  print('Short-circuit evaluation (&& and ||):');

  bool getTrue() => true;
  bool getFalse() => false;
  bool crash() => throw UnsupportedError('Crash');

  if (getTrue() || crash()) {
    print('  || Works! (First part was true, second was ignored)');
  }

  if (getFalse() && crash()) {
    // Этот блок никогда не выполнится, но анализатор этого не знает
  } else {
    print('  && Works! (Short-circuit prevented crash)');
  }

  final String? testNull = stdin.readLineSync();
  print('Null-aware ?. length: ${testNull?.length}');
  print('Null-aware ?? default value: ${testNull ?? "Value was null"}');

  String? anotherNull = stdin.readLineSync();
  anotherNull ??= 'New Assigned Value';
  print('After ??= operator: $anotherNull');

  final List<int> fList = [];
  fList.add(5);
  print('Modified final list: $fList');

  final StringBuffer buffer = StringBuffer();
  buffer
    ..write('Hello ')
    ..write('from ')
    ..write('cascade!');
  print('Buffer result: $buffer');
}