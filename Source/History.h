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
@property (nonatomic,strong) NSString * bets;
@property (nonatomic,strong) NSString * lotteryMoney;
@property (nonatomic,strong) NSString * number;
@property (nonatomic,strong) NSString * columnStr;

-(void) renew;
@end
