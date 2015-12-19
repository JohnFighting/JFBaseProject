//
//  ViewController.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/19.
//  Copyright © 2015年 john. All rights reserved.
//

#import "ViewController.h"
#import "JFNewsNetManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [JFNewsNetManager getNewsListWithStartIndex:11 completionHandle:^(id model, NSError *error) {
        if (!error) {
            NSLog(@"model %@", model);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
