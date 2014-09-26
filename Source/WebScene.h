//
//  WebScene.h
//  SLCalculator
//
//  Created by Sid on 2014/9/24.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//



#import "CCScene.h"
#import "AppDelegate.h"

@interface WebScene : CCScene <UIWebViewDelegate>
{
    UIWebView * webview;
    UIActivityIndicatorView * _spinner;
    CCButton * _backTomainButton;
}
@end
