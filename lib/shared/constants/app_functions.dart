import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

class AppFunctionsHelper {
  static String convertHtmlToText(String htmlContent) {
    // Parse the HTML content
    var document = html_parser.parse(htmlContent);
    // Extract the text content
    var plainText = document.body?.text ?? '';
    return plainText;
  }

  static Color getOrderStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.yellowAccent;
      case 'Canceled':
        return Colors.red;
      case 'Declined':
        return Colors.red;
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
        return Colors.blueGrey;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
