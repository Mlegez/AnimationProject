# AnimationProject
动画相关Demo

##波浪动画
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
