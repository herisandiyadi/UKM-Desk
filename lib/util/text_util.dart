
import 'package:intl/intl.dart';

class TextUtil{

  static String formatToRupiah(int price){
    final format = new NumberFormat.currency(locale: 'ID',symbol: 'Rp ',decimalDigits: 0);
    return format.format(price).toString();
  }

  static String changeDateFormat(String dateInString,String inputFormat,String outputFormat){
    if(dateInString == "null"){
      return "null";
    }
    final DateTime date = DateFormat(inputFormat).parse(dateInString);

    return DateFormat(outputFormat).format(date);
  }
}