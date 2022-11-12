//최지철. 구글시트 API
import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:ootd/model/model.dart';
class GoogleSheestApi{
  static const _sheetCredentials = r'''
  { 
    "type": "service_account",
  "project_id": "vaulted-algebra-366216",
  "private_key_id": "25d0d5284ffab9a17852d5220b64be1c25c78a27",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDgBoODs6uwis1x\nCsVIt2nYNC8jhGMivCvXw87nALHXzMWjN1fM6zwZD0WaualHoMSfLUov9NRhdqJ8\nGoyRbvAZp6W/vAiWDitMfRz3Fi11mhuxQoW330ae0o3Bn8PK1JMzPUQmW77iDBJD\nU0T4a966tfp3333qftMDKZp4x36v2IbkPnWoBKWRWV7fY0QlA8maWJYHLu5dtrZZ\nMOyjmpnm+iiwtrznc92aFtFXWYUfBP7f04V87juf2uKO8m3A12NnC5hRdd+7ordM\n/3YFPnMyUE+AArRLR9qa7mdJ0qrVzL+Kf5d8I38CY2PDnNeWEfeFdmUmk6X/D2Bn\nLG0RgRp/AgMBAAECggEAH5sLpuMMT+XlQhOA7ddiiWwjUmF1Ewt1LAWmBRUmAgoT\nwAkoy/JMEkUDTubuqPpXgxWCp+1koTN5jQS53DLIkPYD/l7q3zC0jx//nCR22Waa\njZGTB/PqJLIT6cM+fjkrY0k7eiXrcjy9vt3alymwzKqr4YmYXCL0ZjfSYUPT7b7c\n76Ka9VAoYvrsnMyfAw8QA1nmlMvN8mGFYXMnx8W08JfxB6AIjMBgasjhIh8y+wzQ\nnnc5fhNh2LsPHcVfx0Mtj1Z7aGVVjRXl31fnzpkIlCDL+mgjom2y1PHtyRVEkBcn\nPwsPhkwa4THSn+cLwLUD3KX2hFFRbLq32awP4LdyUQKBgQD8FAnCIoPIafsykaO9\nCpS/sJQgs4HhdN8JIYBoRraKYRkZ/u8izv7w8u926F0SbwYt8L6TO+3DpG7SBkUp\n/fcL8dRH+gGkpk8FUDgx2wCOggKU0Swjrh9I9VGo5osIWXcikWNw+o3QT/me0VYf\neFqZrs/MZ1tvRutKp4rghtO0qwKBgQDjgr+fFxwIpbKv4hB93UwfYycHOLKRQFmm\nKHJL6OTQ8MjQPjzFbsLcSPrVcyFMI64Wj4IlxbZSxExzFDWAGkmWWZUngXadB9Sj\nR1HWur9+i2K2qaEulXrSXOIqAmY2MHpmls9wnbnBKALGuduiBzZv5nAFDaK1I8ld\nOi3Tu5epfQKBgQD4CCt15wouWAHAR0eKie/FEdUevCIvGhUfYeR8NiAE1veg+ZSJ\ndo2pvhBbutVhfvbgm0KZkt0npRMZ+utxHyBHk4Lh86BMRwv32XABtlC86DXsAklh\nLkJAQopAG+BvrcAotk/XaeHCN/8RAz+vpXfYQgbbRFPWkTyRb3uZ43BKEwKBgHmS\nSGruomBMiqtJlZ5sPl0XUqedOG49gKo1Or4tePfdcrE0UKz/fsjPhpnAp65T8pbD\noLwmZkLb+i4UQnJtmZzpybYOjB9lK88EMUsZB3LLcLhC9Io7/iGi2IeyOIQEa6Oe\nOsLmxXfdtX4TmrV+PSyWao2It8UrllJm4E4gE+7RAoGAYlDZ8FJYhA5BsRUAWwiw\nbSZ88kfULi0YvaiH5x3PDfS1qiqPuL9e8jmh9c1fSny97bCyq1jj3S3NXiBVsKQB\nfrYHgj3YlIzHBVGaC5186Yx6BDNsxTtnbV5fNspd92WEKRpuKGQxU+LGPCs+CpxK\n1543SsPxDA7fMfgoGO/SK9U=\n-----END PRIVATE KEY-----\n",
  "client_email": "kakaogshets@vaulted-algebra-366216.iam.gserviceaccount.com",
  "client_id": "117416126322399329180",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/kakaogshets%40vaulted-algebra-366216.iam.gserviceaccount.com"
  
  }''';
  static final _sheetId='1-2yUmt2rGesRV_01jv_BwLkSRV7cH4ePSlBMxdc47QM';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "User");
      final firstRow= UserDB.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    }catch(e)
    {

    }

  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  }

//구글시트 json정보