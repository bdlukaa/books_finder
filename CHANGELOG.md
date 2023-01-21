Date format: DD/MM/YYYY

## [next]

- Use `DateTime.tryParse` to parse the date ([#18](https://github.com/bdlukaa/books_finder/issues/18))

## 4.3.0 - [01/05/2022]

- **MINOR BREAKING** Renamed `BookInfo.industryIdentifier` to `BookInfo.industryIdentifiers`
- **NEW** Added the following properties to `BookInfo`:
  - `.subtitle`, `.previewLink`, `.infoLink` and `.canonicalVolumeLink`
- **NEW** Added `Book.saleInfo`
- **NEW** Implemented equality in all classes

## 4.2.0 - [13/01/2022]

- **FIX** `startIndex` is now correctly applied ([#10](https://github.com/bdlukaa/books_finder/pull/10))

## 4.1.0 - [02/03/2021]

- **NEW** `reschemeImageLinks`

## 4.0.0 - [25/03/2021]

- **NEW** `IndustryIdentifier`
- **NEW** Tests

## 3.1.0 - [21/03/2021]

- **FIX** `publisherDate` wasn't found in google books api json. (Merged [#4](https://github.com/bdlukaa/books_finder/pull/4) from [JimTim](https://github.com/JimTim))

## 3.0.0 - Null Safety - [04/03/2021]

- Null safe version

## 2.0.1 - [15/02/2021]

- Internal fixes

## 2.0.0 - [15/02/2021]

- **BREAKING**: Removed `completeInfoBook` (it was redundant)
- **NEW**: `BookInfo.toString()`
- Performance improvements
- Formatted files
- Upgraded depedencies

## 1.0.2+4 - [28/08/2020]

- Hotfix startIndex and maxResults conflict issue

## 1.0.2+3 - [28/08/2020]

- hotfix thumbnail in a map

## 1.0.2+2 - [28/08/2020]

- hotfix book not found

## 1.0.2+1 - [28/08/2020]

- Hotfix startIndex issue

## 1.0.2 - [27/08/2020]

- Export the book object

## 1.0.1 - [27/08/2020]

- First version
