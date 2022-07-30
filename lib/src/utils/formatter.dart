import 'package:intl/intl.dart';

String numformater(dynamic numf) => NumberFormat('###,000').format(numf);

String dateFormat(DateTime? date) => DateFormat().add_MMMMd().format(date!);
