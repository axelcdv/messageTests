//
//  MessageCell.h
//  MessageTest
//
//  Created by Axel Colin de Verdière on 02/10/13.
//

#import <UIKit/UIKit.h>

#import "Message.h"

@interface MessageCell : UICollectionViewCell

@property (nonatomic, strong) Message *message;

# pragma mark - Class methods

+ (CGSize)calculateTextSize:(NSString *)text;

+ (CGFloat)extraHeight;

@end
