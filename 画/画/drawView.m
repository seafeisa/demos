//
//  drawView.m
//  画
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "drawView.h"

@interface drawView ()
// 渐变背景视图
@property (nonatomic, strong) UIView *gradientBackgroundView;
// 渐变图层
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
// 颜色数组
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;

@property (nonatomic, strong)UIBezierPath * path1;

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@property (nonatomic, assign) int countq;
@end


@implementation drawView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, bounceX, bounceY);
    CGContextAddLineToPoint(context, bounceX, rect.size.height - bounceY);
    CGContextAddLineToPoint(context, rect.size.width - bounceX, rect.size.height - bounceY);
    CGContextStrokePath(context);
    self.countq = 0;
    [self createLabelX];
    [self createLabelY];
    [self drawGradientBackgroundView];
    [self setLineDash];
    
}

- (void)createLabelX{
    CGFloat month = 12;
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    for (NSInteger i = 0; i < month; i++) {
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/month * i + bounceX, self.frame.size.height - bounceY , (self.frame.size.width - 2*bounceX)/month- 5, bounceY/2)];
        
        LabelMonth.tag = 1000 + i;
        LabelMonth.text = [NSString stringWithFormat:@"%ld",i+1];
        LabelMonth.font = [UIFont systemFontOfSize:10];
//        LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
        [self addSubview:LabelMonth];
    
    }
}

- (void)createLabelY{
    CGFloat Ydivision = 6;
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    for (NSInteger i =0; i < Ydivision; i++) {
        
        
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0,self.frame.size.height - bounceY - (self.frame.size.height - 2*bounceY)/Ydivision*i, 20.0f, 20.0f/2.0)];
//           labelYdivision.backgroundColor = [UIColor greenColor];
        labelYdivision.tag = 2000 + i;
        labelYdivision.text = [NSString stringWithFormat:@"%ld",i*100];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
        
   
    }
}

- (void)drawGradientBackgroundView{
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    // 渐变背景视图(不含坐标轴)
    self.gradientBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(bounceX, bounceY, self.frame.size.width - 2*bounceX, self.frame.size.height - 2*bounceY)];
    [self addSubview:self.gradientBackgroundView];
    // 创建并设置渐变背景图层
    // 初始化CAGradientlayer对象, 使它的大小为渐变背景的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientBackgroundView.bounds;
    // 设置渐变区域的其实和终止位置 (范围 0 -1),即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1.0);
    // 设置颜色渐变的过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    // 将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackgroundView.layer addSublayer:self.gradientLayer];
    
}

- (void)setLineDash{
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    for (NSInteger i = 0; i < 6; i++) {
        CAShapeLayer *dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.fillColor = [UIColor clearColor].CGColor;
        // 默认设置路径宽度为0, 使其在其实状态现不现实
        dashLayer.lineWidth = 1.0;
        
        UILabel *label1 = [self viewWithTag:2000 + i];
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 1.0;
        UIColor *color = [UIColor blueColor];
        [color set];
        
        [path moveToPoint:CGPointMake(0, label1.frame.origin.y - bounceY)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 2*bounceX, label1.frame.origin.y - bounceY)];
        CGFloat dash[] = {10,20};// 第一个参数:单个线的长度  第二个参数:单个空白的长度
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.gradientBackgroundView.layer addSublayer:dashLayer];
    }
}

// 画折线图
- (void)dravLine{
    CGFloat bounceX = 20.0f;
    CGFloat bounceY = 200.0f;
    UILabel *label = [self viewWithTag:1000]; // 根据横坐标上面的label获取直线关键点的x值
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.0f;
    self.path1 = path;
    UIColor *color = [UIColor greenColor];
    [color set];
    [path moveToPoint:CGPointMake( label.frame.origin.x - bounceX, (600 -arc4random()%600) /600.0 * (self.frame.size.height - bounceY*2 ))];
    
    // 创建折线点标记
    for (NSInteger i = 0; i < 12; i ++) {
        UILabel *label1 = [self viewWithTag:1000 + i];
        CGFloat arc = arc4random()%600; // 折线点目前给的随机数
        [path addLineToPoint:CGPointMake(label1.frame.origin.x - bounceX,  (600 -arc) /600.0 * (self.frame.size.height - bounceY*2 ) )];
        UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x , (600 -arc) /600.0 * (self.frame.size.height - bounceY*2 )+ bounceY  , 30, 15)];
        falglabel.tag = 3000+i;
        falglabel.text = [NSString stringWithFormat:@"%.1f",arc];
        falglabel.font = [UIFont systemFontOfSize:8.0];
        [self addSubview:falglabel];
     
    }
    
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.lineChartLayer.fillColor = [UIColor clearColor].CGColor;
    // 默认设置路径宽度为0,使其在初始状态下不显示
    self.lineChartLayer.lineWidth = 0;
    self.lineChartLayer.lineCap = kCALineCapRound;  // 线 终点样式
    self.lineChartLayer.lineJoin = kCALineJoinRound;  // 线拐点样式
    
    [self.gradientBackgroundView.layer addSublayer:self.lineChartLayer];
    
}

#pragma mark 点击重新绘制折线和背景
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.countq++;
    if (self.countq%2 == 0) {
        //点一下删除折线 和转折点数据
        [self.lineChartLayer removeFromSuperlayer];
        for (NSInteger i = 0; i < 12; i++) {
            UILabel * label = (UILabel*)[self viewWithTag:3000 + i];
            [label removeFromSuperview];
        }
    }else{
        
        [self dravLine];
        
        self.lineChartLayer.lineWidth = 2;
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 3;
        pathAnimation.repeatCount = 1;
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
        pathAnimation.delegate = self;
        [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        //[self setNeedsDisplay];
    }
}



















@end
