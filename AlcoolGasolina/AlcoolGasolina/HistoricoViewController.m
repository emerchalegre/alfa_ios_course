//
//  HistoricoViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "HistoricoViewController.h"

@interface HistoricoViewController ()

@end

@implementation HistoricoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dados.plist"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        self.dados = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    [self.tabela reloadData];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
