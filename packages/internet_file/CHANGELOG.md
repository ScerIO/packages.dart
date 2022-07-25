## 1.2.0

* Fixed download files without content length!
Now any files can be downloaded c:
* Deprecated api `process(double percentage)` at `InternetFile.get`
* Added new api `progress(int receivedLength, int contentLength)` at `InternetFile.get`
Usage example:
```diff
- process: (percentage) {
-   print('downloadPercentage: $percentage');
- },
+progress: (receivedLength, contentLength) {  
+  final percentage = receivedLength / contentLength * 100;
+  print(
+    'download progress: $receivedLength of $contentLength bytes ( $percentage% )');
+},
```

## 1.1.0

* Added strong typed helper for `InternetFileStorageIO`
```diff
InternetFile.get(
- storageAdditional: {
-   'filename': 'ui_icons.ttf',
-   'location': '',
- },
+ storageAdditional: storageIO.additional(
+   filename: 'ui_icons.ttf',
+   location: '',
+ ),
)
```
* Added `force` property for `InternetFileStorageIO.get` (ignore saved file, download)
* Added `debug` property for `InternetFileStorageIO.get` (prints percentage)
* Added `method` property for `InternetFileStorageIO.get` (http method)

## 1.0.0+2

* Update readme

## 1.0.0+1

* Added description

## 1.0.0

* Initial release.
