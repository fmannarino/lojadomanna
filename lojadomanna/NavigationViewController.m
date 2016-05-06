//
//  NavigationViewController.m
//  lojadomanna
//
//  Created by Felipe Mannarino on 5/4/16.
//  Copyright © 2016 Felipe Mannarino. All rights reserved.
//

#import "NavigationViewController.h"
#import "SWRevealViewController.h"

@interface NavigationViewController ()

@end

NSString * const FILENAME_WITH_COLORS = @"menu";
NSString * const EXTENSION_OF_FILENAME_WITH_PLACES = @"json";

@implementation NavigationViewController{
    NSArray *menu;

}

@synthesize loginLogout;

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"first", @"second"];
    [self updateConfig];
    //[self changeMenuCell];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue isKindOfClass:[SWRevealViewControllerSegue class]]) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }
    
}


- (IBAction)ButtonLoginLogout:(id)sender {
    BOOL logado = [self checkUser];
    if (logado == YES) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"SAIR" message:@"Você deseja se desconectar?" delegate:self cancelButtonTitle:@"NÃO" otherButtonTitles:@"SIM", nil];
        alert.tag = 200;
        [alert show];
    }else{
       [self showLogin]; 
    }
    
}



- (void)readMenu {
    NSString* path = [[NSBundle mainBundle] pathForResource:FILENAME_WITH_COLORS
                                                     ofType:EXTENSION_OF_FILENAME_WITH_PLACES];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSDictionary *dic = [[content objectFromJSONString] objectForKey:@"menu"];
    
    self.name = [dic objectForKey:@"nome"];

}

- (void)updateConfig {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"Login.plist"];
    NSMutableDictionary* updateVal = [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
    NSLog(@"Dictionary = %@", updateVal);
    NSString *array1 = [updateVal objectForKey:@"logado"];
    NSString *array2 = [updateVal objectForKey:@"nome"];
    NSLog(@"array = %@", array1);
    NSLog(@"UPDATECONFIG");
    if ([array1 isEqualToString:@"true"]) {
            NSLog(@"ENTROU UPDATE");
            NSString *name = [array2 stringByAppendingString:@"  |  SAIR"];
            NSUInteger characterCount = [name length];
            NSLog(@"CONMTAGEM %lu",(unsigned long)characterCount);
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, characterCount-5)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#2470A7"] range:NSMakeRange(characterCount-4, 4)];
            //[loginLogout setTitle:name forState:UIControlStateNormal];
            [loginLogout setAttributedTitle:string forState:UIControlStateNormal];
            //_loginLogout.titleLabel.text = @"FELIPE | SAIR";
    }else{
        NSLog(@"ENTROU UPDATE1");
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"FAÇA SEU LOGIN"];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 14)];
        [loginLogout setAttributedTitle:string forState:UIControlStateNormal];
    }
}

- (BOOL )checkUser {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"Login.plist"];
    NSMutableDictionary* updateVal = [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
    NSLog(@"Dictionary = %@", updateVal);
    NSString *array1 = [updateVal objectForKey:@"logado"];
    //    NSLog(@"array = %@", array);
    NSLog(@"array = %@", array1);
    BOOL logado;
    if ([array1 isEqualToString:@"true"]) {
        logado = YES;
        
    }else{
        logado = NO;
    }
    return logado;
}

- (void)showLogin {
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //    paywallViewController.delegateMenu = self.revealController;
    loginViewController.delegateMenu = self;
    [loginViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:loginViewController animated:YES completion:nil];
    [userPreferences synchronize];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            [loginViewController addUserLoggedInPlist:NO];
            [self updateConfig];
        }
        alertView.tag = 0;
    }
    
}

@end
