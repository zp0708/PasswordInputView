//
//  ZPTradeInputView.m
//  zp
//
//  Created by zp on 15/9/25.
//  Copyright (c) 2015年 zp. All rights reserved.
//

#import "ZPTradeInputView.h"
#import "UIView+Extension.h"
#import "FieldView.h"

static const NSInteger ZPTradeInputViewNumCount = 6;

@interface ZPTradeInputView () <UITextFieldDelegate>
/** 数字数组 */
@property (nonatomic, strong) NSMutableArray *numsArr;
/** 确定按钮 */
@property (nonatomic, weak) UIButton *okBtn;
/** 取消按钮 */
@property (nonatomic, weak) UIButton *cancleBtn;
@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) FieldView *fieldView;

@end

@implementation ZPTradeInputView

#pragma mark - LazyLoad

- (NSMutableArray *)numsArr
{
    if (!_numsArr) {
        _numsArr = [NSMutableArray array];
    }
    return _numsArr;
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubViewsWith];
        [self setupResponsder];
    }
    return self;
}

/** 添加子控件 */
- (void)setupSubViewsWith
{
    /** 确定按钮 */
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:okBtn];
    self.okBtn = okBtn;
    [self.okBtn setBackgroundImage:[UIImage imageNamed:@"password_ok_up"] forState:UIControlStateNormal];
    [self.okBtn setBackgroundImage:[UIImage imageNamed:@"password_ok_down"] forState:UIControlStateHighlighted];
    [self.okBtn addTarget:self action:@selector(ensureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 取消按钮 */
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancleBtn];
    self.cancleBtn = cancleBtn;
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"password_cancel_up"] forState:UIControlStateNormal];
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"password_cancel_down"] forState:UIControlStateHighlighted];
    [self.cancleBtn addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"请输入交易密码";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * 0.043125];
    titleLbl.textColor =  [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
    [titleLbl sizeToFit];
    self.titleLbl = titleLbl;
    [self addSubview:titleLbl];
    self.titleLbl.frame = CGRectMake(0, self.width * 0.03125, self.width, _titleLbl.height);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    line.frame = CGRectMake(15, CGRectGetMaxY(titleLbl.frame) + titleLbl.y, self.width - 30, 1);
    [self addSubview:line];
    line.alpha = 0.9;
    
    CGFloat margin = self.width * 0.05;
    /** 取消按钮 */
    self.cancleBtn.width = (self.width - 3 * margin) * 0.5;
    self.cancleBtn.height = self.width * 0.128125;
    self.cancleBtn.x = margin;
    self.cancleBtn.y = self.height - (self.width * 0.05 + self.cancleBtn.height);
    
    /** 确定按钮 */
    self.okBtn.y = self.cancleBtn.y;
    self.okBtn.width = self.cancleBtn.width;
    self.okBtn.height = self.cancleBtn.height;
    self.okBtn.x = CGRectGetMaxX(self.cancleBtn.frame) + margin;
    

    CGFloat x = self.width * 0.05;
    CGFloat y = self.width * 0.40625 * 0.5;
    CGFloat w = (self.width - 2 * self.width * 0.05);
    CGFloat h = self.width * 0.121875;
    
    FieldView *fieldView = [[FieldView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [self addSubview:fieldView];
    fieldView.alpha = 0.8;
    fieldView.layer.cornerRadius = 5;
    fieldView.layer.borderWidth = 0;
    fieldView.layer.borderColor = [[UIColor grayColor] CGColor];
    fieldView.layer.masksToBounds = YES;
    fieldView.backgroundColor = [UIColor whiteColor];
    self.fieldView = fieldView;
}

#pragma mark - Private

// 删除
- (void)delete
{
    [self.numsArr removeLastObject];
    [self drawRect:CGRectZero];
}

- (void)ensureButtonClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tradeInputView:okBtnClick:password:)]) {
        [self.delegate tradeInputView:self okBtnClick:btn password:[_numsArr componentsJoinedByString:@""]];
    }
}

- (void)cancelButtonClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tradeInputView:cancleBtnClick:numsArr:)]) {
        [self.delegate tradeInputView:self cancleBtnClick:btn numsArr:_numsArr];
    }
}

/** 响应者 */
- (void)setupResponsder
{
    UITextField *responsder = [[UITextField alloc] init];
    [self addSubview:responsder];
    responsder.delegate = self;
    responsder.keyboardType = UIKeyboardTypeNumberPad;
    self.responsder = responsder;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 此处判断点击的是否是删除按钮,当输入键盘类型为number pad(数字键盘时)准确,其他类型未可知
    if (![string isEqualToString:@""]) {
        if (_numsArr.count < ZPTradeInputViewNumCount) {
            [_numsArr addObject:string];
            [self drawRect:CGRectZero];
            return YES;
        }else{
            return NO;
        }
        
    }else{
        [self delete];
        return YES;
    }
}

- (void)drawRect:(CGRect)rect
{
    [self.fieldView drawRect:CGRectZero number:self.numsArr.count];
    // ok按钮状态
    BOOL statue = NO;
    if (self.numsArr.count == ZPTradeInputViewNumCount) {
        statue = YES;
    } else {
        statue = NO;
    }
    self.okBtn.enabled = statue;
}

@end
