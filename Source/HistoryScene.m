//
//  HistoryScene.m
//  SLCalculator
//
//  Created by Sid on 2014/11/3.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "HistoryScene.h"


@implementation HistoryScene


-(NSMutableArray *)historyMutableArray
{
    if (!_historyMutableArray) {
        _historyMutableArray = [NSMutableArray array];
    }
    return _historyMutableArray;
}



-(NSDictionary *)historyDictionary
{
    if (!_historyDictionary) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Dictionary"]) {
            _historyDictionary = [[NSMutableDictionary alloc]init];
        }else _historyDictionary = [[NSUserDefaults standardUserDefaults ]objectForKey:@"Dictionary"];
    }
    return _historyDictionary;
}

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
    
    
    [self countDictionary];
    [self sortDict];
    

}

-(NSUInteger) countDictionary
{

    NSUInteger i =  [self.historyDictionary count];
    
    return i;
}

-(void) sortDict
{
    
    NSEnumerator * en = [self.historyDictionary keyEnumerator];
    
    NSArray * sa = [[en allObjects]sortedArrayUsingComparator:^(id str1, id str2) {
        
        if ([str1 integerValue] < [str2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([str1 integerValue] > [str2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    
        long sac = [sa count];

    
    for (NSString * sr in sa) { //put data
        NSLog(@"_bigDic[%@] = %@ ",sr,self.historyDictionary[sr][@"P1"]);
    long numberCount = sac-[sr intValue];
        NSLog(@"numcount = %ld",numberCount);
       
      
            if (numberCount+1 <12) {
                History * historyCell = (History *)[CCBReader load:@"historyCell"];
                historyCell.oneB = [self.historyDictionary[sr][@"P1"] length]-1;
                historyCell.twoB = [self.historyDictionary[sr][@"P2"] length]-1;
                historyCell.threeB = [self.historyDictionary[sr][@"P3"] length]-1;
                historyCell.fourB = [self.historyDictionary[sr][@"P4"] length]-1;
                historyCell.fiveB = [self.historyDictionary[sr][@"P5"] length]-1;
                historyCell.sixB = [self.historyDictionary[sr][@"P6"] length]-1;
                historyCell.sevenB = [self.historyDictionary[sr][@"P7"] length]-1;
                historyCell.eightB = [self.historyDictionary[sr][@"P8"] length]-1;
                historyCell.lotteryMoney = [NSString stringWithFormat:@"%@",self.historyDictionary[sr][@"Winnings"]];
                historyCell.bets = [NSString stringWithFormat:@"%@",self.historyDictionary[sr][@"bet"]];
                historyCell.columnStr = [NSString stringWithFormat:@"%@X%@",self.historyDictionary[sr][@"m"],self.historyDictionary[sr][@"n"]];
                historyCell.number = [NSString stringWithFormat:@"%ld",sac-[sr intValue]+1];
                [historyCell renew];
                
                [self addChild:historyCell];
                if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    historyCell.position = ccp(320/2,1036- 100*numberCount);
                }else{
                    historyCell.position = ccp(0,1036- 100*numberCount);}
            }
        
    }
    NSLog(@"dictionarycount %ld" ,(unsigned long)[sa count]);
}







@end
