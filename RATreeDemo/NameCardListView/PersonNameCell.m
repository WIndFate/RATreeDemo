//
//  PersonNameCell.m
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import "PersonNameCell.h"

@implementation PersonNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellBasicInfoWith:(NSString *)name level:(NSInteger)level children:(NSInteger )children{
    
    //每一层的布局
    CGFloat left = 10+level*30;
    
    //头像的位置
    CGRect  nameFrame = self.nameLabel.frame;
    
    nameFrame.origin.x = left;
    
    self.nameLabel.frame = nameFrame;
    
    self.nameLabel.text = name;
    
}

@end
