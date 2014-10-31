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
    [self.userObject runAnimationsForSequenceNamed:@"QSelectMN"];
        [self scheduleBlock:^(CCTimer *timer) {
            [self showGameRateTextfield];
        } delay:1.0f];
    int nNumber;
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
/*
-(void) N1: (id) sender
{
    [self BGgoOut];
    _countCount.string = @"1";
    _selecetNButton.title = _countCount.string;
    
}
-(void) N3: (id) sender
{
    [self BGgoOut];
    _countCount.string = @"3";
    _selecetNButton.title = _countCount.string;
}
-(void) N4: (id) sender
{
    [self BGgoOut];
    _countCount.string = @"4";
    _selecetNButton.title = _countCount.string;
}
-(void) N5: (id) sender
{
    [self BGgoOut];
    _countCount.string = @"5";
    _selecetNButton.title = _countCount.string;
}
-(void) N6: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"6";
    _selecetNButton.title = _countCount.string;
}
-(void) N7: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"7";
    _selecetNButton.title = _countCount.string;
}
-(void) N10: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"10";
    _selecetNButton.title = _countCount.string;
}
-(void) N11: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"11";
    _selecetNButton.title = _countCount.string;
}
-(void) N15: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"15";
    _selecetNButton.title = _countCount.string;
}
-(void) N16: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"16";
    _selecetNButton.title = _countCount.string;
}
-(void) N20: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"20";
    _selecetNButton.title = _countCount.string;
}
-(void) N22: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"22";
    _selecetNButton.title = _countCount.string;
}
-(void) N26: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"26";
    _selecetNButton.title = _countCount.string;
}
-(void) N35: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"35";
    _selecetNButton.title = _countCount.string;
}
-(void) N42: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"42";
    _selecetNButton.title = _countCount.string;
}
-(void) N50: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"50";
    _selecetNButton.title = _countCount.string;
}
-(void) N57: (id) sender
{
    [self BGgoOut];
    
    _countCount.string = @"57";
    _selecetNButton.title = _countCount.string;
}
*/

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







-(void) countStart: (id)sender
{
    double a = [self counting];
    _getLottery.string = [NSString stringWithFormat:@"%.2f",a];
    NSLog(@"%f",a);
    [self sevenPassFour];
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

-(void) gameOneNil :(id)sender
{
    if (_ATeam.visible) {
        if (_aBlockBG.visible) {
            _ATeam.textField.text = [NSString stringWithFormat:@"%.2f",oneTemp];
            _aBlockBG.visible = NO;
            _ATeam.enabled = YES;
            CCLOG(@"textfield unlock %f",oneTemp);
        }else{
            oneTemp = [_ATeam.textField.text doubleValue];
            _ATeam.textField.text = @"0";
            _aBlockBG.visible = YES;
            _ATeam.enabled = NO;
            CCLOG(@"textfield lock %f,",oneTemp);
        }
    }
}
-(void) gameTwoNil :(id)sender
{
    if (_BTeam.visible) {
        if (_bBlockBG.visible) {
            _BTeam.textField.text = [NSString stringWithFormat:@"%.2f",twoTemp];
            _bBlockBG.visible = NO;
            _ATeam.enabled = YES;
            CCLOG(@"textfield unlock %f",twoTemp);
        }else{
            twoTemp = [_BTeam.textField.text doubleValue];
            _BTeam.textField.text = @"0";
            _bBlockBG.visible = YES;
            _BTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",twoTemp);
        }
    }
}
-(void) gameThreeNil :(id)sender
{
    if (_CTeam.visible) {
        if (_cBlockBG.visible) {
            _CTeam.textField.text = [NSString stringWithFormat:@"%.2f",threeTemp];
            _cBlockBG.visible = NO;
            _CTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",threeTemp);
        }else{
            threeTemp = [_CTeam.textField.text doubleValue];
            _CTeam.textField.text = @"0";
            _cBlockBG.visible = YES;
            _CTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",threeTemp);
        }    }
}
-(void) gameFourNil :(id)sender
{
    if (_DTeam.visible) {
        if (_dBlockBG.visible) {
            _DTeam.textField.text = [NSString stringWithFormat:@"%.2f",fourTemp];
            _dBlockBG.visible = NO;
            _DTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",fourTemp);
        }else{
            fourTemp = [_DTeam.textField.text doubleValue];
            _DTeam.textField.text = @"0";
            _dBlockBG.visible = YES;
            _DTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",fourTemp);
        }    }
}
-(void) gameFiveNil :(id)sender
{
    if (_ETeam.visible) {
        if (_eBlockBG.visible) {
            _ETeam.textField.text = [NSString stringWithFormat:@"%.2f",fiveTemp];
            _eBlockBG.visible = NO;
            _ETeam.enabled = YES;
            CCLOG(@"textfield unlock %f",fiveTemp);
        }else{
            fiveTemp = [_ETeam.textField.text doubleValue];
            _ETeam.textField.text = @"0";
            _eBlockBG.visible = YES;
            _ETeam.enabled = NO;
            CCLOG(@"textfield lock %f,",fiveTemp);
        }    }
}
-(void) gameSixNil :(id)sender
{
    if (_FTeam.visible ) {
        if (_fBlockBG.visible) {
            _FTeam.textField.text = [NSString stringWithFormat:@"%.2f",sixTemp];
            _fBlockBG.visible = NO;
            _FTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sixTemp);
        }else{
            sixTemp = [_FTeam.textField.text doubleValue];
            _FTeam.textField.text = @"0";
            _fBlockBG.visible = YES;
            _FTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",sixTemp);
        }    }
}
-(void) gameSevenNil :(id)sender
{
    if (_GTeam.visible ) {
        if (_gBlockBG.visible) {
            _GTeam.textField.text = [NSString stringWithFormat:@"%.2f",sevenTemp];
            _gBlockBG.visible = NO;
            _GTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",sevenTemp);
        }else{
            sevenTemp = [_GTeam.textField.text doubleValue];
            _GTeam.textField.text = @"0";
            _gBlockBG.visible = YES;
            _GTeam.enabled = NO;
            CCLOG(@"textfield lock %f,",sevenTemp);
        }    }
}
-(void) gameEightNil :(id)sender
{
    if (_HTeam.visible ) {
        if (_hBlockBG.visible) {
            _HTeam.textField.text = [NSString stringWithFormat:@"%.2f",eightTemp];
            _hBlockBG.visible = NO;
            _HTeam.enabled = YES;
            CCLOG(@"textfield unlock %f",eightTemp);
        }else{
            eightTemp = [_HTeam.textField.text doubleValue];
            _HTeam.textField.text = @"0";
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
