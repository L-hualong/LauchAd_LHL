//
//  LauchAdController.m
//  test_oc2
//
//  Created by 刘华龙 on 2017/2/28.
//  Copyright © 2017年 刘华龙. All rights reserved.
//

#import "LauchAdController.h"

@interface LauchAdController ()

@property (nonatomic,strong)UIImageView *adImageView;
@property (nonatomic,copy)SetupSkipBtn setupBtn;
@property (nonatomic,strong)UIButton* skipBtn;
@property (nonatomic,copy)EventHandle eventHandle;
@property (nonatomic,strong)NSTimer* timer;

@end

@implementation LauchAdController

-(instancetype)initWithSetAdImageHandkle:(SetAdImageHandle)setAdImageHandle eventHandle:(EventHandle)eventHandle{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _eventHandle = eventHandle;
        setAdImageHandle(self.adImageView);
        self.countDown = 5;

//        _setupBtn(self.skipBtn,_countDown);

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTapGes];
    [self.view addSubview:self.adImageView];
    [self.view addSubview:self.skipBtn];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startTimer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

-(void)dealloc{
    [self stopTimer];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.adImageView.frame = [UIScreen mainScreen].bounds;
    [self.skipBtn sizeToFit];
    CGRect btnFrame = self.skipBtn.bounds;
    CGFloat margin = 20;
    btnFrame.origin.x = self.view.bounds.size.width - margin - self.skipBtn.bounds.size.width;
    btnFrame.origin.y = margin;
    btnFrame.size.width += 10;
    self.skipBtn.frame = btnFrame;
}

-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)timerHandle{
    self.countDown--;
    if (_countDown == 0 && _eventHandle) {
        [self stopTimer];
        _eventHandle(CellbackEvent_AdShowFinished);
    }

}

-(void)setCountDown:(NSInteger)countDown{
    _countDown = countDown;
    if (_setupBtn) {
        _setupBtn(self.skipBtn,countDown);
    }else{
        [self.skipBtn setTitle:[NSString stringWithFormat:@"%ld秒跳过",_countDown] forState:UIControlStateNormal];

    }
}

-(void)addTapGes{
    UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickAd)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGes];
}

-(void)setupBtn:(SetupSkipBtn)setupBtn{
    _setupBtn = setupBtn;
}

-(UIButton*)skipBtn{
    if (!_skipBtn) {
        UIButton* btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        [btn addTarget:self action:@selector(tapClickBtn) forControlEvents:UIControlEventTouchUpInside];
        _skipBtn = btn;
    }
    return _skipBtn;
}

-(void)tapClickBtn{
    if (_eventHandle) {
        _eventHandle(CellbackEvent_clickBtn);
    }
}


-(void)tapClickAd{
    if (_eventHandle) {
        _eventHandle(CellbackEvent_clickAd);
    }
}

-(UIImageView*)adImageView{
    if (!_adImageView) {
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _adImageView = imageView;
    }
    return _adImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
