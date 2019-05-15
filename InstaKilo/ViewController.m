//
//  ViewController.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionReusableView.h"
#import "DecorationView.h"
#import "CustomFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) NSArray* imageNamesForSubject1;
@property (nonatomic,strong) NSArray* imageNamesForSubject2;
@property (nonatomic,strong) NSArray* imageNamesForSubject3;
@property (nonatomic,strong) NSArray* imageCollection;
@property (nonatomic,strong) UICollectionViewFlowLayout* layout;
@property (nonatomic,strong) NSArray* sectionTitle;
@property (nonatomic,strong) UISegmentedControl* segmentControl;
@property (nonatomic,strong) NSArray* imageCollectionByLocation;
@property (nonatomic,strong) NSArray* selectedImageCollection;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSegmentControl];
    [self setupCollectionView];
    
    [self setupData];
}

-(void)setupData{
    self.imageNamesForSubject1 = [[NSArray alloc]initWithObjects:@"image1",@"image2",@"image3", nil];
    self.imageNamesForSubject2 = [[NSArray alloc]initWithObjects:@"image4",@"image5",@"image6", nil];
    self.imageNamesForSubject3 = [[NSArray alloc]initWithObjects:@"image7",@"image8",@"image9", @"image10", nil];
    self.imageCollection = [[NSArray alloc]initWithObjects:self.imageNamesForSubject1,self.imageNamesForSubject2,self.imageNamesForSubject3, nil];
    self.imageCollectionByLocation = [[NSArray alloc]initWithObjects:self.imageNamesForSubject2, self.imageNamesForSubject3, self.imageNamesForSubject1,nil];
    self.selectedImageCollection = [[NSArray alloc]initWithArray:self.imageCollection];
    self.sectionTitle = [[NSArray alloc]initWithObjects:@"section1", @"section2", @"section3", nil];
}

-(void)setupSegmentControl{
    UISegmentedControl* segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Subject",@"Location"]];
    [self.navigationItem setTitleView:segmentControl];
    [segmentControl addTarget:self action:@selector(handleSegmentControl) forControlEvents:UIControlEventValueChanged];
    self.segmentControl = segmentControl;
}

-(void)setupCollectionView{
    CustomFlowLayout* customFlowLayout = [[CustomFlowLayout alloc]init];
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout: customFlowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"customCell"];
    [collectionView registerClass:[CustomCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"customHeader"];
    
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    [NSLayoutConstraint activateConstraints:@[
                                              [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
                                              [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                              [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                              [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0],
                                              ]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.selectedImageCollection.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.selectedImageCollection[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.selectedImageCollection[indexPath.section][indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"customHeader" forIndexPath:indexPath]  ;
    header.label.text = self.sectionTitle[indexPath.section];
    return header;
}


-(void)handleSegmentControl{
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.selectedImageCollection = self.imageCollection;
        [self.collectionView reloadData];
    } else if (self.segmentControl.selectedSegmentIndex == 1){
        self.selectedImageCollection = self.imageCollectionByLocation;
        [self.collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.frame.size.width, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.collectionView.frame.size.width / 4, self.collectionView.frame.size.width / 4);
}


@end
