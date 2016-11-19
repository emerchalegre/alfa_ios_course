//
//  SiteViewController.h
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webSite;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

-(IBAction)voltar:(id)sender;

@end
