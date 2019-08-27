//
//  NameCardTitleCell.h
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameCardTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;//图标

@property (weak, nonatomic) IBOutlet UILabel *titleLable;//标题

//赋值
- (void)setCellBasicInfoWith:(NSString *)title level:(NSInteger)level children:(NSInteger )children isExpanded:(BOOL)isExpanded;

@end

NS_ASSUME_NONNULL_END
