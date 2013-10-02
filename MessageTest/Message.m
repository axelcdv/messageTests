//
//  Message.m
//
//  Created by Axel Colin de Verdière on 16/09/13.
//


#import "Message.h"

@implementation Message {
    BOOL _sent;
}

# pragma mark - Class methods

+ (Message *)messageWithUsername:(NSString *)username andText:(NSString *)text
{
    Message *message = [[Message alloc] init];
    
    [message setUsername:username];
    [message setText:text];
    
    return message;
}


# pragma mark - Instance methods


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, username = %@, text = %@",
            [super description], _username, _text];
}

- (BOOL)isFromSelf
{
    return YES;
}

@end
