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
        }else  self.position = ccp(768/4,screenHight);
    }
    CCLOG(@"screenHight = %f",screenHight);
    _ATeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _BTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _CTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _DTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _ETeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    _FTeam.textField.keyboardType=UIKeyboardTypeDecimalPad;
    
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
    
    
    
  ///first time tutorial
    if  (![[NSUserDefaults standardUserDefaults] boolForKey:@"Tutorial"])
    {

        _ATeam.visible = YES;
        _BTeam.visible = YES;
        _CTeam.visible = YES;
        _DTeam.visible = YES;
        _ETeam.visible = YES;
        _FTeam.visible = YES;
        
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
                [self.userObject runAnimationsForSequenceNamed:@"First"];
                break;
            case 1:
                _next.visible = NO;
                tutorialInt +=1;
                [self.userObject runAnimationsForSequenceNamed:@"First1"];
                break;
            case 2:
                _next.visible = NO;
                _next.string = @"開始使用\n▶︎▶︎▶︎";
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
                _countStartButton.enabled = YES;
                _howToUseButton.enabled = YES;
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
    [self.userObject runAnimationsForSequenceNamed:@"SelectMN"];
    
    switch ([_countCount.string intValue]) {
        case 2:
            [self selectMNButton:YES :YES :NO :NO :NO :NO];
            break;
        case 3:
            [self selectMNButton:YES :YES :YES :NO :NO :NO];
            break;
        case 4:
            [self selectMNButton:YES :YES :YES :YES :NO :NO];
            break;
        case 5:
            [self selectMNButton:YES :YES :YES :YES :YES :NO];
            break;
        case 6:
            [self selectMNButton:YES :YES :YES :YES :YES :YES];
            break;
        default:
            [self selectMNButton:NO :NO :NO :NO :NO :NO];
            break;
    }
    
}


-(void) qSelectMN :(id) sender
{
    [self.userObject runAnimationsForSequenceNamed:@"QSelectMN"];
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
            
        default:
            break;
    }

}


-(void) isSelectM :(id) sender
{
    [self blockTextField:NO];
    
    _MBG.anchorPoint = ccp(0.5, 0.5);
    _MBG.position = ccp(160, 227); /// iphone4
    CCLOG(@"_MBG.position = %f,%f",_MBG.position.x,_MBG.position.y);
    _countCount.string = @"";
    _selecetNButton.title = _countCount.string;

    
}
-(void) selectMNButton :(BOOL)one :(BOOL)two :(BOOL)three : (BOOL)four :(BOOL)five :(BOOL)six
{
    CCLOG(@"selectMNButton");
    _singleButton.visible = one;
    _twoButton.visible = two;
    _threeButton.visible = three;
    _fourButton.visible = four;
    _fiveButton.visible = five;
    _sixButton.visible = six;
    
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
  }

-(void) M2 : (id) sender
{
    _countTeam.string =@"2";
    _selecetMButton.title = _countTeam.string;
    _N2.visible = YES;
    _N3.visible = NO;
    _N4.visible = NO;
    _N5.visible = NO;
    _N61.visible = NO;
    _N62.visible = NO;
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = NO;
    _DTeam.visible = NO;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    [self BGgoOut];

}
-(void) M3 : (id) sender
{
    _countTeam.string =@"3";
    _selecetMButton.title = _countTeam.string;
    _N2.visible = NO;
    _N3.visible = YES;
    _N4.visible = NO;
    _N5.visible = NO;
    _N61.visible = NO;
    _N62.visible = NO;
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = NO;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    [self BGgoOut];

}
-(void) M4 : (id) sender
{
    _countTeam.string =@"4";
    _selecetMButton.title = _countTeam.string;
    _N2.visible = NO;
    _N3.visible = NO;
    _N4.visible = YES;
    _N5.visible = NO;
    _N61.visible = NO;
    _N62.visible = NO;
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = NO;
    _FTeam.visible = NO;
    [self BGgoOut];

}
-(void) M5 : (id) sender
{
    _countTeam.string =@"5";
    _selecetMButton.title = _countTeam.string;
    _N2.visible = NO;
    _N3.visible = NO;
    _N4.visible = NO;
    _N5.visible = YES;
    _N61.visible = NO;
    _N62.visible = NO;
    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = NO;
    [self BGgoOut];

}
-(void) M6 : (id) sender
{
    _countTeam.string =@"6";
    _selecetMButton.title = _countTeam.string;
    _N2.visible = NO;
    _N3.visible = NO;
    _N4.visible = NO;
    _N5.visible = NO;
    _N61.visible = YES;
    _N62.visible = YES;
    
    
    _ATeam.visible = YES;
    _BTeam.visible = YES;
    _CTeam.visible = YES;
    _DTeam.visible = YES;
    _ETeam.visible = YES;
    _FTeam.visible = YES;
    [self BGgoOut];

}

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
    
    switch ([_countTeam.string intValue]) {
        case 2:
            [self selectMNButton:YES :YES :NO :NO :NO :NO];
            break;
        case 3:
            [self selectMNButton:YES :YES :YES :NO :NO :NO];
            break;
        case 4:
            [self selectMNButton:YES :YES :YES :YES :NO :NO];
            break;
        case 5:
            [self selectMNButton:YES :YES :YES :YES :YES :NO];
            break;
        case 6:
            [self selectMNButton:YES :YES :YES :YES :YES :YES];
            break;
        default:
            [self selectMNButton:NO :NO :NO :NO :NO :NO];
            break;
    }
}







