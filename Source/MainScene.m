//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene


-(NSMutableArray *) teamArray
{
    if (!_teamArray) {
        _teamArray = [NSMutableArray array];
    }
    return _teamArray;
}

-(NSMutableDictionary *)bigDictionary
{
    if (!_bigDictionary) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Dictionary"]) {
            _bigDictionary = [[NSMutableDictionary alloc]init];
        }else _bigDictionary = [[NSUserDefaults standardUserDefaults ]objectForKey:@"Dictionary"];
    }
    
    return _bigDictionary;
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
    CCLOG(@"screenHight = %f",screenHight);
    _ATeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _BTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _CTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _DTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _ETeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _FTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _GTeam.textField.keyboardType = UIKeyboardTypeDecimalPad;
    _HTeam.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    
    _countTeam.textField.keyboardType=UIKeyboardTypeNumberPad;
    _countCount.textField.keyboardType=UIKeyboardTypeNumberPad;
    _lottery.textField.keyboardType=UIKeyboardTypeNumberPad;
    
    _MBG.zOrder = 1 ;
    _NBG.zOrder = 1;
    _ATeam.visible = NO;
    _BTeam.visible = NO;
    _CTeam.visible = NO;
    _DTeam.visible = NO;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    
    
    
  ///first time tutorial
    if  (![[NSUserDefaults standardUserDefaults] boolForKey:@"Tutorial"])
    {

        _ATeam.visible = YES;
        _BTeam.visible = YES;
        _CTeam.visible = YES;
        _DTeam.visible = YES;
        _ETeam.visible = YES;
        _FTeam.visible = YES;
        _HTeam.visible = YES;
        _GTeam.visible = YES;
        
        
        [self blockTextField:NO];
        _howToUseButton.enabled = NO;
        _selecetMButton.enabled = NO;
        _selecetNButton.enabled = NO;
        _lottery.enabled = NO;
        _countStartButton.enabled = NO;
        tutorialInt = 0;
        [self scheduleBlock:^(CCTimer *timer) {
                [self.userObject runAnimationsForSequenceNamed:@"First0"];
        } delay:1];

    };
    

}

-(void) history
{
    //   history = (HistoryScene *)[CCBReader loadAsScene:@"HistoryScene"];
    CCScene * historys = (CCScene * )[CCBReader loadAsScene:@"HistoryNewScene"];
    [[CCDirector sharedDirector] pushScene:historys withTransition:[CCTransition transitionMoveInWithDirection:3 duration:0.3f]];
    
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"Touch begin");
    if (_next.visible) {
        switch (tutorialInt) {
            case 0:
                _next.visible = NO;
                tutorialInt +=1;
                [self.userObject runAnimationsForSequenceNamed:@"First0_1"];
                break;
            case 1:
                _next.visible = NO;
                tutorialInt +=1;
                [self.userObject runAnimationsForSequenceNamed:@"First1"];
                [self gameXinv:NO];//game xx button enable == no
                break;
            case 2:
                _next.visible = NO;
                _next.string = @"開始使用\n>>>";
                tutorialInt +=1;
                [self.userObject runAnimationsForSequenceNamed:@"First2"];
                break;
            case 3:
                [self.userObject runAnimationsForSequenceNamed:@"Default"];
                [self blockTextField:YES];
                _selecetNButton.enabled = YES;
                _selecetMButton.enabled = YES;
                _ATeam.visible = NO;
                _BTeam.visible = NO;
                _CTeam.visible = NO;
                _DTeam.visible = NO;
                _ETeam.visible = NO;
                _FTeam.visible = NO;
                _GTeam.visible = NO;
                _HTeam.visible = NO;
                _countStartButton.enabled = YES;
                _howToUseButton.enabled = YES;
                
                [self gameXinv:YES];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Tutorial"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            
            /// create Ad !!!!
                [self createAd];
            ///
                
                break;
            default:
                break;
        }
    }
}

-(void) selectMN: (id)sender
{
    if (!(_buttomLine.position.y<0.2)&& ![[self.userObject runningSequenceName]isEqualToString:@"SelectMN"]) {
        CCLOG(@"%f",_buttomLine.position.y);
        [self.userObject runAnimationsForSequenceNamed:@"SelectMN"];
        [self scheduleBlock:^(CCTimer *timer) {
            [self showGameButton];
        } delay:0.5f];

    }
}

