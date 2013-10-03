//
//  MessageCell.m
//
//  Created by Axel Colin de Verdière on 16/09/13.
//

#import <CoreText/CoreText.h>

#import "MessageCell.h"

#define kMyUsername     @"MyUsername"

@interface MessageCell ()



@end

@implementation MessageCell {
    UITextView *_textView;
    //    UILabel *_label;
    NSArray *_textViewHorizConstraints;
    NSArray *_queueViewConstraints;
    UIView *containerView;
    UIView *textContainerView;
    UIImageView *queueView;
    
    BOOL _isLastMessage;
    
    BOOL _sizeIsSet;
}

+ (MessageCell *)viewForNib
{
    UINib *nib = [UINib nibWithNibName:[[self class] description] bundle:nil];
    NSArray *objectsFromNib = [nib instantiateWithOwner:nil options:nil];
    MessageCell *view = (MessageCell *)[objectsFromNib lastObject];
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)addTextViewHorizConstraints
{
    
    NSNumber *width;
    if (_message != nil && _message.text != nil ) {
        CGSize textSize = [MessageCell calculateTextSize:_message.text];
        width = [NSNumber numberWithFloat:textSize.width + 40];
    } else {
        width = @15; // Random default
    }
    NSDictionary *metricsDic = NSDictionaryOfVariableBindings(width);
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(containerView, textContainerView, queueView);
    if ([_message isFromSelf]) {
        _textViewHorizConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:[textContainerView(width)]-(5)-|"
                                     options:0 metrics:metricsDic views:viewsDic];
        
        if (_queueViewConstraints != nil) {
            [containerView removeConstraints:_queueViewConstraints];
        }
        
        [queueView setImage:[UIImage imageNamed:@"queue"]];
        
        [containerView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"V:|[queueView]"
                                       options:0 metrics:0 views:viewsDic]];
        
        _queueViewConstraints = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:[queueView]|"
                                 options:0 metrics:0 views:viewsDic];
        
        [containerView addConstraints:_queueViewConstraints];
        
        
        [textContainerView setBackgroundColor:[UIColor grayColor]];
    } else {
        _textViewHorizConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|-(5)-[textContainerView(width)]"
                                     options:0 metrics:metricsDic views:viewsDic];
        
        if (_queueViewConstraints != nil) {
            [containerView removeConstraints:_queueViewConstraints];
        }
        
        [queueView setImage:[UIImage imageNamed:@"queue-gauche"]];
        
        [containerView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"V:|[queueView]"
                                       options:0 metrics:0 views:viewsDic]];
        _queueViewConstraints = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[queueView]"
                                 options:0 metrics:0 views:viewsDic];
        
        [containerView addConstraints:_queueViewConstraints];
        
        [textContainerView setBackgroundColor:COLOR_LIGHT_GREY];
    }
    [containerView addConstraints:_textViewHorizConstraints];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        textContainerView = [[UIView alloc] init];
        containerView = [[UIView alloc] init];
        _textView = [[UITextView alloc] init];
        
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setContentInset:UIEdgeInsetsZero];
        [_textView setContentOffset:CGPointMake(0, 0)];
        [_textView setEditable:NO];
        [_textView setScrollEnabled:NO];
        [_textView setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@Neue", FONT_BASENAME] size:18.0]];
        
        // Bugfixing
//        _textView.contentInset = UIEdgeInsetsZero;
        [_textView setTextContainerInset:UIEdgeInsetsZero];
//        [_textView.textContainer setLineFragmentPadding:0];
        
        queueView = [[UIImageView alloc] init];
        
        [textContainerView addSubview:_textView];
        
        [containerView addSubview:queueView];
        [containerView addSubview:textContainerView];
        [self addSubview:containerView];
        
        [textContainerView setClipsToBounds:NO];
        textContainerView.layer.cornerRadius = 15.0f;
        
        
        
        [queueView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSDictionary *viewsDic = NSDictionaryOfVariableBindings(_textView, queueView, textContainerView, containerView);
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[containerView]|"
                              options:0 metrics:0 views:viewsDic]];
        
        [textContainerView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|-(2)-[_textView]-(2)-|"
                                           options:0 metrics:0 views:viewsDic]];
        [textContainerView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|-(2)-[_textView]-(2)-|"
                                           options:0 metrics:0 views:viewsDic]];
        
        if (_textViewHorizConstraints != nil) {
            [containerView removeConstraints:_textViewHorizConstraints];
        }
        
        [self addTextViewHorizConstraints];
        
        
        [containerView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"V:|[textContainerView]|"
                                       options:0 metrics:0 views:viewsDic]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-(15)-[containerView]-(15)-|"
                              options:0
                              metrics:0 views:viewsDic]];
        
        
    }
    return self;
}



- (void)setMessage:(Message *)message
{
    _message = message;
//    _message.delegate = self;
    _textView.text = _message.text;
    if ([_message isFromSelf]) {
        [_textView setTextColor:[UIColor whiteColor]];
    } else {
        [_textView setTextColor:[UIColor blackColor]];
    }
    [containerView removeConstraints:_textViewHorizConstraints];
    [self addTextViewHorizConstraints];
    NSLog(@"Set message");
    [self layoutIfNeeded];
}
# pragma mark - Class methods

/**
 * Extra cell height to add to the text size
 */
+ (CGFloat)extraHeight
{
    return 9;
}

+ (CGRect)calculateTextBounds:(NSString *)text
{
    //    return [self calculateTextBounds:text withFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@Neue", FONT_BASENAME] size:18.0]];
    CGSize size = [self calculateTextSize:text];
    return CGRectMake(0, 0, size.width, size.height);
}

/**
 * Calculates the bounds of the text
 */
+ (CGRect)calculateTextBounds:(NSString *)text withFont:(UIFont *)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(212, 2000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    CGSize size = [MessageCell calculateTextSize:text];
    NSLog(@"Bounds: %.2f, %.2f, Size: %.2f, %.2f", rect.size.width, rect.size.height, size.width, size.height);
    return rect;
}

+ (CGSize)calculateTextSize:(NSString *)text
{
    //    UITextView *textView = [[UITextView alloc] init];
    //    [textView setText:text];
    //    [textView setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@Neue", FONT_BASENAME] size:18.0]];
    //    return textView.contentSize;
    
    // Initialize a rectangular path.
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect bounds = CGRectMake(0, 0.0, 212.0, 600.0);
//    CGPathAddRect(path, NULL, bounds);
    
    UIFont *font = [UIFont fontWithName:[NSString stringWithFormat:@"%@Neue", FONT_BASENAME] size:18.0];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attributedString);
    CFRange fitRange = CFRangeMake(0, 0);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, CFStringGetLength((CFStringRef)attributedString)), NULL, CGSizeMake(212, CGFLOAT_MAX), &fitRange);

    
    return fitSize;
}


@end
