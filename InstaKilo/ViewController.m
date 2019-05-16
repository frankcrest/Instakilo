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

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDragDelegate, UICollectionViewDropDelegate>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) NSMutableArray* imageNamesForSubject1;
@property (nonatomic,strong) NSMutableArray* imageNamesForSubject2;
@property (nonatomic,strong) NSMutableArray* imageNamesForSubject3;
@property (nonatomic,strong) NSMutableArray* imageCollection;
@property (nonatomic,strong) UICollectionViewFlowLayout* layout;
@property (nonatomic,strong) NSArray* sectionTitle;
@property (nonatomic,strong) UISegmentedControl* segmentControl;
@property (nonatomic,strong) NSMutableArray* imageCollectionByLocation;
@property (nonatomic,strong) NSMutableArray* selectedImageCollection;
@property (nonatomic,assign) CGPoint initialPoint;
@property (nonatomic,assign) CGPoint centerPoint;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSegmentControl];
    [self setupCollectionView];
    
    [self setupData];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTapped:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:tapGesture];
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [self.collectionView addGestureRecognizer:pinchGesture];
    
    self.collectionView.dragInteractionEnabled = YES;
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
}

-(void)setupData{
    self.imageNamesForSubject1 = [[NSMutableArray alloc]initWithObjects:@"image1",@"image2",@"image3", nil];
    self.imageNamesForSubject2 = [[NSMutableArray alloc]initWithObjects:@"image4",@"image5",@"image6", nil];
    self.imageNamesForSubject3 = [[NSMutableArray alloc]initWithObjects:@"image7",@"image8",@"image9", @"image10", nil];
    self.imageCollection = [[NSMutableArray alloc]initWithObjects:self.imageNamesForSubject1,self.imageNamesForSubject2,self.imageNamesForSubject3, nil];
    self.imageCollectionByLocation = [[NSMutableArray alloc]initWithObjects:self.imageNamesForSubject2, self.imageNamesForSubject3, self.imageNamesForSubject1,nil];
    self.selectedImageCollection = [[NSMutableArray alloc]initWithArray:self.imageCollection];
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

-(void)handleDoubleTapped:(UITapGestureRecognizer*)sender{
    CGPoint tapLocation = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    
    [self.collectionView performBatchUpdates:^{
        
        if (self.selectedImageCollection[indexPath.section] != nil) {
            NSMutableArray* selectedArray = self.selectedImageCollection[indexPath.section];
            [selectedArray removeObjectAtIndex:indexPath.item];
            [self.selectedImageCollection replaceObjectAtIndex:indexPath.section withObject:selectedArray];
            NSArray *indexes = [[NSArray alloc]initWithObjects:indexPath, nil];
            [self.collectionView deleteItemsAtIndexPaths:indexes];
        }
        
    }completion:nil];
     

}

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath{
    UIDragItem* item = self.selectedImageCollection[indexPath.section][indexPath.item];
    NSItemProvider * itemProvider = [[NSItemProvider alloc]initWithObject:(NSString*) item];
    UIDragItem* dragItem = [[UIDragItem alloc]initWithItemProvider:itemProvider];
    dragItem.localObject = item;
    NSArray* dragItemAray = [[NSArray alloc]initWithObjects:dragItem, nil];
    return dragItemAray;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath{
    if (self.collectionView.hasActiveDrag) {
        UICollectionViewDropProposal* dropProposal = [[UICollectionViewDropProposal alloc]initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
        return dropProposal;
    }
    UICollectionViewDropProposal*  dropProposal = [[UICollectionViewDropProposal alloc]initWithDropOperation:UIDropOperationForbidden];
    return dropProposal;
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator{
    NSIndexPath* destinationIndexPath = [[NSIndexPath alloc]init];
    NSIndexPath* indexPath = [[NSIndexPath alloc]init];
    if (coordinator.destinationIndexPath != nil) {
        indexPath = coordinator.destinationIndexPath;
        destinationIndexPath = indexPath;
    }
    if (coordinator.proposal.operation == UIDropOperationMove && destinationIndexPath != nil) {
        [self reorderItems:coordinator destinationIndexPath:destinationIndexPath collectionView:self.collectionView];
    }
}
        
-(void)reorderItems:(id<UICollectionViewDropCoordinator>)coordinator destinationIndexPath:(NSIndexPath*)destinationIndexPath
collectionView:(UICollectionView*)collectionView{
    
    NSIndexPath* sourceIndexPath = [[NSIndexPath alloc]init];
    if (coordinator.items.firstObject != nil) {
         id<UICollectionViewDropItem> item = coordinator.items.firstObject;
        if (item.sourceIndexPath != nil) {
            sourceIndexPath = item.sourceIndexPath;
            [self.collectionView performBatchUpdates:^{
                if (sourceIndexPath.section == destinationIndexPath.section) {
                    id object = [self.selectedImageCollection[sourceIndexPath.section] objectAtIndex:sourceIndexPath.item];
                    [self.selectedImageCollection[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
                    [self.selectedImageCollection[sourceIndexPath.section]insertObject:object atIndex:destinationIndexPath.item];
                } else {
                    id object = [self.selectedImageCollection[sourceIndexPath.section] objectAtIndex:sourceIndexPath.item];
                    [self.selectedImageCollection[sourceIndexPath.section]removeObjectAtIndex:sourceIndexPath.item];
                    [self.selectedImageCollection[destinationIndexPath.section]insertObject:object atIndex:destinationIndexPath.item];
                }
                [self.collectionView deleteItemsAtIndexPaths:@[sourceIndexPath]];
                [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];

            } completion:nil];
            [coordinator dropItem:item.dragItem toItemAtIndexPath:destinationIndexPath];
        }
    }
}

-(void)handlePinch:(UIPinchGestureRecognizer*)sender{
    CustomFlowLayout* customFlowLayout = (CustomFlowLayout*)self.collectionView.collectionViewLayout;
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.initialPoint = [sender locationInView:self.collectionView];
        NSLog(@"%f",self.initialPoint.x);
        NSIndexPath* pinchCellPath = [self.collectionView indexPathForItemAtPoint:self.initialPoint];
        CustomCollectionViewCell* customCell = (CustomCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:pinchCellPath];
        self.centerPoint = customCell.center;
        customFlowLayout.pinchedCellPath = pinchCellPath;
    } else if (sender.state == UIGestureRecognizerStateChanged){
        customFlowLayout.pinchedCellScale = sender.scale;
        customFlowLayout.pinchedCellCenter = [sender locationInView:self.collectionView];
    } else if (sender.state == UIGestureRecognizerStateEnded){
        customFlowLayout.pinchedCellScale = 1;
        customFlowLayout.pinchedCellCenter = self.centerPoint;
    }
}

@end
