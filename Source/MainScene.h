//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//






#import "CCNode.h"
#import "GADBannerView.h"
#import "AppDelegate.h"
#define MY_BANNER_UNIT_ID @""


@interface MainScene : CCScene
{
    
    GADBannerView * bannerView_;
    CCTextField * _countTeam;
    CCTextField * _countCount;
    CCTextField * _lottery;
    CCTextField * _ATeam;
    CCTextField * _BTeam;
    CCTextField * _CTeam;
    CCTextField * _DTeam;
    CCTextField * _ETeam;
    CCTextField * _FTeam;
    CCTextField * _GTeam;
    CCTextField * _HTeam;
    
    CCButton * _lotteryDetailButton;
    CCButton * _howToUseButton;
    CCButton * _countStartButton;
    
    CCLabelTTF * _getLottery;
    
    CCNode * _NBG;
    CCNode * _MBG;
    CCButton * _BlockButton;

    CCLayoutBox * _N2;
    CCLayoutBox * _N3;
    CCLayoutBox * _N4;
    CCLayoutBox * _N5;
    CCLayoutBox * _N61;
    CCLayoutBox * _N62;
    
    CCNode * _aBlockBG;
    CCNode * _bBlockBG;
    CCNode * _cBlockBG;
    CCNode * _dBlockBG;
    CCNode * _eBlockBG;
    CCNode * _fBlockBG;
    CCNode * _gBlockBG;
    CCNode * _hBlockBG;
    
    
    CCButton * _selecetMButton;
    CCButton * _selecetNButton;
    int tutorialInt;
    CCLabelTTF * _next;
    
    CCNode * _buttomLine;
    CCButton * _selectMN;
    CCButton * _singleButton;
    CCButton * _twoButton;
    CCButton * _threeButton;
    CCButton * _fourButton;
    CCButton * _fiveButton;
    CCButton * _sixButton;
    CCButton * _sevenButton;
    CCButton * _eightButton;
    
    CCLabelTTF * _nLabel;

    CCButton * _gameOneNil;
    CCButton * _gameTwoNil;
    CCButton * _gameThreeNil;
    CCButton * _gameFourNil;
    CCButton * _gameFiveNil;
    CCButton * _gameSixNil;
    CCButton * _gameSevenNil;
    CCButton * _gameEightNil;
    
    BOOL Bsingle;
    BOOL Btwo;
    BOOL Bthree;
    BOOL Bfour;
    BOOL Bfive;
    BOOL Bsix;
    BOOL Bseven;
    BOOL Beight;
    
    int m,n,money; // mXn
    
    float  at;
    float  bt;
    float  ct;
    float  dt;
    float  et;
    float  ft;
    float  gt;
    float  ht;
    
    
    
    
    float oneTemp;
    float twoTemp;
    float threeTemp;
    float fourTemp;
    float fiveTemp;
    float sixTemp;
    float sevenTemp;
    float eightTemp;
    
    
    CCScrollView * _datailScrollView;
    
    CCParticleSystem * _ccp1;
    CCParticleSystem * _ccp2;
    CCParticleSystem * _ccp3;
    CCParticleSystem * _ccp4;
    CCParticleSystem * _ccp5;
    CCParticleSystem * _ccp6;
    CCParticleSystem * _ccp7;
    CCParticleSystem * _ccp8;
    
}

@property (nonatomic,strong) NSMutableArray * teamArray;

@end
