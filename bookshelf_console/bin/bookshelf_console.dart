import 'dart:convert';
import 'dart:io';

// Вспомогательная функция для чтения строки в UTF-8
String? readLine() => stdin.readLineSync(encoding: utf8);

void main() {
  stdout.encoding = utf8;
  stderr.encoding = utf8;

  runTask1();
  runTask2And3();
  runTask4();
  runTask5();
}

// 2.2. Task 1. Welcome and Environment Info
void runTask1() {
  print('=== Проект: Консольное приложение BookShelf ===');
  print('Версия Dart: ${Platform.version}');
  print('Операционная система: ${Platform.operatingSystem}');
  print('');
}

// 2.3. Task 2 & 2.4. Task 3. Book Data Input & Calculations
void runTask2And3() {
  print('--- Задачи 2 и 3: Ввод информации о книге ---');

  stdout.write('Название книги: ');
  final String? titleInput = readLine();
  final String title = (titleInput == null || titleInput.trim().isEmpty)
      ? 'Без названия'
      : titleInput.trim();
  if (titleInput == null || titleInput.trim().isEmpty) {
    print('Ошибка: Название книги не может быть пустым. Программа завершена.');
    exit(1);
  }

  stdout.write('Автор книги: ');
  final String? authorInput = readLine();
  final String author = (authorInput == null || authorInput.trim().isEmpty)
      ? 'Неизвестен'
      : authorInput.trim();
  if (authorInput == null || authorInput.trim().isEmpty) {
    print('Ошибка: Автор не может быть пустым. Программа завершена.');
    exit(1);
  }

  // Проверка года (должен быть положительным числом)
  stdout.write('Год издания (только цифры): ');
  final String? yearInput = readLine();
  final int? year = int.tryParse(yearInput ?? '');
  if (year == null || year <= 0) {
    print('Ошибка: Год должен быть положительным числом. Программа завершена.');
    exit(1);
  }

  // Проверка количества страниц (должно быть положительным числом)
  stdout.write('Количество страниц (только цифры): ');
  final String? pagesInput = readLine();
  final int? pages = int.tryParse(pagesInput ?? '');
  if (pages == null || pages <= 0) {
    print('Ошибка: Страниц должно быть больше нуля. Программа завершена.');
    exit(1);
  }

  // Проверка рейтинга (должен быть от 0 до 5)
  stdout.write('Рейтинг (от 0 до 5): ');
  final String? ratingInput = readLine();
  final double? rating = double.tryParse(ratingInput ?? '');
  // Добавлена проверка isFinite, чтобы отсечь NaN и Бесконечность
  if (rating == null || !rating.isFinite || rating < 0 || rating > 5) {
    print('Ошибка: Рейтинг должен быть числом от 0 до 5. Программа завершена.');
    exit(1);
  }

  stdout.write('Книга прочитана? (да/нет): ');
  final String readAnswer = (readLine() ?? 'нет').trim().toLowerCase();

  final bool isRead =
      readAnswer == 'да' ||
      readAnswer == 'д' ||
      readAnswer == 'yes' ||
      readAnswer == 'y';

  String category;
  if (pages < 150) {
    category = 'брошюра';
  } else if (pages <= 399) {
    category = 'книга';
  } else {
    category = 'том';
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
  print('  Название: $title');
  print('  Автор: $author ($initials)');
  print('  Год: $year ($bookAge лет назад)');
  print('  Страницы: $pages ($category)');
  print('  Рейтинг: $rating / 5');
  print('  Примерное время чтения: ${timeHours.toStringAsFixed(1)} ч.');

  if (isRead) {
    print('  Статус: Прочитана');
  } else {
    print('  Статус: Не прочитана');
  }
  print('');
}

// 2.5. Task 4. Collections
void runTask4() {
  print('--- Задача 4: Коллекции ---');

  final List<String> shelf = [
    'Преступление и наказание',
    '1984',
    'Мастер и Маргарита',
    'Хоббит',
    'Дюна',
  ];
  print('Мой список книг: $shelf');
  print('Книг на полке: ${shelf.length}');
  print('Первая книга: ${shelf.first}');
  print('Последняя книга: ${shelf.last}');

  shelf.insert(0, 'Старик и море');
  shelf.add('Идиот');
  shelf.remove('1984');
  print('Обновленный список книг: $shelf');
  print('');

  stdout.write(
    'Введите жанры через запятую (например, драма,фантастика,драма): ',
  );
  final String genresLine = readLine() ?? '';
  final List<String> temporaryList = genresLine.split(',');
  final Set<String> genres = temporaryList.toSet();
  print('Уникальные жанры: $genres');
  print('');

  final Map<String, int> pagesByBook = {
    'Преступление и наказание': 600,
    '1984': 320,
    'Мастер и Маргарита': 500,
    'Хоббит': 280,
    'Дюна': 700,
  };
  print('Словарь страниц: $pagesByBook');

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
  print('Самая толстая книга: $maxBookTitle ($maxPages страниц)');
  print('Всего страниц: $totalPages');
  print('Среднее количество страниц: ${averagePages.toStringAsFixed(1)}');
  print('');

  const bool addBonus = true;
  final List<String> extraBooks = [
    '451 градус по Фаренгейту',
    'О дивный новый мир',
  ];

  final List<String> all = [
    ' НАЧАЛО ',
    ...shelf,
    if (addBonus) 'Бонусная книга',
    for (final String singleBook in extraBooks) 'Дополнительно: $singleBook',
  ];
  print('Итоговый большой список "all": $all');
  print('');
}

// 2.6. Task 5. Operators
void runTask5() {
  print('--- Задача 5: Операторы ---');

  print('7 / 2 = ${7 / 2}');
  print('7 ~/ 2 = ${7 ~/ 2}');
  print('7 % 2 = ${7 % 2}');

  print('Сокращенное вычисление (&& и ||):');

  bool getTrue() => true;
  bool getFalse() => false;
  bool crash() => throw UnsupportedError('Crash');

  if (getTrue() || crash()) {
    print('  || Работает! (Первая часть true, вторая проигнорирована)');
  }

  if (getFalse() && crash()) {
    // Этот блок никогда не выполнится, но анализатор этого не знает
  } else {
    print('  && Работает! (Сокращение предотвратило краш)');
  }

  final String? testNull = readLine();
  print('Null-aware ?. length: ${testNull?.length}');
  print(
    'Null-aware ?? значение по умолчанию: ${testNull ?? "Значение было null"}',
  );

  String? anotherNull = readLine();
  anotherNull ??= 'Новое присвоенное значение';
  print('После оператора ??=: $anotherNull');

  final List<int> fList = [];
  fList.add(5);
  print('Измененный final список: $fList');

  final StringBuffer buffer = StringBuffer();
  buffer
    ..write('Привет ')
    ..write('из ')
    ..write('каскада!');
  print('Результат буфера: $buffer');
}
