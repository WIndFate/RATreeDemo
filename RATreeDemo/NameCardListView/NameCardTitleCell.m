//
//  NameCardTitleCell.m
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import "NameCardTitleCell.h"

@implementation NameCardTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellBasicInfoWith:(NSString *)title level:(NSInteger)level children:(NSInteger )children isExpanded:(BOOL)isExpanded{
    
    //有自孩子时显示图标
    if (children==0) {
        self.iconView.hidden = YES;
        
    }
    else { //否则不显示
        self.iconView.hidden = NO;
    }
    
    self.titleLable.text = title;
    
    if (isExpanded == YES) {
        
        self.iconView.image = [UIImage imageNamed:@"open"];
    } else {
        self.iconView.image = [UIImage imageNamed:@"close"];
    }
    
    //每一层的布局
    CGFloat left = 10+level*30;
    
    //头像的位置
    CGRect  iconViewFrame = self.iconView.frame;
    
    iconViewFrame.origin.x = left;
    
    self.iconView.frame = iconViewFrame;
    
    //title的位置
    CGRect titleFrame = self.titleLable.frame;
    
    titleFrame.origin.x = 20+left;
    
    self.titleLable.frame = titleFrame;
    
    
    
}

@end
