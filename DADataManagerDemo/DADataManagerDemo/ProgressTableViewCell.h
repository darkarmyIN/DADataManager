//
//  ProgressTableViewCell.h
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/2/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressTableViewCell : UITableViewCell

@property (nonatomic) IBInspectable UIColor *fillColor;
@property (nonatomic) IBInspectable CGFloat progress; // 0.0 to 1.0

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) NSString *filePath;

@end
