//
//  ZPTradeView.m
//  zp
//
//  Created by zp on 15/9/25.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#import "ZPTradeView.h"
#import "ZPTradeInputView.h"
#import "UIView+Extension.h"

@interface ZPTradeView () <UITextFieldDelegate,ZPTradeInputViewDelegate>

/** 输入框 */
@property (nonatomic, weak) ZPTradeInputView *inputView;
/** 蒙板 */
@property (nonatomic, weak) UIButton *cover;
/** 键盘状态 */
@property (nonatomic, assign, getter=isKeyboardShow) BOOL keyboardShow;
/** 返回密码 */
@property (nonatomic, copy) NSString *passWord;
@property (assign, nonatomic) CGFloat keyboardHeight;

@end

@implementation ZPTradeView

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        /** 蒙板 */
        [self setupCover];
        [self setupInputView];
    }
    return self;
}

/** 蒙板 */
- (void)setupCover
{
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cover];
    self.cover = cover;
    [self.cover setBackgroundColor:[UIColor blackColor]];
    self.cover.alpha = 0.01;
    self.cover.frame = self.bounds;
    [self.cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
}

/** 输入框 */
- (void)setupInputView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChange:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidChange:(NSNotification *)note
{
    if ([note.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _keyboardHeight = rect.size.height;
        _keyboardShow = YES;
    }else{
        _keyboardShow = NO;
    }
}

#pragma mark - Private

- (void)coverClick
{
    if (self.isKeyboardShow) {  // 键盘是弹出状态
        
    } else {  // 键盘是隐藏状态
        
    }
}

#pragma mark - ZCTradeInputView delegate

- (void)tradeInputView:(ZPTradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn numsArr:(NSMutableArray *)numsArr
{
    [numsArr removeAllObjects];
    [self removeTradeViewFromSuperView];
}

- (void)tradeInputView:(ZPTradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn password:(NSString *)password
{
    self.passWord = password;
    
    if ([self.delegate respondsToSelector:@selector(finish:)]) {
        [self.delegate finish:_passWord];
    }
    // 回调block\传递密码
    if (self.finish) {
        self.finish(_passWord);
    }
    [self removeTradeViewFromSuperView];
}

- (void)removeTradeViewFromSuperView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputView.y += 30;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.inputView.y = -_inputView.height;
            self.cover.alpha = 0.01;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark - Public Interface

+ (instancetype)tradeView
{
    return [[self alloc] init];
}

- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    ZPTradeInputView *inputView = [[ZPTradeInputView alloc] initWithFrame:CGRectMake(self.width * 0.15, -self.width * 0.4, self.width * 0.7, self.width * 0.4)];
    [self addSubview:inputView];
    self.inputView = inputView;
    self.inputView.delegate = self;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = _inputView.bounds;
    [_inputView insertSubview:effectView atIndex:0];
    
    _inputView.layer.cornerRadius = 5;
    _inputView.layer.borderWidth = 0;
    _inputView.layer.borderColor = [[UIColor grayColor] CGColor];
    _inputView.layer.masksToBounds = YES;
    
    [self.inputView.responsder becomeFirstResponder];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputView.y = (self.height - self.inputView.height - _keyboardHeight) * 0.5 + 30;
        self.cover.alpha = 0.01;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.inputView.y -= 30;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.inputView.y += 10;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.inputView.y -= 5;
                }completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
