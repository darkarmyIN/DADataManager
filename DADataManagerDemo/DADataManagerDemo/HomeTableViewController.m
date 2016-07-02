//
//  HomeTableViewController.m
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/1/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

@import DADataManager;
@import AFNetworking;

#import "HomeTableViewController.h"
#import "ProgressTableViewCell.h"

@interface HomeTableViewController ()

@property (weak, nonatomic) IBOutlet ProgressTableViewCell *jsonDataCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *binaryDataCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *stringCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *imageCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *audioCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *videoCell;
@property (weak, nonatomic) IBOutlet ProgressTableViewCell *libraryCell;

@property (nonatomic) NSArray<ProgressTableViewCell *> *cells;

@end

@implementation HomeTableViewController {
	DADataManager *dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Create the instance
	dataManager = [DADataManager sharedManager];
	
	// Set file paths from the instance
	self.jsonDataCell.filePath = [dataManager dataFilesPathForFileName:@"01.json"];
	self.binaryDataCell.filePath = [dataManager dataFilesPathForFileName:@"02.srt"];
	self.stringCell.filePath = [dataManager documentsPathForFileName:@"03.txt"];
	self.imageCell.filePath = [dataManager imagesPathForFileName:@"04.jpg"];
	self.audioCell.filePath = [dataManager audioPathForFileName:@"05.mp3"];
	self.videoCell.filePath = [dataManager videosPathForFileName:@"06.mp4"];
	self.libraryCell.filePath = [dataManager libraryPathForFileName:@"07.dat"];
	
	self.cells = [NSMutableArray arrayWithObjects:self.jsonDataCell, self.binaryDataCell, self.stringCell, self.imageCell, self.audioCell, self.videoCell, nil];
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 0) {
		
		ProgressTableViewCell *cell = [self.cells objectAtIndex:indexPath.row];
		
		if ([dataManager fileExistsAtPath:cell.filePath]) {
			// Do nothing if file's present
			return;
		}
		
		NSString *urlString = cell.subtitleLabel.text;
		AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
		NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
		AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
		cell.activityIndicatorView.hidden = NO;
		NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request
																 progress:^(NSProgress * _Nonnull downloadProgress) {
																	 dispatch_async(dispatch_get_main_queue(), ^{
																		 cell.progress = downloadProgress.fractionCompleted;
																	 });
																 } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
																	 return [NSURL fileURLWithPath:cell.filePath];
																 } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
																	 
																	 dispatch_async(dispatch_get_main_queue(), ^{
																		 cell.progress = 1;
																		 cell.activityIndicatorView.hidden = YES;
																		 cell.pathLabel.hidden = NO;
																	 });
																 }];
		[task resume];
		
	}

}
@end
