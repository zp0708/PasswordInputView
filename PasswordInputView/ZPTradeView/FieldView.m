//
//  FieldView.m
//  PasswordInputView
//
//  Created by 融通汇信 on 15/9/25.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "FieldView.h"
#import "UIView+Extension.h"

@interface FieldView ()
@property (assign, nonatomic) NSInteger num;
@end

@implementation FieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat pointW = 1;
        CGFloat pointH = frame.size.height;
        CGFloat pointY = 0;
        CGFloat pointX;
        CGFloat margin = frame.size.width / 6;
        
        for (int i = 0; i < 5; i++) {
            pointX = i * margin + margin;
            UIView *line = [[UIView alloc]init];
            line.frame = CGRectMake(pointX, pointY, pointW, pointH);
            line.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [self addSubview:line];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImage *pointImage = [UIImage imageNamed:@"yuan"];
    CGFloat pointW = self.width * 0.067;
    CGFloat pointH = pointW;
    CGFloat pointY = self.width * 0.033;
    CGFloat pointX;
    CGFloat padding = self.width * 0.05;
    for (int i = 0; i < _num; i++) {
        pointX = padding + i * (pointW + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }
}

- (void)drawRect:(CGRect)rect number:(NSInteger)num
{
    _num = num;
    [self setNeedsDisplay];
}

@end
