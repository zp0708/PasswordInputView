//
//  ZPTradeView.m
//  zp
//
//  Created by zp on 15/9/25.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPTradeKeyboard;

@protocol ZPTradeViewDelegate <NSObject>

@optional
/** 输入完成点击确定按钮 */
- (NSString *)finish:(NSString *)pwd;

@end

@interface ZPTradeView : UIView

@property (nonatomic, weak) id<ZPTradeViewDelegate> delegate;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *passWord);

/** 快速创建 */
+ (instancetype)tradeView;

/** 弹出 */
- (void)show;
- (void)showInView:(UIView *)view;

@end
