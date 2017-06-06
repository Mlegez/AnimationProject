//
//  ViewController.m
//  AnimationProjrct
//
//  Created by 杨泽 on 2017/6/6.
//  Copyright © 2017年 yangze. All rights reserved.
//

#import "ViewController.h"
#import "HYSineWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HYSineWaveView *waveView = [[HYSineWaveView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:waveView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
