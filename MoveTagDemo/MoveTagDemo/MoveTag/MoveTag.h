//
//  MoveTag.h
//  MoveTagDemo
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/6/20.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoveTagDelegete <NSObject>

@optional

- (void) delMoveTag;

@end

@interface MoveTag : UIView <MoveTagDelegete>
/**
 *  文字
 */
@property (nonatomic, copy  ) NSString *title;
/**
 *  文字大小
 */
@property (nonatomic, strong) UIFont   *font;
/**
 *  文字颜色
 */
@property (nonatomic, strong) UIColor  *titleColor;
/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor  *backColor;
/**
 *  消失半径
 */
@property  CGFloat                      distance;
/**
 *  代理
 */
@property (nonatomic, weak) id <MoveTagDelegete> delegate;

@end
