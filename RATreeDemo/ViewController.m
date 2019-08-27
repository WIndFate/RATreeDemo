//
//  ViewController.m
//  RATreeDemo
//
//  Created by Zeng Cheng on 2019/08/27.
//  Copyright © 2019 WIndFate. All rights reserved.
//

#import "ViewController.h"
#import "NameCardModel.h"
#import "RATreeView.h"
#import "NameCardTitleCell.h"
#import "PersonNameCell.h"

@interface ViewController ()<RATreeViewDelegate,RATreeViewDataSource>

@property (nonatomic,strong) RATreeView *raTreeView;

@property (nonatomic,strong) NSMutableArray *nameCardsArray;

@end

@implementation ViewController

-(NSMutableArray *)nameCardsArray{
    
    if (!_nameCardsArray) {
        
        _nameCardsArray = [NSMutableArray array];
    }
    return _nameCardsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    //创建raTreeView
    self.raTreeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    
    //设置代理
    self.raTreeView.delegate = self;
    self.raTreeView.dataSource = self;
    self.raTreeView.treeFooterView = [UIView new];
    self.raTreeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.raTreeView];
    
    //注册单元格
    [self.raTreeView registerNib:[UINib nibWithNibName:@"NameCardTitleCell" bundle:nil] forCellReuseIdentifier:@"NameCardCell"];
    [self.raTreeView registerNib:[UINib nibWithNibName:@"PersonNameCell" bundle:nil] forCellReuseIdentifier:@"PersonNameCell"];
}


//循环遍历
-(void)recursiveAllChildrens:(NSArray *)array withFather:(NameCardModel *)father {
    
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        NSArray *arrList = (NSArray *) dic[@"list"];
        
        if (arrList.count > 0) {
            
            NameCardModel *nameCard = [NameCardModel objectWithNoChildren:dic[@"title"]];
            
            [father addChild:nameCard];
            [self recursiveAllChildrens:arrList withFather:nameCard];
            
        }else {
            
            NameCardModel *nameCard = [NameCardModel objectWithNoChildren:dic[@"title"]];
            [father addChild:nameCard];
            
        }
        
    }];
    
}

//加载数据
- (void)setData {
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"NameCardsTest" ofType:@"plist"];
    NSMutableArray *dataArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSLog(@"%@",dataArr);//直接打印数据
    
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dicLevel1 = (NSDictionary *)obj;
        
        NSArray *arrList = (NSArray *) dicLevel1[@"list"];
        
        if (arrList.count > 0) {
            
            NameCardModel *nameCard = [NameCardModel objectWithNoChildren:dicLevel1[@"title"]];
            
            [self recursiveAllChildrens:arrList withFather:nameCard];
            [self.nameCardsArray addObject:nameCard];
            
        }else {
            
            NameCardModel *nameCard = [NameCardModel objectWithNoChildren:dicLevel1[@"title"]];
            [self.nameCardsArray addObject:nameCard];
        }
        
    }];
    
}


#pragma mark -----------delegate

//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    
    return 44;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    
    NameCardModel *model = item;
    
    if (model.children.count > 0) {
        
        NameCardTitleCell *cell = (NameCardTitleCell *)[treeView cellForItem:item];
        cell.iconView.image = [UIImage imageNamed:@"open"];
    } else {
        
        NSLog(@"选择名片");
    }
    
    treeView.scrollView.contentSize = CGSizeMake(0, 1000);
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    
    NameCardModel *model = item;
    
    if (model.children.count > 0) {
        
        NameCardTitleCell *cell = (NameCardTitleCell *)[treeView cellForItem:item];
        cell.iconView.image = [UIImage imageNamed:@"close"];
    } else {
        
        NSLog(@"选择名片");
    }
}

//已经展开
- (void)treeView:(RATreeView *)treeView didExpandRowForItem:(id)item {
    
    
    NSLog(@"已经展开了");
}
//已经收缩
- (void)treeView:(RATreeView *)treeView didCollapseRowForItem:(id)item {
    
    NSLog(@"已经收缩了");
}

#pragma mark -----------dataSource
//返回cell
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    //当前item
    NameCardModel *model = item;
    
    //当前层级
    NSInteger level = [treeView levelForCellForItem:item];
    BOOL isExpanded = [treeView isCellForItemExpanded:item];
    
    if (model.children.count > 0) {
        
        //获取cell
        NameCardTitleCell *cell = [treeView dequeueReusableCellWithIdentifier:@"NameCardCell"];
        //赋值
        [cell setCellBasicInfoWith:model.name level:level children:model.children.count isExpanded:isExpanded];
        
        return cell;
    } else {
        
        //获取cell
        PersonNameCell *cell = [treeView dequeueReusableCellWithIdentifier:@"PersonNameCell"];
        //赋值
        [cell setCellBasicInfoWith:model.name level:level children:model.children.count];
        
        return cell;
    }
}

/**
 *  必须实现
 *
 *  @param treeView treeView
 *  @param item    节点对应的item
 *
 *  @return  每一节点对应的个数
 */
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    NameCardModel *model = item;
    
    if (item == nil) {
        
        return self.nameCardsArray.count;
    }
    
    return model.children.count;
}
/**
 *必须实现的dataSource方法
 *
 *  @param treeView treeView
 *  @param index    子节点的索引
 *  @param item     子节点索引对应的item
 *
 *  @return 返回 节点对应的item
 */
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    
    NameCardModel *model = item;
    if (item==nil) {
        
        return self.nameCardsArray[index];
    }
    
    return model.children[index];
}


//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    
    //当前点击的model
    NameCardModel *model = item;
    
    NSLog(@"点击的是第%ld层,name=%@",level,model.name);
    
}

//单元格是否可以编辑 默认是YES
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    
    return NO;
}

//编辑要实现的方法
- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item {
    
    NSLog(@"编辑了实现的方法");
    
    
}

@end
