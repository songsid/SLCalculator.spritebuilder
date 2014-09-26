//
//  WebScene.m
//  SLCalculator
//
//  Created by Sid on 2014/9/24.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "WebScene.h"

@implementation WebScene

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    //initial setting
    float screenHight = [UIScreen mainScreen].bounds.size.height;
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.position = ccp(160,screenHight);
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //    self.scale = 1.2;
        self.anchorPoint = ccp(0.5,1);
        if (screenHight == 1024) {
            self.position = ccp(768/4,screenHight/2);
        }else  self.position = ccp(768/4,screenHight);
    }
    CCLOG(@"loadWeb");
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            webview = [[UIWebView alloc]initWithFrame:CGRectMake((screenWidth-self.contentSize.width*2)/2, screenHight*0.1,self.contentSize.width*2,screenHight*0.9)];
    }else{
        webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, screenHight*0.1,screenWidth,screenHight*0.9)];
    }
    [webview setDelegate:self];
    NSString * url = @"https://www.sportslottery.com.tw";
    NSURL * slcURL = [NSURL URLWithString:url];
    NSURLRequest * slcNSurlRequest=[NSURLRequest requestWithURL:slcURL];
    [webview loadRequest:slcNSurlRequest];
    [[[CCDirector sharedDirector]view]addSubview:webview];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = CGPointMake(160, 240);
    _spinner.tag = 12;
    [webview addSubview:_spinner];
    [_spinner startAnimating];
//    [spinner stopAnimating];
}

-(void) backToMain
{
    _backTomainButton.enabled = NO;
    CCLOG(@"backtomain");
    AppController * appDelegate = (AppController * )[[UIApplication sharedApplication ]delegate];
    [appDelegate performSelector:@selector(showBannerView) withObject:nil];
    [webview removeFromSuperview];
    [[CCDirector sharedDirector]popSceneWithTransition:[CCTransition transitionMoveInWithDirection:2 duration:0.2]];
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_spinner stopAnimating];
    [_spinner removeFromSuperview];
}
@end
