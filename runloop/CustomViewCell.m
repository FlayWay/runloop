//
//  CustomViewCell.m
//  runloop
//
//  Created by ljkj on 2018/5/24.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "CustomViewCell.h"

@interface CustomViewCell()



@end

@implementation CustomViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
     
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.text = @"Drawing index is top priority";
        label.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:label];
        
        
        UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 85, 85)];
        imageV1.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageV1];
        self.imageV1 = imageV1;
        
        
        UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 20, 85, 85)];
        
        imageV2.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageV2];
        self.imageV2 = imageV2;
        
        UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(195, 20, 85, 85)];
        imageV3.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageV3];
        self.imageV3 = imageV3;
        
        
        
    }
    return self;
}


@end
