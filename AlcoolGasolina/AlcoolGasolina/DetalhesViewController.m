//
//  DetalhesViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end

@implementation DetalhesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.item) {
        self.lblGas.text = [NSString stringWithFormat:@"Gasolina: R$ %@", [self.item objectForKey:@"gas"]];
        self.lblAlcohol.text = [NSString stringWithFormat:@"Alcool: R$ %@", [self.item objectForKey:@"alcohol"]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
