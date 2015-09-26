//
//  ViewController.m
//  PasswordInputView
//
//  Created by 融通汇信 on 15/9/25.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "ViewController.h"
#import "ZPTradeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ZPTradeView *view = [[ZPTradeView alloc] initWithFrame:self.view.frame];
    view.finish = ^(NSString *password){
        NSLog(@"%@",password);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
