//
//  DADataManager.h
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/1/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

// Lightweight storage library for iOS.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const pathPrefix;

@interface DADataManager : NSObject

#pragma mark - Paths and URLs

/**
 *	Returns path for a @em fileName present in the root of the application's documents directory.
 */
- (NSString *)documentsPathForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'data' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see imagesPathForFileName, videosPathForFileName
 */
- (NSString *)dataFilesPathForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'data' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesPathForFileName, videosPathForFileName
 */
- (NSString *)imagesPathForFileName:(NSString *)fileName;

/**
 *	Returns path for a @em fileName present in the 'video' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see dataFilesPathForFileName, videosPathForFileName
 */
- (NSString *)videosPathForFileName:(NSString *)fileName;

/**
 *	Returns URL for a @em video present in the 'video' subfolder in the @em pathPrefix subfolder in the application's documents directory.
 *	@see videosPathForFileName
 */
- (NSURL *)videosURLForFileName:(NSString *)fileName;


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

- (BOOL)saveData:(NSData *)data toFilePath:(NSString *)filePath;
- (BOOL)saveData:(NSData *)data toDocumentsFile:(NSString *)fileName;

- (BOOL)saveObject:(id)object toFilePath:(NSString *)filePath;
- (BOOL)saveObject:(id)object toDocumentsFile:(NSString *)fileName;

- (BOOL)fileExistsInDocuments:(NSString *)fileName;
- (BOOL)dataFileExistsInDocuments:(NSString *)fileName;
- (BOOL)imageExistsInDocuments:(NSString *)fileName;
- (BOOL)videoExistsInDocuments:(NSString *)fileName;
- (BOOL)videoURLExistsInDocuments:(NSURL *)url;

- (id)fetchJSONFromDocumentsFileName:(NSString *)name;
- (id)fetchJSONFromDocumentsFileName:(NSString *)name error:(NSError **)error;

#pragma mark - Image utilities

- (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName;
- (UIImage *)getImageWithFileName:(NSString *)fileName;

#pragma mark - Shared instance

/**
 *	Shared instance.
 */
+ (DADataManager *)sharedManager;

@end
