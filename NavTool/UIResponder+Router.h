//
//  UIResponder+ShoppingMallRouter.h
//  Star
//
//  Created by xia on 2018/6/20.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo;
@end
