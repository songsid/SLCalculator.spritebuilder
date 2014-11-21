//
//  History.m
//  SLCalculator
//
//  Created by Sid on 2014/10/31.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "History.h"

@implementation History

-(void) didLoadFromCCB
{
}

-(void) renew
{
    _one.visible  = _oneB;
    _two.visible = _twoB;
    _three.visible = _threeB;
    _four.visible = _fourB;
    _five.visible = _fiveB;
    _six.visible = _sixB;
    _seven.visible = _sevenB;
    _eight.visible = _eightB;
    
    _lottery.string = [NSString stringWithFormat:@"預估總彩金：%@",_lotteryMoney];
    _bet.string  = [NSString stringWithFormat:@"下注金額：%@",_bets];
    _column.string = [NSString stringWithFormat:@"過關組合：%@",_columnStr];
    _num.string = [NSString stringWithFormat:@"%@.",_number];
    
}

@end