-(void) countStart: (id)sender
{
    float a = [self counting];
    _getLottery.string = [NSString stringWithFormat:@"%f",a];
    NSLog(@"%f",a);
}


-(float) counting
{

    
    
    
    
    if(_ATeam.string){
        at = [_ATeam.string floatValue];
        //[self.teamArray addObject:at];
    }
    if(_BTeam.string){
        bt = [_BTeam.string floatValue];
        //[self.teamArray addObject:bt];
    }
    if(_CTeam.string){
        ct = [_CTeam.string floatValue];
//        [self.teamArray addObject:ct];
    }
    if(_DTeam.string){
        dt = [ _DTeam.string  floatValue];
  //      [self.teamArray addObject:dt];
    }
    if(_ETeam.string){
        et = [_ETeam.string floatValue];
    //    [self.teamArray addObject:et];
    }
    if(_FTeam.string){
        ft = [_FTeam.string floatValue];
      //  [self.teamArray addObject:ft];
    }
    m = [_countTeam.string intValue];
    n = [_countCount.string intValue];
    money = [_lottery.string intValue];
    
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
            
        default:
            break;
    }
    
    
    
    return 0;
}
#pragma selectMN
-(void) singleCount
{
    if (!Bsingle) {
        _singleButton.title = @"✔︎";
        Bsingle = YES;
    }else {
        _singleButton.title = @" ";
        Bsingle = NO;
    }
}

-(void) twoCount
{
    if (!Btwo) {
        _twoButton.title = @"✔︎";
        Btwo = YES;
    }else {
        _twoButton.title = @" ";
        Btwo = NO;
    }
}
-(void) threeCount
{
    if (!Bthree) {
        _threeButton.title = @"✔︎";
        Bthree = YES;
    }else {
        _threeButton.title = @" ";
        Bthree = NO;
    }
}

-(void) fourCount
{
    if (!Bfour) {
        _fourButton.title = @"✔︎";
        Bfour = YES;
    }else {
        _fourButton.title = @" ";
        Bfour = NO;
    }

}

-(void) fiveCount
{
    if (!Bfive) {
        _fiveButton.title = @"✔︎";
        Bfive = YES;
    }else {
        _fiveButton.title = @" ";
        Bfive = NO;
    }
}

-(void) sixCount
{
    if (!Bsix) {
        _sixButton.title = @"✔︎";
        Bsix = YES;
    }else {
        _sixButton.title = @" ";
        Bsix = NO;
    }
}


#pragma countFunc

-(void) countFunction
{
    switch ([_countCount.string intValue]) {
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
            
        default:
            break;
    }
}

-(float) twoPass //單場
{
    return at * money + bt *money;
}
-(float) twoPassTwo //過兩關
{
    return  at * bt * money;
}

-(float) threePass //單場
{
    return at * money + bt * money + ct * money;
}

