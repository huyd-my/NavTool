//
//  HeadCollectionReusableView.m
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import "HeadCollectionReusableView.h"
//#import <RdAppSkinColor.h>
#import <Masonry.h>

@interface HeadCollectionReusableView()
@property(nonatomic, strong) UILabel *headLabel;
@property(nonatomic, strong) UIButton *deleteButton;
@end

@implementation HeadCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)updateWithText:(NSString *) text{
    _headLabel.text = text;
}

- (void)updateWithShowRightButton:(BOOL)show {
    if (show) {
        _deleteButton.hidden = NO;
    } else {
        _deleteButton.hidden = YES;
    }
}

- (void)createSubView {
    __weak typeof(self) weakSelf = self;
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-30, 16)];
    _headLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _headLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(17);
        make.left.mas_offset(15);
        make.right.mas_offset(15);
    }];
    _deleteButton = [[UIButton alloc] init];
    [_deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(removeAllRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headLabel);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
}

- (void)removeAllRecordBtnClick {
    if (_headDelegate && [_headDelegate respondsToSelector:@selector(removeAllButtonClick)]) {
        [_headDelegate removeAllButtonClick];
    }
}

@end
