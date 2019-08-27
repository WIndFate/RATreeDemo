//
//  NameCardModel.h
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameCardModel : NSObject

@property (nonatomic,copy) NSString *name;//标题

@property (nonatomic,strong) NSArray *children;//子节点数组


//初始化一个model
- (id)initWithName:(NSString *)name children:(NSArray *)array;

//遍历构造器
- (void)addChild:(id)child;

+ (id)objectWithNoChildren:(NSString *)name;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children;

@end

NS_ASSUME_NONNULL_END
