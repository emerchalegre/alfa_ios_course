//
//  ViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dados.plist"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        dados = [NSMutableArray arrayWithContentsOfFile:filePath];
    } else {
        dados = [[NSMutableArray alloc] init];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)calcular:(id)sender {
    float alcool = self.valorAlcool.text.floatValue;
    float gasolina = [self.valorGasolina.text floatValue];
    
    if(alcool <= (gasolina * 0.7)) {
        [self mostrarMensagem:@"Álcool x Gasolina - Fight" msg:@"Compensa utilizar Álcool - Mas se for flex viu"];
    }
    else {
        [self mostrarMensagem:@"Álcool x Gasolina - Fight" msg:@"Compensa utilizar Gasolina - Rykão"];
    }
    
}

-(IBAction)share:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                              otherButtonTitles:
                                                @"Share on Facebook",
                                                @"Share on Twitter",
                                                @"Share on E-mail",
                            @"Share on Instagram", nil];
    [popup showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self FBShare];
            break;
        case 1:
            [self TwitterShare];
            break;
        case 2:
            [self EmailShare];
            break;
        default:
            break;
    }
}

-(void)FBShare{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [self presentViewController:controller animated:YES completion:Nil];
        
        SLComposeViewControllerCompletionHandler controlEnd = ^(SLComposeViewControllerResult result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        controller.completionHandler = controlEnd;
    } else {
        [self mostrarMensagem:@"Alcohol x Gas" msg:@"Facebook is not configured or installed"];
        return;
    }
    
    
    
}

-(void)TwitterShare{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.faculdadealfaumuarama.com.br/"]];
        
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result){
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    [self mostrarMensagem:@"Tweet" msg:@"Tweet don't sent!"];
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [self mostrarMensagem:@"Tweet" msg:@"Tweet sent with success!"];
                    break;
            }
        }];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
        
        
    } else {
        [self mostrarMensagem:@"Alcohol x Gas" msg:@"Twitter is not configured or installed"];
        return;
    }
    
}

-(void)EmailShare{
    if (![MFMailComposeViewController canSendMail]) {
        [self mostrarMensagem:@"Alcohol x Gas" msg:@"E-mail not configured!"];
    } else {
        MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
        email.mailComposeDelegate = self;
        [email setSubject:@"Alcohol or Gas"];
        [email setMessageBody:@"Testando os dados de email" isHTML:NO];
        [email setToRecipients:[NSArray arrayWithObjects:@"emerson.chalegre@gazin.com.br", @"emerchalegre@gmail.com", nil]];
         
        //NSData *anexo = UIImagePNGRepresentation([UIImage imageNamed:@"Logo.png"]);
        
        //[email addAttachmentData:anexo mimeType:@"image/png" fileName:@"Logo.png"];
        
        [self presentViewController:email animated: YES completion:nil];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch(result) {
            //  This means the user cancelled without sending the Tweet
        case MFMailComposeResultFailed:
            [self mostrarMensagem:@"E-mail" msg:@"Error sent e-mail"];
            break;
            //  This means the user hit 'Send'
        case MFMailComposeResultSent:
            [self mostrarMensagem:@"Email" msg:@"E-mail sent with succes!"];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            [self mostrarMensagem:@"E-mail" msg:@"E-mail with error!"];
    }
}

-(NSString *)returnMsg {
    float alcool = self.valorAlcool.text.floatValue;
    float gasolina = [self.valorGasolina.text floatValue];
    
    NSString *ret = [NSString stringWithFormat:@"Value of alcohol: %f. Valor da Gasolina: %f", alcool, gasolina ];
    
    return ret;
}

-(void)mostrarMensagem:(NSString *)titulo msg:(NSString *)mensagem {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: titulo
                                                   message: mensagem
                                                  delegate: self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    
    [alert show];
    alert = nil;	
}

-(IBAction)save:(id)sender {
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys: self.valorAlcool.text, @"alcohol", self.valorGasolina.text, @"gas", nil];
    [dados addObject:item];
    [dados writeToFile:filePath atomically:YES];
    [self listarDados];
}

-(void)listarDados {
    for(NSDictionary *item in dados) {
        NSLog(@"Alcohol: %@. Gas: %@",
              [item objectForKey:@"alcohol"],
              [item objectForKey:@"gas"]
              );
    }
    NSLog(@"***********************************");
}

@end
