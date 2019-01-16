//
//  ButtonsCollectionViewCell.m
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import "ButtonsCollectionViewCell.h"
#import <Masonry.h>

@interface ButtonsCollectionViewCell()
@property(nonatomic, strong) UIButton *deleteButton;
@end

@implementation ButtonsCollectionViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self tagsButton];
        [self deleteButton];
    }
    return self;
}

- (void)updateShowDeleteButton {
    self.deleteButton.hidden = NO;
    [self shakeAnimation];
}

- (void)deleteButtonClick {
    
    if (_cellDeletege && [_cellDeletege respondsToSelector:@selector(delegateButtonClickWithText:)]) {
        [_cellDeletege delegateButtonClickWithText:self.tagsButton.text];
    }
    [self resumeAnimation];
}
/** 动画 */
-(void)shakeAnimation {
    
    
}
// 复原
-(void)resumeAnimation {
    self.deleteButton.hidden = YES;
    self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.hidden = YES;
        [_deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
    }
    return _deleteButton;
}


- (TagButton *)tagsButton {
    if (!_tagsButton) {
        _tagsButton = [[TagButton alloc] init];
        [_tagsButton resignFirstResponder];
        [self.contentView addSubview:_tagsButton];
        [_tagsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tagsButton;
}
@end
