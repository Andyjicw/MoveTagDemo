//
//  MoveTag.m
//  MoveTagDemo
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/6/20.
//  Copyright © 2016年 andy. All rights reserved.
//

#define WIDTH self.frame.size.width
#define SCALE 0.8f

#import "MoveTag.h"
#import <QuartzCore/QuartzCore.h>

@interface MoveTag () <UIGestureRecognizerDelegate, MoveTagDelegete>

@property (nonatomic, strong) UILabel      *moveSpot;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property CGRect oldFrame;

@end

@implementation MoveTag

- (void)drawCircle {
    
    self.circleLayer           = [CAShapeLayer layer];
    self.circleLayer.frame     = CGRectMake(WIDTH * (1 - SCALE) / 2, WIDTH * (1 - SCALE) / 2, WIDTH * SCALE, WIDTH * SCALE);
    self.circleLayer.fillColor = self.backColor.CGColor;
    CGRect frame               = CGRectMake(0, 0, WIDTH * SCALE, WIDTH * SCALE);
    UIBezierPath *circlePath   = [UIBezierPath bezierPathWithOvalInRect:frame];
    self.circleLayer.path      = circlePath.CGPath;
    [self.layer addSublayer:self.circleLayer];
}

- (void) setUpView {
    
    self.moveSpot                         = [[UILabel alloc] init];
    self.moveSpot.frame                   = CGRectMake(0, 0, WIDTH, WIDTH);
    self.moveSpot.text                    = self.title;
    self.moveSpot.font                    = self.font;
    self.moveSpot.textColor               = self.titleColor;
    self.moveSpot.textAlignment           = NSTextAlignmentCenter;
    self.moveSpot.backgroundColor         = self.backColor;
    self.moveSpot.layer.cornerRadius      = WIDTH / 2;
    self.moveSpot.layer.masksToBounds     = true;
    self.moveSpot.userInteractionEnabled  = true ;
    [self addSubview:self.moveSpot];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [self.moveSpot addGestureRecognizer:panGestureRecognizer];
    self.oldFrame = self.frame;
}

- (void) handlePan:(UIPanGestureRecognizer *) recognizer {
    
    CGPoint translation    = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGPoint pointB         = CGPointMake(recognizer.view.center.x, recognizer.view.center.y);
    [linePath moveToPoint: CGPointMake(WIDTH / 2, WIDTH / 2)];
    [linePath addLineToPoint: pointB];
    self.shapeLayer.path        = linePath.CGPath;
    
    float newDistance;
    newDistance  = [self distanceFromPointX:CGPointMake(WIDTH / 2, WIDTH / 2) distanceToPointY:pointB];
    
    if (self.distance < newDistance) {
        self.circleLayer.hidden = true;
        self.shapeLayer.hidden  = true;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.distance < newDistance) {
            [self removeFromSuperview];
            
            if ([self.delegate respondsToSelector:@selector(delMoveTag)]) {
                [self.delegate delMoveTag];
            }
        } else {
            recognizer.view.center = CGPointMake(WIDTH / 2, WIDTH / 2);
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint: CGPointMake(WIDTH / 2, WIDTH / 2)];
            [linePath addLineToPoint: CGPointMake(WIDTH / 2, WIDTH / 2)];
            self.shapeLayer.path   = linePath.CGPath;
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    self.shapeLayer.hidden  = false;
    self.circleLayer.hidden = false;
    return true;
}

- (float) distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end {
    
    float newDistance;
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    newDistance   = sqrt((xDist * xDist) + (yDist * yDist));
    return newDistance;
}

- (void) setTitle:(NSString *)title {
    _title                      = title;
    self.shapeLayer             = [CAShapeLayer layer];
    self.shapeLayer.lineWidth   = WIDTH * 0.6;
    self.shapeLayer.strokeColor = self.backColor.CGColor;
    [self.layer addSublayer:self.shapeLayer];
    [self drawCircle];
    [self setUpView];
}

@end