-(void) showGameButton
{
    switch ([_countTeam.string intValue]) {
        case 0:
             [self selectMNButton:NO :NO :NO :NO :NO :NO :NO :NO];
            break;
        case 2:
            [self selectMNButton:YES :YES :NO :NO :NO :NO :NO :NO];
            break;
        case 3:
            [self selectMNButton:YES :YES :YES :NO :NO :NO :NO :NO];
            break;
        case 4:
            [self selectMNButton:YES :YES :YES :YES :NO :NO :NO :NO];
            break;
        case 5:
            [self selectMNButton:YES :YES :YES :YES :YES :NO :NO :NO];
            break;
        case 6:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :NO :NO];
            break;
        case 7:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :YES :NO];
            break;
        case 8:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :YES :YES];
            break;
        default:
           // [self selectMNButton:NO :NO :NO :NO :NO :NO :NO :NO];
            break;
    }

}
-(void) showGameRateTextfield
{
    switch ([_countTeam.string intValue]) {
        case 0:
            break;
        case 2:
            [self M2];
            break;
        case 3:
            [self M3];
            break;
        case 4:
            [self M4];
            break;
        case 5:
            [self M5];
            break;
        case 6:
            [self M6];
            break;
        case 7:
            [self M7];
            break;
        case 8:
            [self M8];
            break;
        default:
            break;
    }
}
-(void) qSelectMN :(id) sender
{
    if (!_MBG.position.x<300 ) {
        [self removeBlackBlock]; // 解除xx
    [self.userObject runAnimationsForSequenceNamed:@"QSelectMN"];
        [self scheduleBlock:^(CCTimer *timer) {
            [self showGameRateTextfield];
        } delay:1.0f];
    nNumber = 0;
    switch ([_countTeam.string intValue]) {
        case 2:
            nNumber  = 2*Bsingle + 1*Btwo;
            _selectMN.title = [NSString stringWithFormat:@"2×%d",nNumber];
            break;
        case 3:
            nNumber  = 3*Bsingle + 3*Btwo +1*Bthree;
            _selectMN.title = [NSString stringWithFormat:@"3×%d",nNumber];
            break;
        case 4:
            nNumber  = 4*Bsingle + 6*Btwo +4*Bthree + 1*Bfour;
            _selectMN.title = [NSString stringWithFormat:@"4×%d",nNumber];
            break;
        case 5:
            nNumber  = 5*Bsingle + 10*Btwo +10*Bthree + 5*Bfour +1*Bfive;
            _selectMN.title = [NSString stringWithFormat:@"5×%d",nNumber];
            break;
        case 6:
            nNumber  = 6*Bsingle +15*Btwo +20*Bthree + 15*Bfour +6*Bfive + 1 * Bsix;
            _selectMN.title = [NSString stringWithFormat:@"6×%d",nNumber];
            break;
        case 7:
            nNumber = 7*Bsingle + 21*Btwo + 35 * Bthree + 35 * Bfour + 21*Bfive+ 7 * Bsix + 1 * Bseven;
            _selectMN.title = [NSString stringWithFormat:@"7×%d",nNumber];

            break;
        case 8:
            nNumber = 8 * Bsingle + 28 * Btwo + 56 * Bthree + 70 * Bfour + 56 * Bfive + 28 * Bsix + 8 * Bseven + 1 * Beight;
            _selectMN.title = [NSString stringWithFormat:@"8×%d",nNumber];

            break;
        default:
            break;
    }
    }
}


-(void) isSelectM :(id) sender
{
    [self blockTextField:NO];
    
    _MBG.position = ccp(160, _line3.position.y*self.contentSize.height); /// iphone4
    CCLOG(@"_MBG.position = %f,%f",_MBG.position.x,_MBG.position.y);
    _countCount.string = @"";
    _selecetNButton.title = _countCount.string;

    
}
-(void) selectMNButton :(BOOL)one :(BOOL)two :(BOOL)three : (BOOL)four :(BOOL)five :(BOOL)six :(BOOL)seven : (BOOL) eight
{
    CCLOG(@"selectMNButton");
    _singleButton.visible = one;
    _twoButton.visible = two;
    _threeButton.visible = three;
    _fourButton.visible = four;
    _fiveButton.visible = five;
    _sixButton.visible = six;
    _sevenButton.visible = seven;
    _eightButton.visible = eight;
    
}
-(void) isSelectN :(id) sender
{
    int a = [_countTeam.string intValue];
    if (a==2 || a==3 || a==4 || a==5 || a==6) {
        [self blockTextField:NO];
        _NBG.anchorPoint = ccp(0.5, 0.5);
        _NBG.position = ccp(160, 227); /// iphone4
        
    }
}

-(void) blockTextField : (BOOL) block
{
    [_lottery setEnabled:block];
    [_ATeam setEnabled:block];
    [_BTeam setEnabled:block];
    [_CTeam setEnabled:block];
    [_DTeam setEnabled:block];
    [_ETeam setEnabled:block];
    [_FTeam setEnabled:block];
    [_GTeam setEnabled:block];
    [_HTeam setEnabled:block];
  }

