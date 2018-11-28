//
//  AddContactViewController.m
//  SocialEmail
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Connect picker data
    self.groupPicker.dataSource = self;
    self.groupPicker.delegate = self;
    
}

#pragma mark - Picker
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.groups.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.groups[row] name];
}

#pragma mark - Image Picker
// Image picker delegate
- (IBAction)selectImage:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Performs logic and closes the image picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    // Set chosen image to be the button's background
    self.imageButton.backgroundColor = [UIColor colorWithPatternImage: chosenImage];
    
    // Sets aside image to be returned / saved later
    self.contactImage = chosenImage;
    
    // Dismisses image picker view
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cancel:(id)sender {
}

- (IBAction)save:(id)sender {
    
    Contact *contact = [[Contact alloc] init];
    contact.name = self.nameTextField.text;
    contact.date = [NSDate date];
    contact.image = _contactImage;
    Group *group = self.groups[ [self.groupPicker selectedRowInComponent:0] ];
    
    [self.delegate addContactViewController:self didAddContact:contact toGroup:group];
    
}
@end
