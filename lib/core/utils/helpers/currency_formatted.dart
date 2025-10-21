import 'package:intl/intl.dart';

class CurrencyFormatter {

  static String format(int amount, {String symbol = '\$'}){
    final formatCurrency = NumberFormat.currency(
      symbol: '$symbol ',
      decimalDigits: 0, 
    );
    return formatCurrency.format(amount);
  }
  
}