-(float) threePasstTwo //過兩關
{
    return at * bt * money + bt * ct * money + ct * at * money ;
   
}
-(float) threePassThree //過三關
{
    return at * bt * ct *money;
}
-(float) fourPass //單場
{
    return (at + bt + ct + dt ) * money;
}
-(float) fourPassTwo //過兩關
{
    return at * bt * money + at * ct * money + at * dt * money + bt * ct * money + bt * dt * money + ct * dt * money;

}
-(float) fourPassThree //過三關
{
    return at * bt * ct * money + at * bt * dt * money + at * ct * dt * money + bt * ct * dt * money;
}
-(float) fourPassFour //過四關
{
    return at * bt * ct * dt *money;

}
-(float) fivePass //單場
{
    return ( at + bt + ct + dt + et ) * money;

}
-(float) fivePassTwo
{
    return at * bt * money + at * ct * money + at * dt * money + at * et * money + bt * ct * money + bt * dt * money + bt * et * money + ct * dt * money + ct * et * money + dt * et * money;
}
-(float) fivePassThree
{
    return at * bt * ct * money + at * bt * dt * money + at * bt * et * money + at * ct * dt * money + at * ct * et * money + at * dt * et * money + bt * ct * dt * money + bt * ct * et * money + bt * dt * et * money + ct * dt * et * money;
}
-(float) fivePassFour
{
    return at * bt * ct * dt *money + at * bt * ct * et * money + at * bt * dt * et * money + at * ct * dt * et * money + bt * ct * dt * et * money;

}
-(float) fivePassFive
{
    return at * bt * ct * dt * et * money;

}
-(float) sixPass
{
    return ( at + bt + ct + dt + et + ft ) * money;

}
-(float) sixPassTwo
{
    return at * bt * money + at * ct * money + at * dt * money + at * et * money + at * ft * money + bt * ct * money + bt * dt * money + bt * et * money + bt * ft * money + ct * dt * money + ct * et * money + ct * ft * money + dt * et * money + dt * ft * money + et * ft * money ;

}
-(float) sixPassThree
{
    return  at * bt * ct * money + at * bt * dt * money + at * bt * et * money + at * bt * ft * money + at * ct * dt * money  + at * ct * et * money + at * ct * ft * money + at * dt * et * money + at * dt * ft * money + at * et * ft * money +bt * ct * dt * money + bt * ct * et * money + bt * ct * ft * money + bt * dt * et * money + bt * dt * ft * money + bt * et * ft * money + ct * dt * et * money + ct * dt * ft * money + ct * et * ft * money + dt * et * ft * money ;

}
-(float) sixPassFour
{
    return at * bt * ct * dt * money + at * bt * ct * et * money + at * bt * ct * ft * money + at * bt * dt *et * money + at * bt * dt * ft * money + at * bt * et * ft * money + at * ct * dt * et * money + at * ct * dt * ft * money + at * ct * et * ft * money + at * dt * et * ft * money + bt * ct * dt * et * money + bt * ct * dt * ft * money + bt * ct * et * ft * money + bt * dt * et * ft * money + ct * dt * et * ft * money;
}
-(float) sixPassFive
{
    return at * bt * ct * dt * et * money +  at * bt * ct * dt * ft * money + at * bt * ct * et * ft * money + at * bt * dt * et * ft * money + at * ct * dt * et * ft * money + bt * ct * dt * et * ft * money;

}
-(float) sixPassSix
{
    return at * bt * ct * dt * et * ft * money;

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
    }
}


#pragma gameNil
-(void) setTextfield :(CCTextField * )team :(float) temp :(CCNode *) blockBG
{
    if (blockBG.visible) {
        team.textField.text = [NSString stringWithFormat:@"%.2f",temp ];
        blockBG.visible = NO;
        team.enabled = YES;
        CCLOG(@"textfield unlock %f",temp);
    }else{
        temp = [team.textField.text floatValue];
        team.textField.text = @"0";
        blockBG.visible = YES;
        team.enabled = NO;
        CCLOG(@"textfield lock %f,",temp);
    }
}
-(void) gameOneNil :(id)sender
{
    if (_ATeam.visible) {
        [self setTextfield:_ATeam :oneTemp :_aBlockBG];
    }
}
-(void) gameTwoNil :(id)sender
{
    if (_BTeam.visible) {
        [self setTextfield:_BTeam :twoTemp :_bBlockBG];
    }
}
-(void) gameThreeNil :(id)sender
{
    if (_CTeam.visible) {
        [self setTextfield:_CTeam :threeTemp :_cBlockBG];
    }
}
-(void) gameFourNil :(id)sender
{
    if (_DTeam.visible) {
        [self setTextfield:_DTeam :fourTemp :_dBlockBG];
    }
}
-(void) gameFiveNil :(id)sender
{
    if (_ETeam.visible) {
        [self setTextfield:_ETeam :fiveTemp :_eBlockBG];
    }
}
-(void) gameSixNil :(id)sender
{
    if (_FTeam.visible ) {
        [self setTextfield:_FTeam :sixTemp :_fBlockBG];
    }
}




-(void) createAd
{
    AppController * appDelegate = (AppController * )[[UIApplication sharedApplication ]delegate];
    [appDelegate performSelector:@selector(createAdmobAds) withObject:nil];
}


-(void) BlockBB: (id) sender
{
    CCLOG(@"block");
    ///
}


@end