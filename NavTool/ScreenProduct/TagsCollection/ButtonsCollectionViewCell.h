//
//  ButtonsCollectionViewCell.h
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagButton.h"

@protocol ButtonsCollectionViewCellDelegate<NSObject>
- (void)delegateButtonClickWithText:(NSString *)tag;
@end

@interface ButtonsCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak) id<ButtonsCollectionViewCellDelegate> cellDeletege;

@property(nonatomic, strong) TagButton *tagsButton;

- (void)updateShowDeleteButton;

@end
