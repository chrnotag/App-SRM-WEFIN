import 'package:intl/intl.dart';

extension Iso8601Date on DateTime{
   get formatarIso8601 => DateFormat('yyyy-MM-dd').format(this);
}