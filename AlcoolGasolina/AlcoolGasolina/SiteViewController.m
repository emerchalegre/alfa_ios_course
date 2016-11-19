//
//  SiteViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "SiteViewController.h"

@interface SiteViewController ()

@end

@implementation SiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlString = @"http://www.uol.com.br";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webSite.scalesPageToFit = YES;
    
    [self.webSite loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.spinner stopAnimating];
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
