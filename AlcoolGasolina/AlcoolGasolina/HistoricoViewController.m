//
//  HistoricoViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "HistoricoViewController.h"
#import "DetalhesViewController.h"

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dados.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"Celula"];
    
    if(celula == nil){
        celula =[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Celula"];
    }
    
    @try {
        //verifica se existe no array a linha atual da tabela
        if([self.dados objectAtIndex:indexPath.row] != nil) {
            //NSDictionary *item = [self.dados objectAtIndex:indexPath.row];
            NSDictionary *item = [self.dados objectAtIndex:(self.dados.count - indexPath.row - 1)];
            //carregando o resultado no Titulo da Coluna
            celula.textLabel.text = [self resultado:item];
            //caregando o valor dos combustiveis no subtitulo
            celula.detailTextLabel.text = [NSString stringWithFormat:@"Gas: %@. Alcohol: %@", [ item objectForKey:@"gas"], [ item objectForKey:@"alcohol"]];
        }
    }
    @catch(NSException *exception) { }
    @finally { }
    
    return celula;
}

-(NSString *)resultado:(NSDictionary *)item {
    float alcool = [[item objectForKey:@"alcohol"]floatValue];
    float gasolina = [[item objectForKey:@"gas"]floatValue];
    
    if(alcool <= (gasolina * 0.7)) {
        return @"Compensa utilizar Álcool - Mas se for flex viu";
    }
    else {
        return @"Compensa utilizar Gasolina - Rykão";
    }
    
}

/*
//clique da celula capturando o indice
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //buscando o dicionario dentro do array, pelo indice da celula clicada
    NSDictionary *item = [self.dados objectAtIndex:indexPath.row];
    
    //DetalhesViewController *detalhes =
    [self performSegueWithIdentifier:@"telaDetalhe" sender:self];
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"telaDetalhe"]) {
        //buscando qual o indice da linha selecionada
        NSInteger row = [self.tabela.indexPathForSelectedRow row];
        
        //carregando o dicionario pelo indice selecionado
        //NSDictionary *item = [self.dados objectAtIndex:row];
        NSDictionary *item = [self.dados objectAtIndex:(self.dados.count - row - 1)];
        
        //instancionado a Detalhes, carregando o destino da segue
        DetalhesViewController *detalhes = segue.destinationViewController;

        //carregando o item local, no item da tela de detalhesæ
        detalhes.item = item;
        
        //desmarcando a selecao da celula da tabela
        [self.tabela deselectRowAtIndexPath:self.tabela.indexPathForSelectedRow animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
