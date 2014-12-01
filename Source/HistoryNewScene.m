//
//  HistoryNewScene.m
//  SLCalculator
//
//  Created by Sid on 2014/11/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "HistoryNewScene.h"

@implementation HistoryNewScene

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    
    //initial setting
    float screenHight = [UIScreen mainScreen].bounds.size.height;
    self.position = ccp(160,screenHight);
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //    self.scale = 1.2;
        self.anchorPoint = ccp(0.5,1);
        if (screenHight == 1024) {
            self.position = ccp(768/4,screenHight/2);
            CCLOG(@"is ipad");
        }else{
            self.position = ccp(768/4,screenHight);
            CCLOG(@"isn't ipad");
        }
        CCLOG(@"self.position = %f%f",self.position.x,self.position.y);
    }//else if(screenHight>480){ self.scaleY = 1.15;}
    
}


-(void) back
{
    [[CCDirector sharedDirector]popSceneWithTransition:[CCTransition transitionPushWithDirection:2 duration:0.2]];
}
@end
