//
//  HeadCollectionReusableView.h
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadCollectionReusableViewDelegate<NSObject>
- (void)removeAllButtonClick;
@end

@interface HeadCollectionReusableView : UICollectionReusableView
@property(nonatomic, weak) id<HeadCollectionReusableViewDelegate> headDelegate;
- (void)updateWithText:(NSString *) text;

- (void)updateWithShowRightButton:(BOOL)show ;
@end
