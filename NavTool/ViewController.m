//
//  ViewController.m
//  NavTool
//
//  Created by 不明下落 on 2019/1/15.
//  Copyright © 2019 不明下落. All rights reserved.
//

#import "ViewController.h"
#import "AllProductScreenNavBar.h"
#import "ScreenNavListModel.h"
#import "Macro.h"
#import "ScreeningProductView.h"
#import "TreeTagListModel.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <YYModel.h>


typedef NS_ENUM(NSInteger,ProductSortType) {
    ProductSortTypeComprehensive = 0,     //综合
    ProductSortTypeSalesDesc = 1,        //销量降序
    ProductSortTypePriceAsc = 2,         //价格升序
    ProductSortTypePriceDesc = 3,       //价格降序
    ProductSortTypeScreening = 4        //筛选
};

@interface ViewController ()<ScreeningProductViewDelegate>
{
    BOOL _screenItemSelect;
    
    NSString *_tagId;
    TreeTagListModel *_tagsModel;
    ScreeningListModel *_lastScreenModel;
}
@property(nonatomic, strong) ScreenNavListModel *listModel;
@property(nonatomic, strong) AllProductScreenNavBar *bar;
@property (weak, nonatomic) IBOutlet UILabel *StatusLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    self.navigationController.navigationBar.translucent = NO;
    [self createData];
    [self createNavView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark - handle data
- (void)requestData {
    //应该为从网络获取标签数据
    // ... ...
    
    //这里是模拟了一段数据
    NSError *error;
    NSString *dataStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    
    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    _tagsModel = [TreeTagListModel yy_modelWithJSON:jsonData];
    
}

- (void)createData {
    ScreenNavDataModel *model1 = [ScreenNavDataModel new];
    model1.title = @"综合";
    model1.type = ItemSelelctTypeNone;
    model1.itemCode = 10;
    ScreenNavDataModel *model2 = [ScreenNavDataModel new];
    model2.title = @"销量";
    model2.type = ItemSelelctTypeSingleType;
    model2.itemCode = 20;
    ScreenNavDataModel *model3 = [ScreenNavDataModel new];
    model3.title = @"价格";
    model3.type = ItemSelelctTypeNone;
    model3.selectSingleImage = @"price_asc";
    model3.selectDoubleImage = @"price_desc";
    model3.normalImage = @"price_n";
    model3.itemCode = 30;
    ScreenNavDataModel *model4 = [ScreenNavDataModel new];
    model4.title = @"筛选";
    model4.type = ItemSelelctTypeNone;
    model4.selectSingleImage = @"icon_screen_s";
    model4.selectDoubleImage = @"icon_screen_s";
    model4.normalImage = @"icon_screen";
    model4.itemCode = 40;
    NSMutableArray<ScreenNavDataModel *> *array = [@[model1,model2,model3,model4] mutableCopy];
    _listModel = [ScreenNavListModel new];
    _listModel.list = array;
}


- (ProductSortType)currentItemState:(NSInteger)itemCode itemCurrentType:(ItemSelelctType)type {
    if (itemCode == 10) {
        return ProductSortTypeComprehensive;
    }
    if (itemCode == 20) {
        return ProductSortTypeSalesDesc;
    }
    if (itemCode == 30) {
        if (type == ItemSelelctTypeSingleType) {
            return ProductSortTypePriceAsc;
        } else if (type == ItemSelelctTypeDoubleType) {
            return ProductSortTypePriceDesc;
        }
    }
    if (itemCode == 40) {
        return ProductSortTypeScreening;
    }
    return 0;
}

#pragma mark - create view
- (void)createNavView {
    _bar = [[AllProductScreenNavBar alloc] initWithScreenNavData:_listModel.list];
    [self eventWithSortType:ProductSortTypeSalesDesc];
    
    __weak typeof(self) weakSelf = self;
    _bar.itemSelect = ^(ScreenNavBarItem *item, NSInteger selectIndex) {
        //更改item的点击类型
        //点击行（无>单击，点击>双击，双击>单击）
        //非点击行 任意状态>无
        [weakSelf.listModel handleItemModelArrayWithItemSelect:selectIndex];
        
        //根据点击状态和code得到排序类型
        item.currentType = weakSelf.listModel.list[selectIndex].type;
        ProductSortType type = [weakSelf currentItemState:item.currentItemCode itemCurrentType:item.currentType];
        
        //处理事件
        [weakSelf eventWithSortType:type];
        [weakSelf updateData];
    };
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_bar];
    [self.view addSubview:line];
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(48);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(_bar.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - handle event

- (void)selectScreenItem {
    if (_tagsModel) {
        ScreeningProductView *alert = [[ScreeningProductView alloc] initWithListModel:_lastScreenModel tagsModel:_tagsModel];
        alert.alertDelegate = self;
        [alert show];
    } else {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"数据拉取中"];
    }
    
}

- (void)updateData {
    [_bar updateWithScreenNavData:_listModel.list];
}

- (void)eventWithSortType:(ProductSortType) type {
    switch (type) {
        case ProductSortTypeComprehensive:
            _StatusLabel.text = [NSString stringWithFormat:@"综合排序%@",[_StatusLabel.text substringFromIndex:4]];
            break;
        case ProductSortTypeSalesDesc:
            _StatusLabel.text = [NSString stringWithFormat:@"销量降序%@",[_StatusLabel.text substringFromIndex:4]];
            break;
        case ProductSortTypePriceAsc:
            _StatusLabel.text = [NSString stringWithFormat:@"价格升序%@",[_StatusLabel.text substringFromIndex:4]];
            break;
        case ProductSortTypePriceDesc:
            _StatusLabel.text = [NSString stringWithFormat:@"价格降序%@",[_StatusLabel.text substringFromIndex:4]];
            break;
        case ProductSortTypeScreening:
            [self selectScreenItem];
            break;
            
            
        default:
            break;
    }
}

#pragma mark - ScreeningProductViewDelegate
- (void)alertViewDidSelectSureButtonWithId:(NSString *)tagId {
    if (tagId.length) {
        _tagId = tagId;
        //传回来的ID
        ScreenNavDataModel *model4 = _listModel.list[3];
        if (model4.type != ItemSelelctTypeSingleType) {
            model4.type = ItemSelelctTypeSingleType;
            [self updateData];
        }
        _StatusLabel.text = [NSString stringWithFormat:@"%@+tagId=%@",[_StatusLabel.text substringToIndex:4],_tagId];
    }
    
}

- (void)alertViewDidSelectResetButtonClick {
    _tagId = @"";
    _lastScreenModel = nil;
    ScreenNavDataModel *model4 = _listModel.list[3];
    if (model4.type != ItemSelelctTypeNone) {
        model4.type = ItemSelelctTypeNone;
        _StatusLabel.text = [NSString stringWithFormat:@"%@+tagId被重置",[_StatusLabel.text substringToIndex:4]];
        [self updateData];
    }
    
}

- (void)alertViewDidSelectIndexItemWithModel:(ScreeningListModel *)model {
    _lastScreenModel = model;
}
@end
