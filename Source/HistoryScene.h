//
//  HistoryScene.h
//  SLCalculator
//
//  Created by Sid on 2014/11/3.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import "CCScene.h"
#include "History.h"


@interface HistoryScene : CCScene
{

}
@property (nonatomic,strong) NSDictionary * historyDictionary;
@property (nonatomic,strong) NSMutableArray * historyMutableArray;
@end
