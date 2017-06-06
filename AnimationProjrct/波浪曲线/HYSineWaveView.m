//
//  HYSineWaveView.m
//  AnimationProjrct
//
//  Created by 杨泽 on 2017/6/6.
//  Copyright © 2017年 yangze. All rights reserved.
//

#import "HYSineWaveView.h"

@interface HYSineWaveView ()

@property (nonatomic, strong) CAShapeLayer              *shapeLayer;

@property (nonatomic, strong) CADisplayLink             *displayLink;

@property (nonatomic, assign) CGFloat                   offSet;

@end

//相关概念解释
//
//正弦函数: y =Asin（ωx+φ）+C
//A 表示振幅，也就是使用这个变量来调整波浪的高度
//ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
//φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
//C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。

//在这里我们设定了两个正弦曲线上的点的横坐标间距是1，现在来解释一下通过横坐标x来得出y的计算过程：
//
//1
//y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
/*
 第一个self.maxAmplitude表示曲线的波峰值，
 360.0 / _waveWidth计算出单位间距1pixel代表的度数，
 x * M_PI / 180表示将横坐标值弧度转换为角度
 self.frequency表示角速度，即单位面积内波动次数，波浪的大小。
 self.phase * M_PI/ 180代表上面公式中的初相，通过规律的变化初相，可以制造出曲线上的点动起来的效果，self.maxAmplitude代表偏距，由于我们需要让波浪曲线的波峰在layer的范围内显示，所以需要将整个曲线向下移动波峰大小的单位，因为CALayer使用左手坐标系，所以向下移动需要加上波峰的大小。
 */
// 速度
static CGFloat waveSpeed = 1/M_PI/3;
// 振幅
static CGFloat waveA = 10;
// 周期

@implementation HYSineWaveView

- (void)dealloc {
    [self removerDisplayLink];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.layer addSublayer:self.shapeLayer];
        [self initDisplayLink];
    }
    return self;
}

- (void)initDisplayLink {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLink)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.fillColor = [UIColor greenColor].CGColor;
        _shapeLayer.lineWidth = 1.5;
    }
    return _shapeLayer;
}

- (void)removerDisplayLink {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)setCurrentFirstWaveLayerPath {
    //创建一个路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat y = self.frame.size.height/2.0;
    
    //将点移动到 x=0,y=currentK的位置
    [path moveToPoint:CGPointMake(0, y)];
    for (NSInteger x = 0.0f; x <= self.frame.size.width; x++) {
        //正玄波浪公式
        y = waveA *sin(360.0 / self.frame.size.width * (x  * M_PI / 180) * 1 + self.offSet) + self.frame.size.height - waveA;
        //将点连成线
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    _shapeLayer.path = path.CGPath;
}

- (void)updateLink {
    
    self.offSet += waveSpeed;
    [self setCurrentFirstWaveLayerPath];
}



@end
