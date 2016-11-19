//
//  MapaViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "MapaViewController.h"

@interface MapaViewController ()

@end

@implementation MapaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)limparPinos {
    [self.mapa removeAnnotations:self.mapa.annotations];
}

-(IBAction)alfa:(id)sender {
    [self limparPinos];
    
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    
    pino.coordinate = CLLocationCoordinate2DMake(-23.759554, -53.313904);
    
    pino.title = @"Faculdade Alfa Umuarama";

    [self.mapa addAnnotation:pino];
    
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(pino.coordinate, zoom);
    
    [self.mapa setRegion:regiao animated:YES];
}

-(IBAction)ondeEstou:(id)sender {
    [self limparPinos];
    //verificando se o servico de GPS está ativo
    if([CLLocationManager locationServicesEnabled]) {
        if(!self.locManager) {
            //instancioando o servico de GPS
            self.locManager = [[CLLocationManager alloc]init];
            self.locManager.delegate = self;
        }
        //inicializando a atualizacao da minha localizacao
        [self.locManager startUpdatingLocation];
    }
}

//metodo que recebe a posicao do GPS
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    
    CLLocation *localizacao = [locations lastObject];
    
    pino.coordinate = localizacao.coordinate;
    
    pino.title = @"Euuu";
    pino.subtitle = [NSString stringWithFormat:@"Lat: %f. Long: %f", localizacao.coordinate.latitude, localizacao.coordinate.longitude];
    
    [self.mapa addAnnotation:pino];
    
    [self.locManager stopUpdatingLocation];
    
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(pino.coordinate, zoom);
    
    [self.mapa setRegion:regiao animated:YES];
    
}

-(IBAction)mudarTipo:(id)sender {
    switch(self.mapa.mapType) {
        case MKMapTypeStandard:
            [self.mapa setMapType:MKMapTypeSatellite];
            break;
        case MKMapTypeSatellite:
            [self.mapa setMapType:MKMapTypeHybrid];
            break;
        default:
            [self.mapa setMapType:MKMapTypeStandard];
            break;
    }
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
