//
//  PersonNameCell.h
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


//赋值
- (void)setCellBasicInfoWith:(NSString *)name level:(NSInteger)level children:(NSInteger )children;

@end

NS_ASSUME_NONNULL_END
