## 1.1.0

* Added helper for `InternetFileStorageIO`
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
