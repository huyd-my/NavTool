//
//  TagButton.h
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreeningListModel.h"

@protocol TagButtonDelegate<NSObject>

/**
 点击事件

 @param tagId 传递数据
 */
- (void)returnTagIdWhileSelect:(NSString *)tagId;
@end

@interface TagButton : UILabel

@property(nonatomic, strong) UIColor *selectTextColor;
@property(nonatomic, strong) UIColor *selectBGColor;
@property(nonatomic, strong) UIColor *selectBoderColor;

@property(nonatomic, strong) UIColor *normalTextColor;
@property(nonatomic, strong) UIColor *normalBGColor;
@property(nonatomic, strong) UIColor *normalBoderColor;

///**
// 是否选中
// */
//@property(nonatomic, assign) BOOL highlight;

@property(nonatomic, weak) id<TagButtonDelegate> tagDelegate;

- (void)updateWithDataModel:(ScreeningDataModel *)dataModel ;

@end