-(void) removeBlackBlock // 換場數時textfield的x是否存在
{
    if (_aBlockBG.visible) {
        _ATeam.string = [NSString stringWithFormat:@"%.2f",oneTemp];
        _aBlockBG.visible = NO;
        _ATeam.enabled = YES;}
    
    if (_bBlockBG.visible) {
        _BTeam.string = [NSString stringWithFormat:@"%.2f",twoTemp];
        _bBlockBG.visible = NO;
        _BTeam.enabled = YES;
    }
    if (_cBlockBG.visible) {
        _CTeam.string = [NSString stringWithFormat:@"%.2f",threeTemp];
        _cBlockBG.visible = NO;
        _CTeam.enabled = YES;
        CCLOG(@"textfield unlock %f",threeTemp);
    }
    if (_dBlockBG.visible) {
        _DTeam.string = [NSString stringWithFormat:@"%.2f",fourTemp];
        _dBlockBG.visible = NO;
        _DTeam.enabled = YES;
        CCLOG(@"textfield unlock %f",fourTemp);
    }
    
        if (_eBlockBG.visible) {
            _ETeam.string = [NSString stringWithFormat:@"%.2f",fiveTemp];
            _eBlockBG.visible = NO;
            _ETeam.enabled = YES;
            CCLOG(@"textfield unlock %f",fiveTemp);
        }
    
        if (_fBlockBG.visible) {
            _FTeam.string = [NSString stringWithFormat:@"%.2f",sixTemp];
            _fBlockBG.visible = NO;
            _FTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sixTemp);
        }
        if (_gBlockBG.visible) {
            _GTeam.string = [NSString stringWithFormat:@"%.2f",sevenTemp];
            _gBlockBG.visible = NO;
            _GTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sevenTemp);
        }
        if (_hBlockBG.visible) {
            _HTeam.string = [NSString stringWithFormat:@"%.2f",eightTemp];
            _hBlockBG.visible = NO;
            _HTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",eightTemp);
        }
    CCLOG(@"removeBlock");
}


-(void) orangeButtonUp //按下選取場數時判斷過幾關是否坐下
{
    if (Bsingle) [self singleCount];
    if (Btwo) [self twoCount];
    if (Bthree) [self threeCount];
    if (Bfour) [self fourCount];
    if (Bfive) [self fiveCount];
    if (Bsix) [self sixCount];
    if (Bseven) [self sevenCount];
    if (Beight) [self eightCount];
    CCLOG(@"orange");
    
}
-(void) M2
{
    _countTeam.string =@"2";
    _selecetMButton.title = _countTeam.string;

    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = NO;
    _DTeam.visible = NO;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    [self BGgoOut];

}
-(void) M3
{
    _countTeam.string =@"3";
    _selecetMButton.title = _countTeam.string;

    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = NO;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    [self BGgoOut];

}
-(void) M4
{
    _countTeam.string =@"4";
    _selecetMButton.title = _countTeam.string;

    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    [self BGgoOut];


}
-(void) M5
{
    _countTeam.string =@"5";
    _selecetMButton.title = _countTeam.string;

    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = NO;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    [self BGgoOut];


}
-(void) M6
{
    _countTeam.string =@"6";
    _selecetMButton.title = _countTeam.string;

    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = YES;
    _GTeam.visible = NO;
    _HTeam.visible = NO;
    [self BGgoOut];

}
-(void) M7
{
    _countTeam.string =@"7";
    _selecetMButton.title = _countTeam.string;

    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = YES;
    _GTeam.visible = YES;
    _HTeam.visible = NO;
    [self BGgoOut];

}
-(void) M8
{
    _countTeam.string =@"8";
    _selecetMButton.title = _countTeam.string;

    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = YES;
    _GTeam.visible = YES;
    _HTeam.visible = YES;
    [self BGgoOut];
}


-(void) BGgoOut
{
    _NBG.position = ccp(self.contentSize.width *2, self.contentSize.height * 2);
    _MBG.position = ccp(self.contentSize.width *2, self.contentSize.height * 2);
    [_lottery setEnabled:YES];
    [_ATeam setEnabled:YES];
    [_BTeam setEnabled:YES];
    [_CTeam setEnabled:YES];
    [_DTeam setEnabled:YES];
    [_ETeam setEnabled:YES];
    [_FTeam setEnabled:YES];
    [_GTeam setEnabled:YES];
    [_HTeam setEnabled:YES];
    
    
    switch ([_countTeam.string intValue]) {
        case 2:
            [self selectMNButton:YES :YES :NO :NO :NO :NO :NO :NO];
            break;
        case 3:
            [self selectMNButton:YES :YES :YES :NO :NO :NO :NO :NO];
            break;
        case 4:
            [self selectMNButton:YES :YES :YES :YES :NO :NO :NO :NO];
            break;
        case 5:
            [self selectMNButton:YES :YES :YES :YES :YES :NO :NO :NO];
            break;
        case 6:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :NO :NO];
            break;
        case 7:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :YES :NO];
            break;
        case 8:
            [self selectMNButton:YES :YES :YES :YES :YES :YES :YES :YES];
            break;
        default:
            [self selectMNButton:NO :NO :NO :NO :NO :NO :NO :NO];
            break;
    }
}



