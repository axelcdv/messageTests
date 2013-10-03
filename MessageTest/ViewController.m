//
//  ViewController.m
//  MessageTest
//
//  Created by Axel Colin de Verdière on 02/10/13.
//

#import "ViewController.h"
#import "MessageCell.h"
#import "Message.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *_messagesArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (_messagesArray == nil) {
            _messagesArray = [NSMutableArray new];
            
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a bigger text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is an even bigger text that should be on two lines"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a text"]];
            [_messagesArray addObject:[Message messageWithUsername:@"Bob" andText:@"hello this is a huge text that will be\
                                       on several lines but I don't known how many, blah blah blah\
                                       and blah blah blah again"]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:@"MessageCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UICollectionView delegate methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO
    Message *message = [_messagesArray objectAtIndex:indexPath.row];
    CGSize size = [MessageCell calculateTextSize:message.text];
    
    return CGSizeMake(320, size.height + [MessageCell extraHeight]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO:
    MessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    [cell setMessage:[_messagesArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _messagesArray.count;
}

@end
