//
//  Message.h
//
//  Created by Axel Colin de Verdière on 16/09/13.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *text;

# pragma mark - Class methods

+ (Message *)messageWithUsername:(NSString *)username andText:(NSString *)text;

# pragma mark - Instance methods

- (BOOL)isFromSelf;

@end

