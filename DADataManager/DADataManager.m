//
//  DADataManager.m
//  DADataManager
//
//  Created by Avikant Saini on 7/1/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

#import "DADataManager.h"

NSString *const pathPrefix = @"Data";

NSString *const kSubFolderDataFiles = @"files";
NSString *const kSubFolderImageFiles = @"images";
NSString *const kSubFolderAudioFiles = @"audio";
NSString *const kSubFolderVideoFiles = @"videos";

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

- (NSString *)getRootPath {
	return [self rootPathForFileName:@""];
}

- (NSString *)rootPathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [[NSString stringWithFormat:@"%@", [paths lastObject]] stringByDeletingLastPathComponent];
	[self.fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", documentsPath, fileName.stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
}

- (NSString *)documentsPathForFileName:(NSString *)fileName {
	return [self rootPathForFileName:[NSString stringWithFormat:@"Documents/%@", fileName]];
}

- (NSURL *)documentsURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self dataFilesPathForFileName:fileName]];
}

- (NSString *)libraryPathForFileName:(NSString *)fileName {
	return [self rootPathForFileName:[NSString stringWithFormat:@"Library/%@", fileName]];
}

- (NSURL *)libraryURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self libraryPathForFileName:fileName]];
}

- (NSString *)filePathForFileName:(NSString *)fileName subfolder:(NSString *)subfolder {
	return [self documentsPathForFileName:[NSString stringWithFormat:@"%@/%@/%@", pathPrefix, subfolder, fileName]];
}

- (NSString *)dataFilesPathForFileName:(NSString *)fileName {
	return [self filePathForFileName:fileName subfolder:kSubFolderDataFiles];
}

- (NSURL *)dataFilesURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self dataFilesPathForFileName:fileName]];
}

- (NSString *)imagesPathForFileName:(NSString *)fileName {
	return [self filePathForFileName:fileName subfolder:kSubFolderImageFiles];
}

- (NSURL *)imagesURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self imagesPathForFileName:fileName]];
}

- (NSString *)audioPathForFileName:(NSString *)fileName {
	return [self filePathForFileName:fileName subfolder:kSubFolderAudioFiles];
}

- (NSURL *)audioURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self audioPathForFileName:fileName]];
}

- (NSString *)videosPathForFileName:(NSString *)fileName {
	return [self filePathForFileName:fileName subfolder:kSubFolderVideoFiles];
}

- (NSURL *)videosURLForFileName:(NSString *)fileName {
	return [NSURL fileURLWithPath:[self videosPathForFileName:fileName]];
}

#pragma mark - File checking

- (BOOL)fileExistsAtPath:(NSString *)filePath {
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

- (BOOL)audioFileExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self audioPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)videoExistsInDocuments:(NSString *)fileName {
	NSString *filePath = [self videosPathForFileName:fileName];
	return [self.fileManager fileExistsAtPath:filePath];
}

- (BOOL)videoURLExistsInDocuments:(NSURL *)url {
	return [self.fileManager fileExistsAtPath:url.path];
}

#pragma mark - Deletion

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
	@try {
		NSData *data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
		if (error == nil)
			return [self saveData:data toFilePath:filePath];
	} @catch (NSException *exception) {
		return NO;
	}
	return NO;
}

- (BOOL)saveObject:(id)object toDocumentsFile:(NSString *)fileName {
	NSError *error;
	@try {
		NSData *data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
		if (error == nil)
			return [self saveData:data toDocumentsFile:filePath];
	} @catch (NSException *exception) {
		return NO;
	}
	return NO;
}

- (id)fetchJSONFromDocumentsFilePath:(NSString *)filePath {
	NSError *error;
	return [self fetchJSONFromDocumentsFilepath:filePath error:&error];
}

- (id)fetchJSONFromDocumentsFilepath:(NSString *)filePath error:(NSError *__autoreleasing *)error {
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	@try {
		id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
		if (error == nil)
			return jsonData;
	} @catch (NSException *exception) {
		return nil;
	}
	return nil;
}

- (id)fetchJSONFromDocumentsDataFileName:(NSString *)fileName {
	NSError *error;
	NSString *filePath = [self dataFilesPathForFileName:fileName];
	@try {
		NSData *data = [NSData dataWithContentsOfFile:filePath];
		id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
		if (error == nil)
			return jsonData;
	} @catch (NSException *exception) {
		return nil;
	}
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

@implementation NSString (URLUtilities)

- (NSURL *)URL {
	return [NSURL URLWithString:self];
}

- (NSURL *)fileURL {
	return [NSURL fileURLWithPath:self];
}

@end