-(void) arrayWithHistory
{
    if ([_getLottery.string floatValue]>0) {
        
    NSDictionary * dict = [[NSDictionary alloc]init];
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_getLottery.string],@"Winnings", [NSString stringWithFormat:@"%d",m],@"m", [NSString stringWithFormat:@"%d",nNumber], @"n",(Bsingle ? @"過一關" : @" "),@"P1",(Btwo ? @"過兩關" : @" "),@"P2",(Bthree ? @"過三關" : @" "),@"P3",(Bfour ? @"過四關" : @" "),@"P4",(Bfive ? @"過五關" : @" "),@"P5",(Bsix ? @"過六關" : @" "),@"P6",(Bseven ? @"過七關" : @" "),@"P7",(Beight ? @"過八關" : @" "),@"P8", [NSString stringWithFormat:@"%d",[_lottery.string intValue] * nNumber * 10],@"bet", nil];

        
    NSLog(@"%@",dict[@"Winnings"]);
    NSLog(@"%@",dict[@"m"]);
    NSLog(@"%@",dict[@"m"]);
    NSLog(@"%@",dict[@"P1"]);
    NSLog(@"%@",dict[@"P2"]);
    NSLog(@"%@",dict[@"P3"]);
    NSLog(@"%@",dict[@"P4"]);
    NSLog(@"%@",dict[@"P5"]);
    NSLog(@"%@",dict[@"P6"]);
    NSLog(@"%@",dict[@"P7"]);
    NSLog(@"%@",dict[@"P8"]);
    
        NSLog(@"1");
    NSString * number = [NSString stringWithFormat:@"%lu",[self.bigDictionary count]+1 ];
        NSLog(@"11 %@",number);
    self.bigDictionary[number] = dict;
        NSLog(@"111");
    [[NSUserDefaults standardUserDefaults] setObject:self.bigDictionary forKey:@"Dictionary"];
        NSLog(@"1111");
    [[NSUserDefaults standardUserDefaults] synchronize];

                NSLog(@"2");
    NSEnumerator * en = [_bigDictionary keyEnumerator];
    
    NSArray * sa = [[en allObjects]sortedArrayUsingComparator:^(id str1, id str2) {
        
        if ([str1 integerValue] < [str2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([str1 integerValue] > [str2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
            NSLog(@"3");
    for (NSString * sr in sa) {
            NSLog(@"4");
        NSLog(@"_bigDic[%@] = %@%@%@%@%@%@%@%@",sr,_bigDictionary[sr][@"P1"],_bigDictionary[sr][@"P2"],_bigDictionary[sr][@"P3"],_bigDictionary[sr][@"P4"],_bigDictionary[sr][@"P5"],_bigDictionary[sr][@"P6"],_bigDictionary[sr][@"P7"],_bigDictionary[sr][@"P8"]);
        NSLog(@"lottery = %@ mn = %@x%@",_bigDictionary[sr][@"Winnings"],_bigDictionary[sr][@"m"],_bigDictionary[sr][@"n"]);
            NSLog(@"5");
    }
                NSLog(@"6");
                NSLog(@"dictionarycount %ld" ,[sa count]);
    }

}



-(void) countStart: (id)sender
{
    double a = [self counting];
    _getLottery.string = [NSString stringWithFormat:@"%.2f",a];
    NSLog(@"%f",a);
    [self arrayWithHistory];
}


-(double) counting
{

    if(_ATeam.string){
        at = [_ATeam.string doubleValue];
        //[self.teamArray addObject:at];
    }
    if(_BTeam.string){
        bt = [_BTeam.string doubleValue];
        //[self.teamArray addObject:bt];
    }
    if(_CTeam.string){
        ct = [_CTeam.string doubleValue];
//        [self.teamArray addObject:ct];
    }
    if(_DTeam.string){
        dt = [ _DTeam.string  doubleValue];
  //      [self.teamArray addObject:dt];
    }
    if(_ETeam.string){
        et = [_ETeam.string doubleValue];
    //    [self.teamArray addObject:et];
    }
    if(_FTeam.string){
        ft = [_FTeam.string doubleValue];
      //  [self.teamArray addObject:ft];
    }
    if (_GTeam.string) {
        gt = [_GTeam.string doubleValue];
    }
    if (_HTeam.string) {
        ht = [_HTeam.string doubleValue];
    }
    m = [_countTeam.string intValue];
    n = [_countCount.string intValue];
    money = [_lottery.string intValue] * 10;
    
  //  int GetMoney;

    
    switch ([_countTeam.string intValue]) {
        case 2:
            return [self twoPass] * Bsingle + [self twoPassTwo] * Btwo;
            break;
        case 3:
            return [self threePass] * Bsingle + [self threePasstTwo] * Btwo + [self threePassThree] + Bthree;
            break;
        case 4:
            return [self fourPass] * Bsingle + [self fourPassTwo] * Btwo + [self fourPassThree] * Bthree + [self fourPassFour] * Bfour;
            break;
        case 5:
            return [self fivePass] * Bsingle + [self fivePassTwo]* Btwo + [self fivePassThree] * Bthree + [self fivePassFour] * Bfour + [self fivePassFive] * Bfive;
            break;
        case 6:
            return [self sixPass] * Bsingle + [self sixPassTwo]*Btwo + [self sixPassThree] * Bthree + [self sixPassFour] * Bfour + [self sixPassFive] * Bfive + [self sixPassSix] * Bsix;
            break;
        case 7:
            return [self sevenPass] * Bsingle + [self sevenPassTwo]*Btwo + [self sevenPassThree] * Bthree + [self sevenPassFour] * Bfour + [self sevenPassFive] * Bfive + [self sevenPassSix] * Bsix + [self sevenPassSeven] * Bseven ;
            break;
        case 8:
            return [self eightPass] * Bsingle + [self eightPassTwo]* Btwo + [self eightPassThree] * Bthree + [self eightPassFour] * Bfour + [self eightPassFive] * Bfive + [self eightPassSix] * Bsix + [self eightPassSeven] * Bseven + [self eightPassEight] * Beight;
            
        default:
            break;
    }
    
    
    
    return 0;
}
#pragma selectMN
-(void) singleCount
{
    if (!Bsingle) {
        _singleButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        Bsingle = YES;
        _ccp1.visible = YES;
    }else {
        _singleButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bsingle = NO;
        _ccp1.visible = NO;
        
    }
}

-(void) twoCount
{
    if (!Btwo) {
        _twoButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        Btwo = YES;
        _ccp2.visible = YES;

    }else {
        _twoButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Btwo = NO;
        _ccp2.visible = NO;

    }
}
-(void) threeCount
{
    if (!Bthree) {
        _threeButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
   _ccp3.visible = YES;
        Bthree = YES;
    }else {
        _threeButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bthree = NO;
        _ccp3.visible = NO;

    }
}

-(void) fourCount
{
    if (!Bfour) {
        _fourButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        _ccp4.visible = YES;
        Bfour = YES;
    }else {
        _fourButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bfour = NO;
        _ccp4.visible = NO;

    }

}

-(void) fiveCount
{
    if (!Bfive) {
        _fiveButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        _ccp5.visible = YES;
        Bfive = YES;
    }else {
        _fiveButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bfive = NO;
        _ccp5.visible = NO;

    }
}

-(void) sixCount
{
    if (!Bsix) {
        _sixButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        _ccp6.visible = YES;
        Bsix = YES;
    }else {
        _sixButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bsix = NO;
        _ccp6.visible = NO;

    }
}

-(void) sevenCount
{
    if (!Bseven) {
        _sevenButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        _ccp7.visible = YES;
        Bseven = YES;
    }else{
        _sevenButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Bseven = NO;
        _ccp7.visible = NO;

    }
    
}

-(void) eightCount
{

    if (!Beight) {
        _eightButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(122, 122, 122)];
        _ccp8.visible = YES;
        Beight = YES;
    }else{
        _eightButton.label.fontColor = [CCColor colorWithCcColor3b:ccc3(255, 122, 0)];
        Beight= NO;
        _ccp8.visible = NO;

    }
}


#pragma countFunc

-(double) twoPass //單場
{
    return at * money + bt *money;
}
-(double) twoPassTwo //過兩關
{
    return  at * bt * money;
}

-(double) threePass //單場
{
    return at * money + bt * money + ct * money;
}

-(double) threePasstTwo //過兩關
{
    return at * bt * money + bt * ct * money + ct * at * money ;
   
}
-(double) threePassThree //過三關
{
    return at * bt * ct *money;
}
-(double) fourPass //單場
{
    return (at + bt + ct + dt ) * money;
}
-(double) fourPassTwo //過兩關
{
    return at * bt * money + at * ct * money + at * dt * money + bt * ct * money + bt * dt * money + ct * dt * money;

}
-(double) fourPassThree //過三關
{
    return at * bt * ct * money + at * bt * dt * money + at * ct * dt * money + bt * ct * dt * money;
}
-(double) fourPassFour //過四關
{
    return at * bt * ct * dt *money;

}
-(double) fivePass //單場
{
    return ( at + bt + ct + dt + et ) * money;

}
-(double) fivePassTwo
{
    return at * bt * money + at * ct * money + at * dt * money + at * et * money + bt * ct * money + bt * dt * money + bt * et * money + ct * dt * money + ct * et * money + dt * et * money;
}
-(double) fivePassThree
{
    return at * bt * ct * money + at * bt * dt * money + at * bt * et * money + at * ct * dt * money + at * ct * et * money + at * dt * et * money + bt * ct * dt * money + bt * ct * et * money + bt * dt * et * money + ct * dt * et * money;
}
-(double) fivePassFour
{
    return at * bt * ct * dt *money + at * bt * ct * et * money + at * bt * dt * et * money + at * ct * dt * et * money + bt * ct * dt * et * money;

}
-(double) fivePassFive
{
    return at * bt * ct * dt * et * money;

}
-(double) sixPass
{
    return ( at + bt + ct + dt + et + ft ) * money;

}
-(double) sixPassTwo
{
    return at * bt * money + at * ct * money + at * dt * money + at * et * money + at * ft * money + bt * ct * money + bt * dt * money + bt * et * money + bt * ft * money + ct * dt * money + ct * et * money + ct * ft * money + dt * et * money + dt * ft * money + et * ft * money ;

}
-(double) sixPassThree
{
    return  at * bt * ct * money + at * bt * dt * money + at * bt * et * money + at * bt * ft * money + at * ct * dt * money  + at * ct * et * money + at * ct * ft * money + at * dt * et * money + at * dt * ft * money + at * et * ft * money +bt * ct * dt * money + bt * ct * et * money + bt * ct * ft * money + bt * dt * et * money + bt * dt * ft * money + bt * et * ft * money + ct * dt * et * money + ct * dt * ft * money + ct * et * ft * money + dt * et * ft * money ;

}
-(double) sixPassFour
{
    return at * bt * ct * dt * money + at * bt * ct * et * money + at * bt * ct * ft * money + at * bt * dt *et * money + at * bt * dt * ft * money + at * bt * et * ft * money + at * ct * dt * et * money + at * ct * dt * ft * money + at * ct * et * ft * money + at * dt * et * ft * money + bt * ct * dt * et * money + bt * ct * dt * ft * money + bt * ct * et * ft * money + bt * dt * et * ft * money + ct * dt * et * ft * money;
}
-(double) sixPassFive
{
    return at * bt * ct * dt * et * money +  at * bt * ct * dt * ft * money + at * bt * ct * et * ft * money + at * bt * dt * et * ft * money + at * ct * dt * et * ft * money + bt * ct * dt * et * ft * money;

}
-(double) sixPassSix
{
    return at * bt * ct * dt * et * ft * money;

}
-(double) sevenPass
{
    return (at + bt + ct + dt + et + ft + gt)*money;
}
-(double) sevenPassTwo
{
    return at * bt * money + at * ct * money + at * dt * money +at * et * money +at *ft * money + at * gt * money + bt * ct * money + bt * dt * money + bt * et * money + bt * ft * money + bt * gt * money + ct * dt * money +ct * et * money + ct * ft * money + ct * gt * money + dt * et * money + dt * ft * money +dt * gt * money + et * ft * money + et * gt * money + ft * gt * money;
}
-(double) sevenPassThree
{
    return at * bt * ct * money + at * bt * dt * money + at * bt *et * money + at * bt * ft * money + at * bt * gt * money + at * ct * dt * money + at * ct * et * money + at * ct * ft * money + at * ct * gt * money + at * dt * et * money + at * dt * ft * money + at * dt * gt * money + at * et * ft * money + at * et * gt * money + at * ft * gt * money + bt * ct * dt * money + bt * ct * et * money + bt * ct * ft * money + bt * ct * gt * money + bt * dt * et * money + bt * dt * ft * money + bt * dt * gt * money + bt * et * ft * money + bt * et * gt * money + bt * ft * gt * money + ct * dt * et * money + ct * dt * ft * money + ct * dt * gt * money + ct * et * ft * money + ct * et * gt * money + ct * ft * gt * money + dt * et * ft * money + dt * et * gt * money + dt * ft * gt * money + et * ft * gt * money;
}
-(double) sevenPassFour
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-3); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-2); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-1); k++) {
                for (NSInteger l=k+1; l<[gameRate count]; l++) {
                    countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue];
                    CCLOG(@"counttotal = %.2f",countTotal);
                }
            }
        }
    }
    
    
    return countTotal * money;
}

