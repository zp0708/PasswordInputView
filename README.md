# PasswordInputView
交易密码输入框


###### 导入文件
<pre><code>
#import "ZPTradeView.h"
</code></pre>

###### 使用方法

<pre><code>
    ZPTradeView *view = [[ZPTradeView alloc] initWithFrame:self.view.frame];
    view.finish = ^(NSString *password){
        NSLog(@"%@",password);
    };
    [view show];
</code></pre>

![](https://github.com/NewUnsigned/PasswordInputView/blob/master/PasswordInputView/ZPTradeView.gif)
