//
//  DADataManager.m
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/1/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

#import "DADataManager.h"

/** 
 *	This would be the root directory in the application's documents folder.
 *	
 *	Sub-directory structure will be like pathPrefix/data
 */
NSString *const pathPrefix = @"Data";

@interface DADataManager ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation DADataManager

- (instancetype)init {
	self = [super init];
	if (self) {
		_fileManager = [NSFileManager defaultManager];
	}
	return self;
}

#pragma mark - Paths

- (NSString *)documentsPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [NSString stringWithFormat:@"%@", [paths lastObject]];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
}

- (NSString *)dataFilesPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [NSString stringWithFormat:@"%@", [paths lastObject]];
	[self.fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/data", [paths lastObject], pathPrefix] withIntermediateDirectories:YES attributes:nil error:nil];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/data/%@", pathPrefix, fileName]];
}

- (NSString *)imagesPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [NSString stringWithFormat:@"%@", [paths lastObject]];
	[self.fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/images", [paths lastObject], pathPrefix] withIntermediateDirectories:YES attributes:nil error:nil];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/images/%@", pathPrefix, fileName]];
}

- (NSString *)videosPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [NSString stringWithFormat:@"%@", [paths lastObject]];
	[self.fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/videos", [paths lastObject], pathPrefix] withIntermediateDirectories:YES attributes:nil error:nil];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/videos/%@", pathPrefix, fileName]];
}

- (NSURL *)videosURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self videosPathForFileName:fileName]];
}

- (BOOL)deleteFileAtFilePath:(NSString *)filePath {
	return [self.fileManager removeItemAtPath:filePath error:nil];
}

- (BOOL)deleteFileAtFileURL:(NSURL *)url {
	return [self.fileManager removeItemAtURL:url error:nil];
}

#pragma mark - Data utilities

- (BOOL)saveData:(NSData *)data toFilePath:(NSString *)filePath {
	return [data writeToFile:filePath atomically:YES];
}

- (BOOL)saveData:(NSData *)data toDocumentsFile:(NSString *)fileName {
	NSString *filePath = [self dataFilesPathForFileName:fileName];
	return [data writeToFile:filePath atomically:YES];
}

- (BOOL)saveObject:(id)object toFilePath:(NSString *)filePath {
	NSError *error;
	NSData *data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
	if (error == nil)
		return [self saveData:data toDocumentsFile:filePath];
	return NO;
}

- (BOOL)saveObject:(id)object toDocumentsFile:(NSString *)fileName {
	NSString *filePath = [self dataFilesPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)fileExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self documentsPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)dataFileExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self dataFilesPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)imageExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self imagesPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)videoExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self videosPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)videoURLExistsInDocuments:(NSURL *)url {
	return [self.fileManager fileExistsAtPath:url.path];
}

- (id)fetchJSONFromDocumentsFileName:(NSString *)name {
	NSError *error;
	NSString *filePath = [self documentsPathForFileName:name];
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
	if (error == nil)
		return jsonData;
	return nil;
}

- (id)fetchJSONFromDocumentsFileName:(NSString *)name error:(NSError *__autoreleasing *)error {
	NSString *filePath = [self documentsPathForFileName:name];
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
	if (error == nil)
		return jsonData;
	return nil;
}

#pragma mark - Image utilities

- (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName {
	NSData *imageData = UIImagePNGRepresentation(image);
	return [imageData writeToFile:[self imagesPathForFileName:fileName] atomically:YES];
}

- (UIImage *)getImageWithFileName:(NSString *)fileName {
	return [UIImage imageWithContentsOfFile:[self imagesPathForFileName:fileName]];
}

#pragma mark - Shared instance

+ (DADataManager *)sharedManager {
	static DADataManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
	});
	return sharedManager;
}


@end
