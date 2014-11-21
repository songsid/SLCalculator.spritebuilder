//
//  History.h
//  SLCalculator
//
//  Created by Sid on 2014/10/31.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface History : CCNode
{
    CCLabelTTF * _one;
    CCLabelTTF * _two;
    CCLabelTTF * _three;
    CCLabelTTF * _four;
    CCLabelTTF * _five;
    CCLabelTTF * _six;
    CCLabelTTF * _seven;
    CCLabelTTF * _eight;
    CCLabelTTF * _bet;
    CCLabelTTF * _lottery;
    CCLabelTTF * _column;
    CCLabelTTF * _num;
    
    CCLabelTTF * _r1;
    CCLabelTTF * _r2;
    CCLabelTTF * _r3;
    CCLabelTTF * _r4;
    CCLabelTTF * _r5;
    CCLabelTTF * _r6;
    CCLabelTTF * _r7;
    CCLabelTTF * _r8;
}
@property (nonatomic,strong) NSDictionary * historyDictionary;
@property BOOL oneB;
@property BOOL twoB;
@property BOOL threeB;
@property BOOL fourB;
@property BOOL fiveB;
@property BOOL sixB;
@property BOOL sevenB;
@property BOOL eightB;

@property BOOL rateA;
@property BOOL rateB;
@property BOOL rateC;
@property BOOL rateD;
@property BOOL rateE;
@property BOOL rateF;
@property BOOL rateG;
@property BOOL rateH;

@property float rateFloatA;
@property float rateFloatB;
@property float rateFloatC;
@property float rateFloatD;
@property float rateFloatE;
@property float rateFloatF;
@property float rateFloatG;
@property float rateFloatH;

@property (nonatomic,strong) NSString * bets;
@property (nonatomic,strong) NSString * lotteryMoney;
@property (nonatomic,strong) NSString * number;
@property (nonatomic,strong) NSString * columnStr;

-(void) renew;
@end