-(double) sevenPassFive
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-4); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-3); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-2); k++) {
                for (NSInteger l=k+1; l<([gameRate count]-1); l++) {
                    for (NSInteger r=l+1; r<[gameRate count]; r++) {
                        countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue] * [gameRate[r] doubleValue];
                    }
                }
            }
        }
    }
    
    
    return countTotal * money;
}
-(double) sevenPassSix
{
    return at * bt * ct * dt * et * ft * money + at * bt * ct * dt * et * gt * money + at * bt * ct * dt * ft * gt * money + at * bt * ct * et * ft * gt * money + at * bt * dt * et * ft * gt * money + at * ct * dt * et * ft * gt * money + bt * ct * dt * et * ft * gt * money ;
}
-(double) sevenPassSeven
{
    return at * bt * ct * dt * et * ft * gt * money;
}

-(double) eightPass
{
    return (at + bt + ct + dt + et + ft + gt + ht) * money;
}
-(double) eightPassTwo //problem
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-1); i++) {
        for (NSInteger j=i+1; j<([gameRate count]); j++) {
            countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] ;
        }
    }
    CCLOG(@"8場過兩關= %.2f",countTotal);
    
    return countTotal * money;
}
-(double) eightPassThree
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-2); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-1); j++) {
            for (NSInteger k=j+1; k<([gameRate count]); k++) {
                countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue];
            }
        }
    }
    
    CCLOG(@"8過3,%.2f",countTotal);
    return countTotal * money;
}
-(double) eightPassFour
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-3); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-2); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-1); k++) {
                for (NSInteger l=k+1; l<([gameRate count]); l++) {
                    countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue];
                    
                }
            }
        }
    }
    CCLOG(@"8過4,%lf",countTotal);

    return countTotal * money;
}
-(double) eightPassFive
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-4); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-3); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-2); k++) {
                for (NSInteger l=k+1; l<([gameRate count]-1); l++) {
                    for (NSInteger r=l+1; r<[gameRate count]; r++) {
                        countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue] * [gameRate[r] doubleValue];
                    }
                }
            }
        }
    }
    CCLOG(@"8過5,%.2f",countTotal);
    return countTotal * money;
}
-(double) eightPassSix
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-5); i++) {
        for (NSInteger j=i+1; j<([gameRate count]-4); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-3); k++) {
                for (NSInteger l=k+1; l<([gameRate count]-2); l++) {
                    for (NSInteger r=l+1; r<([gameRate count]-1); r++) {
                        for (NSInteger s=r+1; s<[gameRate count]; s++) {
                            countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue] * [gameRate[r] doubleValue] * [gameRate[s] doubleValue];
                        }
                    }
                }
            }
        }
    }
    CCLOG(@"8過6,%.2f",countTotal);
    return countTotal * money;
}
-(double) eightPassSeven
{
    NSNumber * oneGame = [NSNumber numberWithDouble:at];
    NSNumber * twoGame = [NSNumber numberWithDouble:bt];
    NSNumber * threeGame = [NSNumber numberWithDouble:ct];
    NSNumber * fourGame = [NSNumber numberWithDouble:dt];
    NSNumber * fiveGame = [NSNumber numberWithDouble:et];
    NSNumber * sixGame = [NSNumber numberWithDouble:ft];
    NSNumber * sevenGame = [NSNumber numberWithDouble:gt];
    NSNumber * eightGame = [NSNumber numberWithDouble:ht];
    NSArray * gameRate = [[NSArray alloc]initWithObjects:oneGame,twoGame,threeGame,fourGame,fiveGame,sixGame,sevenGame,eightGame, nil];
    double countTotal = 0;
    
    for (NSInteger i=0; i<([gameRate count]-6);i++) {
        for (NSInteger j=i+1; j<([gameRate count]-5); j++) {
            for (NSInteger k=j+1; k<([gameRate count]-4); k++) {
                for (NSInteger l=k+1; l<([gameRate count]-3); l++) {
                    for (NSInteger r=l+1; r<([gameRate count]-2); r++) {
                        for (NSInteger s=r+1; s<([gameRate count]-1); s++) {
                            for (NSInteger t=s+1; t<[gameRate count]; t++) {
                                countTotal = countTotal + [gameRate[i] doubleValue] * [gameRate[j] doubleValue] * [gameRate[k] doubleValue] * [gameRate[l] doubleValue] * [gameRate[r] doubleValue] * [gameRate[s] doubleValue] * [gameRate[t] doubleValue];
                            }
                        }
                    }
                }
            }
        }
    }

    CCLOG(@"8過7,%.2f",countTotal);
    return countTotal * money;
}
-(double) eightPassEight
{
    return at * bt * ct * dt * et * ft * gt * ht *  money;
}
#pragma showDetail
-(void) howToUse :(id) sender
{
    CCLOG(@"htu");
    if (![[self.userObject runningSequenceName]isEqualToString:@"UP"]) {
        CCLOG(@"run up");
            [self.userObject runAnimationsForSequenceNamed:@"UP"];
    }
    
}

