Using this repository:

After cloning this repository, you might notice a problem with the scanner.
This is caused by the scanner plugin requiring FlutterFragmentActivity instead of FlutterActivity. for more info, read:
https://github.com/AmolGangadhare/flutter_barcode_scanner/issues/128

To fix this issue:

1. Go to C:\flutter\.pub-cache\hosted\pub.dartlang.org\flutter_barcode_scanner-1.0.1\android\src\main\java\com\amolg\flutterbarcodescanner\BarcodeCaptureActivity.java

2. In the file FlutterBarcodeScannerPlugin.java, modify all references from FlutterActivity to FlutterFragmentActivity.

