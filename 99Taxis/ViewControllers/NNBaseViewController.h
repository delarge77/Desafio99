//
//  NNBaseViewController.h
//  99Taxis
//
//  Created by Alessandro dos santos pinto on 8/12/15.
//  Copyright (c) 2015 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NNBaseViewController : UIViewController

- (void)dismissHud;
- (void)dismissHudOnView:(UIView *)view;
- (MBProgressHUD *)showLoadingMessage:(NSString *)message;
- (MBProgressHUD *)showLoadingMessage:(NSString *)message inView:(UIView *)view;

- (MBProgressHUD *)showErrorMessage:(NSString *)errorMessage;
- (MBProgressHUD *)showErrorMessage:(NSString *)errorMessage inView:(UIView *)view;
- (MBProgressHUD *)showErrorMessage:(NSString *)errorMessage inView:(UIView *)view compeltitionBlock:(MBProgressHUDCompletionBlock)completition;

- (MBProgressHUD *)showHudWithCustomView:(UIView *)customView
                                  inView:(UIView *)view
                             withMessage:(NSString *)message
                       compeltitionBlock:(MBProgressHUDCompletionBlock)completition;

- (void)presentError:(NSError *)error inView:(UIView *)view;

@end