-(void) closeDetail :(id) sender
{
    if (![[self.userObject runningSequenceName]isEqualToString:@"Down"]) {
        CCLOG(@"run down");
    [self.userObject runAnimationsForSequenceNamed:@"Down"];
        [self scheduleBlock:^(CCTimer *timer) {
            [self showGameRateTextfield];
        } delay:2];
    }
}


#pragma gameNil

-(void) gameOneNil
{
    if (_ATeam.visible) {
        if (_aBlockBG.visible) {
            _ATeam.string = [NSString stringWithFormat:@"%.2f",oneTemp];
            _aBlockBG.visible = NO;
            _ATeam.enabled = YES;
            CCLOG(@"textfield unlock %f %@",oneTemp,_ATeam.string);
        }else{
            oneTemp = [_ATeam.string floatValue];
            _ATeam.string = @"0";
            _aBlockBG.visible = YES;
            _ATeam.enabled = NO;
            CCLOG(@"textfield lock %f,",oneTemp);
        }
    }
}
-(void) gameTwoNil
{
    if (_BTeam.visible) {
        if (_bBlockBG.visible) {
            _BTeam.string = [NSString stringWithFormat:@"%.2f",twoTemp];
            _bBlockBG.visible = NO;
            _BTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",twoTemp);
        }else{
            twoTemp = [_BTeam.string floatValue];
            _BTeam.string = @"0";
            _bBlockBG.visible = YES;
            _BTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",twoTemp);
        }
    }
}
-(void) gameThreeNil
{
    if (_CTeam.visible) {
        if (_cBlockBG.visible) {
            _CTeam.string = [NSString stringWithFormat:@"%.2f",threeTemp];
            _cBlockBG.visible = NO;
            _CTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",threeTemp);
        }else{
            threeTemp = [_CTeam.string floatValue];
            _CTeam.string = @"0";
            _cBlockBG.visible = YES;
            _CTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",threeTemp);
        }    }
}
-(void) gameFourNil
{
    if (_DTeam.visible) {
        if (_dBlockBG.visible) {
            _DTeam.string = [NSString stringWithFormat:@"%.2f",fourTemp];
            _dBlockBG.visible = NO;
            _DTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",fourTemp);
        }else{
            fourTemp = [_DTeam.string floatValue];
            _DTeam.string = @"0";
            _dBlockBG.visible = YES;
            _DTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",fourTemp);
        }    }
}
-(void) gameFiveNil
{
    if (_ETeam.visible) {
        if (_eBlockBG.visible) {
            _ETeam.string = [NSString stringWithFormat:@"%.2f",fiveTemp];
            _eBlockBG.visible = NO;
            _ETeam.enabled = YES;
            CCLOG(@"textfield unlock %f",fiveTemp);
        }else{
            fiveTemp = [_ETeam.string floatValue];
            _ETeam.string = @"0";
            _eBlockBG.visible = YES;
            _ETeam.enabled = NO;
            CCLOG(@"textfield lock %f,",fiveTemp);
        }    }
}
-(void) gameSixNil
{
    if (_FTeam.visible ) {
        if (_fBlockBG.visible) {
            _FTeam.string = [NSString stringWithFormat:@"%.2f",sixTemp];
            _fBlockBG.visible = NO;
            _FTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sixTemp);
        }else{
            sixTemp = [_FTeam.string floatValue];
            _FTeam.string = @"0";
            _fBlockBG.visible = YES;
            _FTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",sixTemp);
        }    }
}
-(void) gameSevenNil
{
    if (_GTeam.visible ) {
        if (_gBlockBG.visible) {
            _GTeam.string = [NSString stringWithFormat:@"%.2f",sevenTemp];
            _gBlockBG.visible = NO;
            _GTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sevenTemp);
        }else{
            sevenTemp = [_GTeam.string floatValue];
            _GTeam.string = @"0";
            _gBlockBG.visible = YES;
            _GTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",sevenTemp);
        }    }
}
-(void) gameEightNil
{
    if (_HTeam.visible ) {
        if (_hBlockBG.visible) {
            _HTeam.string = [NSString stringWithFormat:@"%.2f",eightTemp];
            _hBlockBG.visible = NO;
            _HTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",eightTemp);
        }else{
            eightTemp = [_HTeam.string floatValue];
            _HTeam.string = @"0";
            _hBlockBG.visible = YES;
            _HTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",eightTemp);
        }    }
}

