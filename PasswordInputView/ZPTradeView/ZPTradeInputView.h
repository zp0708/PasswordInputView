//
//  ZPTradeInputView.m
//  zp
//
//  Created by zp on 15/9/25.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZPTradeInputView;

@protocol ZPTradeInputViewDelegate <NSObject>

@optional
/** 确定按钮点击 */
- (void)tradeInputView:(ZPTradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn password:(NSString *)password;
/** 取消按钮点击 */
- (void)tradeInputView:(ZPTradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn numsArr:(NSMutableArray *)numsArr;

@end

@interface ZPTradeInputView : UIView
@property (nonatomic, weak) UITextField *responsder;

@property (nonatomic, weak) id<ZPTradeInputViewDelegate> delegate;
@end
