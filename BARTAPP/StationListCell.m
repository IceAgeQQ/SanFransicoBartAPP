//
//  StationListCell.m
//  BARTAPP
//
//  Created by Chao Xu on 14-1-5.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import "StationListCell.h"

@implementation StationListCell
@synthesize addressLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
