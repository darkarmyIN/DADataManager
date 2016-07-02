//
//  BrowseTableViewController.m
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/2/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

@import QuickLook;
@import DADataManager;
#import "BrowseTableViewController.h"

@interface QLPModel : NSObject <QLPreviewItem>

@property (nonatomic, strong) NSString *filePath;

- (instancetype)initWithFilePath:(NSString *)filePath;

@end

@implementation QLPModel

- (instancetype)initWithFilePath:(NSString *)filePath {
	self = [super init];
	if (self) {
		self.filePath = filePath;
	}
	return self;
}

- (NSURL *)previewItemURL {
	return self.filePath.fileURL;
}

- (NSString *)previewItemTitle {
	return self.filePath.lastPathComponent;
}

@end

@interface BrowseTableViewController () <QLPreviewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation BrowseTableViewController {
	NSFileManager *fileManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	fileManager = [NSFileManager defaultManager];
	
	self.navigationItem.title = self.rootPath.lastPathComponent;
	
	self.contents = [NSMutableArray new];
	NSArray *rootContents = [fileManager contentsOfDirectoryAtPath:self.rootPath error:nil];
	for (NSString *filePath in rootContents) {
		[self.contents addObject:[self.rootPath stringByAppendingPathComponent:filePath]];
	}
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *content = [self.contents objectAtIndex:indexPath.row];
	
	UITableViewCell *cell;
	
	BOOL directory;
	[fileManager fileExistsAtPath:content isDirectory:&directory];
	
	if (directory) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"dirCell" forIndexPath:indexPath];
		NSArray *dirContents = [fileManager contentsOfDirectoryAtPath:content error:nil];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%li item%@.", dirContents.count, (dirContents.count == 1)?@"":@"s"];
	}
	else {
		cell = [tableView dequeueReusableCellWithIdentifier:@"fileCell" forIndexPath:indexPath];
		NSDictionary *attributes = [fileManager attributesOfItemAtPath:content error:nil];
		long long fileSize = [attributes[NSFileSize] longLongValue];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld KB", fileSize/1024];
	}
	
	cell.textLabel.text = [content lastPathComponent];
	
	return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return self.rootPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *content = [self.contents objectAtIndex:indexPath.row];
	BOOL directory;
	[fileManager fileExistsAtPath:content isDirectory:&directory];
	if (directory) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		BrowseTableViewController *btvc = [self.storyboard instantiateViewControllerWithIdentifier:@"BrowseTVC"];
		btvc.rootPath = content;
		[self.navigationController pushViewController:btvc animated:YES];
	} else {
		QLPreviewController *qlpc = [[QLPreviewController alloc] init];
		qlpc.dataSource = self;
		[self.navigationController pushViewController:qlpc animated:YES];
	}
}

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
	return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	NSString *content = [self.contents objectAtIndex:indexPath.row];
	return [[QLPModel alloc] initWithFilePath:content];
}

@end

