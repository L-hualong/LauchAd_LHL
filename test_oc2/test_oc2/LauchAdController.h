//
//  LauchAdController.h
//  test_oc2
//
//  Created by 刘华龙 on 2017/2/28.
//  Copyright © 2017年 刘华龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CellbackEventTpye){
    CellbackEvent_clickAd,
    CellbackEvent_clickBtn,
    CellbackEvent_AdShowFinished
};

typedef void(^SetAdImageHandle)(UIImageView* imageView);
typedef void(^EventHandle)(CellbackEventTpye eventType);
typedef void(^SetupSkipBtn)(UIButton* btn,NSInteger countDown);

@interface LauchAdController : UIViewController

@property (nonatomic,assign)NSInteger countDown;

-(instancetype)initWithSetAdImageHandkle:(SetAdImageHandle)setAdImageHandle eventHandle:(EventHandle)eventHandle;

-(void)setupBtn:(SetupSkipBtn)setupBtn;

@end
