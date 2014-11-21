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
    
    _r1.visible = _rateA;
    _r2.visible = _rateB;
    _r3.visible = _rateC;
    _r4.visible = _rateD;
    _r5.visible = _rateE;
    _r6.visible = _rateF;
    _r7.visible = _rateG;
    _r8.visible = _rateH;
    
    _r1.string =[NSString stringWithFormat:@"%.2f",_rateFloatA];
    _r2.string =[NSString stringWithFormat:@"%.2f",_rateFloatB];
    _r3.string =[NSString stringWithFormat:@"%.2f",_rateFloatC];
    _r4.string =[NSString stringWithFormat:@"%.2f",_rateFloatD];
    _r5.string =[NSString stringWithFormat:@"%.2f",_rateFloatE];
    _r6.string =[NSString stringWithFormat:@"%.2f",_rateFloatF];
    _r7.string =[NSString stringWithFormat:@"%.2f",_rateFloatG];
    _r8.string =[NSString stringWithFormat:@"%.2f",_rateFloatH];

    
    _lottery.string = [NSString stringWithFormat:@"預估總彩金：%@",_lotteryMoney];
    _bet.string  = [NSString stringWithFormat:@"下注金額：%@",_bets];
    _column.string = [NSString stringWithFormat:@"過關組合：%@",_columnStr];
    _num.string = [NSString stringWithFormat:@"%@.",_number];
    
}

@end
