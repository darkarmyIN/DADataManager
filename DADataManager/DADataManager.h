//
//  DADataManager.h
//  DADataManager
//
//  Created by Avikant Saini on 7/1/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

// Lightweight storage library for iOS.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *	This would be the root directory in the application's documents folder.
 *
 *	Sub-directory structure will be like ~/Documents/pathPrefix/data
 */
FOUNDATION_EXPORT NSString *const pathPrefix;

@interface DADataManager : NSObject

#pragma mark - Paths for file names

/**
 *	Returns the top level directory for the application's data in the containers folder.
 */
- (NSString *)getRootPath;

/**
 *	Get path by appending path components application's data in the containers folder.
 */
- (NSString *)rootPathForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the root of the application's documents directory.
 */
- (NSString *)documentsPathForFileName:(NSString *)fileName;
- (NSURL *)documentsURLForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the root of the application's library directory.
 */
- (NSString *)libraryPathForFileName:(NSString *)fileName;
- (NSURL *)libraryURLForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'data' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesURLForFileName
 */
- (NSString *)dataFilesPathForFileName:(NSString *)fileName;
- (NSURL *)dataFilesURLForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'images' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesPathForFileName, audioPathForFileName, videosPathForFileName
 */
- (NSString *)imagesPathForFileName:(NSString *)fileName;
- (NSURL *)imagesURLForFileName:(NSString *)fileName;


/**
 *	Returns path for a @em fileName present in the 'audio' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesPathForFileName, imagesPathForFileName, videosPathForFileName
 */
- (NSString *)audioPathForFileName:(NSString *)fileName;
- (NSURL *)audioURLForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'videos' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesPathForFileName, imagesPathForFileName, audioPathForFileName
 */
- (NSString *)videosPathForFileName:(NSString *)fileName;
- (NSURL *)videosURLForFileName:(NSString *)fileName;

#pragma mark - File checking

/**
 *	Checks if a @em file exists at any filepath.
 *	@see [NSFileManager fileExistsAtPath]
 */
- (BOOL)fileExistsAtPath:(NSString *)filePath;

/**
 *	Checks if a @em fileName exists in the documents folder. Passing a sub-filepath for a file in the documents folder works too.
 *	@see dataFileExistsInDocuments, imageExistsInDocuments, videoExistsInDocuments
 */
- (BOOL)fileExistsInDocuments:(NSString *)fileName;

/**
 *	Checks if a @em fileName exists in the data sub-directory in the documents folder.
 *	@see fileExistsInDocuments, imageExistsInDocuments, videoExistsInDocuments
 */
- (BOOL)dataFileExistsInDocuments:(NSString *)fileName;

/**
 *	Checks if a @em image @em file exists in the image sub-directory in the documents folder.
 *	@see fileExistsInDocuments, imageExistsInDocuments, videoExistsInDocuments
 */
- (BOOL)imageExistsInDocuments:(NSString *)fileName;

/**
 *	Checks if a @em audio @em file exists in the image sub-directory in the documents folder.
 *	@see fileExistsInDocuments, imageExistsInDocuments, videoExistsInDocuments
 */
- (BOOL)audioFileExistsInDocuments:(NSString *)fileName;

/**
 *	Checks if a @em video @em file exists in the video sub-directory in the documents folder.
 *	@see fileExistsInDocuments, dataFileExistsInDocuments, imageExistsInDocuments, videoURLExistsInDocuments
 */
- (BOOL)videoExistsInDocuments:(NSString *)fileName;

/**
 *	Checks if a @em video @em URL exists in the video sub-directory in the documents folder.
 *	@see videoExistsInDocuments
 */
- (BOOL)videoURLExistsInDocuments:(NSURL *)url;

#pragma mark - Deletion

/**
 *	Deletes a file at a @em filePath.
 *	@return BOOL value representing success or failure.
 */
- (BOOL)deleteFileAtFilePath:(NSString *)filePath;

/**
 *	Deletes a file at a @em url.
 *	@return BOOL value representing success or failure.
 */
- (BOOL)deleteFileAtFileURL:(NSURL *)url;

#pragma mark - Data utilities

/**
 *	Saves a @em NSData object to a filePath in the documents folder.
 *	@see saveData:toDocumentsFile:
 */
- (BOOL)saveData:(NSData *)data toFilePath:(NSString *)filePath;

/**
 *	Saves a @em NSData object to a filePath inside the data subdirectory in the application's documents folder.
 *	@see saveData:toFilePath:
 */
- (BOOL)saveData:(NSData *)data toDocumentsFile:(NSString *)fileName;

/**
 *	Saves a @em JSON object (Recursive Array or Dictionary of no custom objects) to a filePath in the documents folder.
 *	@line A standard json object like an NSArray of NSStrings would be saved as a serialized JSON to the file. Retrive it later with @em fetchJSON @em FromDocumentsFileName.
 *	@see saveObject:toDocumentsFile:
 *	@see fetchJSONFromDocumentsFileName
 */
- (BOOL)saveObject:(id)object toFilePath:(NSString *)filePath;

/**
 *	Saves a @em JSON object (Recursive Array or Dictionary of no custom objects) to a fileName inside the data subdirectory in the application's documents folder.
 *	@line A standard json object like an NSArray of NSStrings would be saved as a serialized JSON to the file. Retrive it later with @em fetchJSON @em FromDocumentsFileName.
 *	@see saveObject:toFilePath:
 *	@see fetchJSONFromDocumentsFileName
 */
- (BOOL)saveObject:(id)object toDocumentsFile:(NSString *)fileName;

/**
 *	Fetches a JSON object (Recursive Array or Dictionary of no custom objects) saved as a serialized file with saveObject: or saveData: from a path in the application's documents folder. (Throw an optional error object too)
 *	@see fetchJSONFromDocumentsDataFileName:
 */
- (id)fetchJSONFromDocumentsFilePath:(NSString *)filePath;
- (id)fetchJSONFromDocumentsFilepath:(NSString *)filePath error:(NSError **)error;

/**
 *	Fetches a JSON object (Recursive Array or Dictionary of no custom objects) saved as a serialized file with saveObject: or saveData: from a fileName inside the data subdirectory in the application's documents folder.
 *	@see fetchJSONFromDocumentsFilePath:
 */
- (id)fetchJSONFromDocumentsDataFileName:(NSString *)fileName;

#pragma mark - Image utilities

/**
 *	Saves a @em UIImage object to the images subdirectory in the documents folder. Can be retrived later by getImageWithFileName.
 *	@see getImageWithFileName
 */
- (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName;

/**
 *	Fetches a @em UIImage object from the images subdirectory in the documents folder, saved after serializing it.
 *	@see getImageWithFileName
 */
- (UIImage *)getImageWithFileName:(NSString *)fileName;

#pragma mark - Shared instance

/**
 *	Shared instance.
 */
+ (DADataManager *)sharedManager;

@end

@interface NSString (URLUtilities)

/// Returns the NSURL object associated with the NSString object; coresponding to NSURL's absoluteString.
- (NSURL *)URL;

/// Returns the fileURL for a filePath.
- (NSURL *)fileURL;

@end
