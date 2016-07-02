//
//  ProgressTableViewCell.m
//  DADataManagerDemo
//
//  Created by Avikant Saini on 7/2/16.
//  Copyright © 2016 Dark Army. All rights reserved.
//

#import "ProgressTableViewCell.h"

@implementation ProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	UIBezierPath *beizerPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height)];
	[self.fillColor setFill];
	[beizerPath fill];
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
