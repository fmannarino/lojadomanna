//
//  NavigationViewController.h
//  lojadomanna
//
//  Created by Felipe Mannarino on 5/4/16.
//  Copyright © 2016 Felipe Mannarino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "HexColor.h"
#import "LoginViewController.h"


@interface NavigationViewController : UITableViewController {
    
IBOutlet UIButton *loginLogout;

    
}

@property (nonatomic, retain) UIButton *loginLogout;
@property (nonatomic, copy) NSString *name;

- (void)updateConfig;
- (BOOL )checkUser;

@end
