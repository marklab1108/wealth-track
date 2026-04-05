import 'package:intl/intl.dart';

final _twdFormat = NumberFormat('#,##0', 'zh_TW');
final _twdDecimalFormat = NumberFormat('#,##0.00', 'zh_TW');
final _percentFormat = NumberFormat('+0.00%;-0.00%', 'en');

String formatTWD(double value) => 'NT\$ ${_twdFormat.format(value)}';

String formatAmount(double value) => _twdDecimalFormat.format(value);

String formatPercent(double rate) => _percentFormat.format(rate);
