//
//  ViewController.m
//  MoveTagDemo
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/6/20.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ViewController.h"
#import "MoveTag.h"

@interface ViewController () <MoveTagDelegete>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MoveTag *tag = [[MoveTag alloc] initWithFrame:CGRectMake(140, 140, 20, 20)];
    tag.distance = 250;
    tag.backColor = [UIColor redColor];
    tag.titleColor = [UIColor whiteColor];
    tag.font = [UIFont systemFontOfSize:10];
    tag.delegate = self;//设置代理
    tag.title = @"99+";
    [self.view addSubview:tag];
    
}
#pragma mark - MoveTagDelegete
-(void) delMoveTag {
    NSLog(@"has del MoveTag");
}

@end
