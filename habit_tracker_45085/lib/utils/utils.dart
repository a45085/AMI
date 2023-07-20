List<String> calendarItems = [
  'Diários',
  'Manhã',
  'Tarde',
  'Noite',
];
List<String> daysWeek = [
  'Seg',
  'Ter',
  'Qua',
  'Qui',
  'Sex',
  'Sáb',
  'Dom',
];

String getMonthName(String month) {
  switch (month) {
    case '1':
      return 'Janeiro';
    case '2':
      return 'Fevereiro';
    case '3':
      return 'Março';
    case '4':
      return 'Abril';
    case '5':
      return 'Maio';
    case '6':
      return 'Junho';
    case '7':
      return 'Julho';
    case '8':
      return 'Agosto';
    case '9':
      return 'Setembro';
    case '10':
      return 'Outubro';
    case '11':
      return 'Novembro';
    case '12':
      return 'Dezembro';
    default:
      return '';
  }
}

String currentMonthYear() {
  DateTime currentDate = DateTime.now();
  String month = currentDate.month.toString();
  String year = currentDate.year.toString();
  return '${getMonthName(month)} $year';
}

List<String> getSelectedButton() {
  int currentHour = DateTime.now().hour;
  String sel = "Diários";
  int selN = 0;

  if (currentHour >= 6 && currentHour < 12) {
    sel = "Manhã"; // Morning
    selN = 1;
  } else if (currentHour >= 12 && currentHour < 20) {
    sel = "Tarde"; // Afternoon
    selN = 2;
  } else {
    sel = "Noite"; // Night
    selN = 3;
  }

  return [sel, selN.toString()];
}
