// Automatic FlutterFlow imports
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:download/download.dart';

Future csvExport(
  String languageCode,
  List<ExportDataTypeStruct> userData,
) async {
  // These are the steps to make this custom action work:
  // 1. Build an action anywhere in your project which calls this custom action.
  // 2. When you are asked to provide the input parameters, provide the desired language code of the export file.
  //    With that you can customize the header line based on the passed language code. See line 29 in this custom code.
  // 3. The user data that you need to provide is a list of the data type "ExportDataType".
  //    This data type is configured in the project here under the menu item "Data Types". Configure the data type according
  //    to your needs and then use the field names as in lines 56+.

  // set your separator here
  String separator = ',';

  List<String> headers = [];
  String usedLocale;

  // Define the headers according to the passed language code
  if (languageCode == 'de') {
    headers.add('Benutzerkennung');
    headers.add('Benutzername');
    headers.add('Land');
    headers.add('Geburtstag');

    usedLocale = 'de_DE';
  } else {
    headers.add('User_ID');
    headers.add('Username');
    headers.add('Country');
    headers.add('Birthday');

    usedLocale = 'en_US';
  }

  // Create a string to hold the CSV data. Add the headers first.
  String csvData = headers.join(separator) + "\n";

  // Loop through the objects and add their values to the CSV string
  for (var i = 0; i < userData.length; i++) {
    List<String> values = [];

    // add the user values to the list
    // replace with your data type fields
    // use capital letters here instead of underscores
    // for example if you have user_id in your data type as field name, you have use userID here
    values.add(userData.elementAt(i).userId.toString());
    values.add(userData.elementAt(i).userName.toString());
    values.add(userData.elementAt(i).userCountry.toString());

    if (userData.elementAt(i).userBirthday != null) {
      final birthdayFormatted = DateFormat.yMd(usedLocale)
          .format(userData.elementAt(i).userBirthday!);
      values.add(birthdayFormatted);
    } else {
      values.add('');
    }

    // add user values to csv string
    csvData += values.join(separator) + "\n";
    values.clear;
  }

  csvData = csvData.replaceAll('null', '');

  // Generate a formatted timestamp for the filename
  final formattedDateTime =
      DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  // Custom filename with date & time. Change the filename according to your needs.
  final fileName = 'your_filename_$formattedDateTime.csv';

  // Convert the CSV string to a list of bytes (Uint8List)
  Uint8List csvBytes = Uint8List.fromList(csvData.codeUnits);

  // Convert the Uint8List to a Stream<int>
  Stream<int> csvStream = Stream.fromIterable(csvBytes.map((byte) => byte));

  // Download the CSV file with the custom filename
  await download(csvStream, fileName);
}
