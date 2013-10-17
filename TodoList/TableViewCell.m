//
//  TableViewCell.m
//  TodoList
//
//  Created by Jaayden on 10/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TableViewCell.h"

@implementation TableViewCell

CAGradientLayer* _gradientLayer;
CGPoint _originalCenter;
BOOL _deleteOnDragRelease;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.showsReorderControl = YES;
        
        CGSize size = self.contentView.frame.size;

        self.mainLabel = [[UITextField alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 16.0)];
        
        self.mainLabel.delegate = self;
        
        //[self.mainLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
        [self.mainLabel setTextAlignment:NSTextAlignmentCenter];
        [self.mainLabel setTextColor:[UIColor blackColor]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self.contentView addSubview:self.mainLabel];
        
        UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];

    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // disable editing of completed to-do items
    return !self.todoItem.completed;
}*/

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.todoItem.text = textField.text;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);

        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        
        if (_deleteOnDragRelease) {
            [self.delegate toDoItemDeleted:self.todoItem];
        }
    }
}
@end
