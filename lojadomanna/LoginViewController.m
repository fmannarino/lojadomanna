//
//  LoginViewController.m
//  lojadomanna
//
//  Created by Felipe Mannarino on 5/5/16.
//  Copyright © 2016 Felipe Mannarino. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize delegateMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButton:(id)sender {
    NSString *usuario = _usuarioTextField.text;
    NSString *senha = _senhaTextField.text;
    NSLog(@"usuario: %@", usuario);
    NSLog(@"senha: %@", senha);
    if([usuario isEqualToString:@"usuarioteste"] && [senha isEqualToString:@"teste1234"]){
        NSLog(@"logado");
        [self addUserLoggedInPlist:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self addUserLoggedInPlist:NO];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"LOGIN" message:@"Usuário ou senha invalido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    NavigationViewController *navigationViewController = delegateMenu;
    [navigationViewController updateConfig];
}

- (void)checkUser {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"Login.plist"];
    NSMutableDictionary* updateVal = [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
    NSLog(@"Dictionary = %@", updateVal);
    NSString *array1 = [updateVal objectForKey:@"logado"];
    //    NSLog(@"array = %@", array);
    NSLog(@"array = %@", array1);
    if ([array1 isEqualToString:@"true"]) {
        NSLog(@"logado");
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"LOGIN" message:@"Usuário ou senha invalido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)addUserLoggedInPlist:(BOOL )logado {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"Login.plist"];
    if ([fileManager fileExistsAtPath:documentsPath] == NO) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Login" ofType:@"plist"];
        [fileManager copyItemAtPath:bundlePath toPath:documentsPath error:&error];
    }
    NSLog(@"AQUI2");
    NSMutableDictionary* updateVal = [[NSMutableDictionary alloc] initWithContentsOfFile:documentsPath];
    if (logado == YES) {
        [updateVal setObject:@"true" forKey:@"logado"];
        [updateVal writeToFile:documentsPath atomically:YES];
    }else{
        [updateVal setObject:@"false" forKey:@"logado"];
        [updateVal writeToFile:documentsPath atomically:YES];
    }

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