-(void) gameXinv :(BOOL) xEnable
{
    _gameOneNil.enabled = xEnable;
    _gameTwoNil.enabled = xEnable;
    _gameThreeNil.enabled = xEnable;
    _gameFourNil.enabled = xEnable;
    _gameFiveNil.enabled = xEnable;
    _gameSixNil.enabled = xEnable;
    _gameSevenNil.enabled = xEnable;
    _gameEightNil.enabled = xEnable;
}



#pragma createWeb
-(void) isLinkToWeb
{
    [self removeAd];
    [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"WebScene"] withTransition:[CCTransition transitionCrossFadeWithDuration:0.2f]];
}

-(void) developer
{
    _datailScrollView.horizontalPage = 1;
}

-(void) useDetail
{
    _datailScrollView.horizontalPage = 2;
}



#pragma aboutADMOB
-(void) createAd
{
    AppController * appDelegate = (AppController * )[[UIApplication sharedApplication ]delegate];
    [appDelegate performSelector:@selector(createAdmobAds) withObject:nil];
}

-(void) showAd
{
    AppController * appDelegate = (AppController * )[[UIApplication sharedApplication ]delegate];
    [appDelegate performSelector:@selector(showBannerView) withObject:nil];
}


-(void) removeAd
{
    AppController * appDelegate = (AppController * )[[UIApplication sharedApplication]delegate];
    [appDelegate performSelector:@selector(hideBannerView) withObject:nil];
}
-(void) BlockBB: (id) sender
{
    CCLOG(@"block");
    ///
}


@end
