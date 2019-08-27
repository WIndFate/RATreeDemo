//
//  NameCardModel.m
//  Gaia
//
//  Created by Zeng Cheng on 2019/08/21.
//  Copyright © 2019 GE Capital Japan. All rights reserved.
//

#import "NameCardModel.h"

@implementation NameCardModel

- (id)initWithName:(NSString *)name children:(NSArray *)children
{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
    }
    return self;
}

- (void)addChild:(id)child
{
    NSMutableArray *children = [self.children mutableCopy];
//    [children insertObject:child atIndex:0];
    [children addObject:child];
    self.children = [children copy];
}

+ (id)objectWithNoChildren:(NSString *)name {
    
    return [[self alloc] initWithName:name children:@[]];
}

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children
{
    return [[self alloc] initWithName:name children:children];
}

@end
