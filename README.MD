# DADataManager

### Lightweight storage library for iOS.

---------------------------------

Ever needed to save a singular URL response, for testing purposes and didn't want to use a persistancy framework like _CoreData_ or _Relam_; Or a rarely subject-to-change static response that you probably saved in NSUserDefaults; Or just wanted to save a downloaded file for later retrieval. 

_Enter **DADataManager** to the rescue._

----------------------------------

## Installation

### [CocoaPods](https://cocoapods.org/) (recommended)

- Add `pod 'DADataManager'` to your podfile.
- Add `#import <DADataManager/DADataManager.h>` in the class you want to use it.

### Manual (not recommended)

- Clone the repository somwhere.
- Drop the folder *DADataManager* into your project.
- Add `#import "DADataManager.h"` in the class you want to use it.

## Usage

Create a instance of the DADataManager class.

```objc
DADataManager *manager = [DADataManager sharedManager];
```
```swift
let manager = DADataManager.sharedManager()
```

Saving an object.

```objc
NSArray *array = @[@"One", @"Two", @"Three"];
[manager saveObject:array toFilePath:[manager documentsPathForFileName:@"array.json"]];
```

## Methods

#### Paths for file names

These methods return a file path or URL for files stored in the application's documents or library folder.

```objc
 - (NSString *)documentsPathForFileName:(NSString *)fileName;
 - (NSString *)libraryPathForFileName:(NSString *)fileName;
```
 
Get the file paths for sub directories inside the documents folder.

```objc
 - (NSString *)dataFilesPathForFileName:(NSString *)fileName;
 - (NSString *)imagesPathForFileName:(NSString *)fileName;
 - (NSString *)audioPathForFileName:(NSString *)fileName;
 - (NSString *)videosPathForFileName:(NSString *)fileName;
 - (NSURL *)videosURLForFileName:(NSString *)fileName;
```

Check if a file exists in the documents.

```objc
- (BOOL)fileExistsInDocuments:(NSString *)fileName;
- (BOOL)dataFileExistsInDocuments:(NSString *)fileName;
- (BOOL)imageExistsInDocuments:(NSString *)fileName;
- (BOOL)audioFileExistsInDocuments:(NSString *)fileName;
- (BOOL)videoExistsInDocuments:(NSString *)fileName;
- (BOOL)videoURLExistsInDocuments:(NSURL *)url;
```

Delete files at a file path or URL.

```objc
- (BOOL)deleteFileAtFilePath:(NSString *)filePath;
- (BOOL)deleteFileAtFileURL:(NSURL *)url;
```

Data utilities.

```objc
- (BOOL)saveData:(NSData *)data toFilePath:(NSString *)filePath;
- (BOOL)saveData:(NSData *)data toDocumentsFile:(NSString *)fileName;
- (BOOL)saveObject:(id)object toFilePath:(NSString *)filePath;
- (BOOL)saveObject:(id)object toDocumentsFile:(NSString *)fileName;
- (id)fetchJSONFromDocumentsFilePath:(NSString *)filePath;
- (id)fetchJSONFromDocumentsFilepath:(NSString *)filePath error:(NSError **)error;
- (id)fetchJSONFromDocumentsDataFileName:(NSString *)fileName;
```

Image utilities.

```objc
- (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName;
- (UIImage *)getImageWithFileName:(NSString *)fileName;
```

Shared instance

```objc
+ (DADataManager)sharedManager;
```