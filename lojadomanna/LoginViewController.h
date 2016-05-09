//
//  LoginViewController.h
//  lojadomanna
//
//  Created by Felipe Mannarino on 5/5/16.
//  Copyright © 2016 Felipe Mannarino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"

@protocol LoginDelegate <NSObject>

@end

@interface LoginViewController : UIViewController {

    id<LoginDelegate>delegateMenu;
    
}
@property (weak, nonatomic) IBOutlet UITextField *usuarioTextField;
@property (weak, nonatomic) IBOutlet UITextField *senhaTextField;
@property (retain, strong) id<LoginDelegate>delegateMenu;

- (void)addUserLoggedInPlist:(BOOL )logado;
- (void)checkUser;

@end
