# KeyCraft E-commerce Platform Use Cases

## Overview
This document outlines all possible use cases for the KeyCraft E-commerce platform, a specialized online store for mechanical keyboards and related services. The use cases are organized by actor/user role.

## Actors
1. **Guest** - Unauthenticated visitor
2. **Customer** - Registered and authenticated user
3. **Admin** - System administrator with elevated privileges

## Use Cases by Actor

### Guest Use Cases

#### UC-G1: Browse Products
**Description:** Guest can view and browse products in the store.
**Primary Actor:** Guest
**Preconditions:** None
**Main Flow:**
1. Guest navigates to the website
2. System displays featured products on the homepage
3. Guest can browse products by category, brand, or other filters
4. Guest can search for specific products
5. Guest can view detailed product information

#### UC-G2: Register Account
**Description:** Guest can create a new account.
**Primary Actor:** Guest
**Preconditions:** Guest is not logged in
**Main Flow:**
1. Guest selects "Sign Up" option
2. System displays registration form
3. Guest enters email, password, first name, and last name
4. System validates the information
5. System creates the account and sends verification email
6. Guest receives verification code
7. Guest enters verification code
8. System verifies the account

#### UC-G3: Login
**Description:** Guest can log in to an existing account.
**Primary Actor:** Guest
**Preconditions:** Guest has a registered account
**Main Flow:**
1. Guest selects "Login" option
2. System displays login form
3. Guest enters email and password
4. System validates credentials
5. System logs the user in and redirects to appropriate page based on role

### Customer Use Cases

#### UC-C1: Manage Account
**Description:** Customer can view and update account information.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in
**Main Flow:**
1. Customer navigates to account settings
2. System displays current account information
3. Customer can update personal information
4. System saves changes

#### UC-C2: Add Product to Cart
**Description:** Customer can add products to their shopping cart.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in
**Main Flow:**
1. Customer browses products
2. Customer selects "Add to Cart" for a product
3. System adds the product to the customer's cart
4. System confirms the addition

#### UC-C3: View Cart
**Description:** Customer can view the contents of their shopping cart.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in
**Main Flow:**
1. Customer selects "Cart" option
2. System displays cart contents including products, quantities, and total price

#### UC-C4: Update Cart
**Description:** Customer can update quantities or remove items from cart.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in and has items in cart
**Main Flow:**
1. Customer views cart
2. Customer updates quantity of an item or removes an item
3. System updates the cart and recalculates total

#### UC-C5: Checkout
**Description:** Customer can complete purchase of items in cart.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in and has items in cart
**Main Flow:**
1. Customer initiates checkout process
2. System displays checkout form
3. Customer enters shipping information and selects payment method
4. Customer confirms order
5. System processes the order and creates an order record
6. System displays order confirmation

#### UC-C6: View Orders
**Description:** Customer can view their order history.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in
**Main Flow:**
1. Customer navigates to orders section
2. System displays list of customer's orders with basic information

#### UC-C7: View Order Details
**Description:** Customer can view detailed information about a specific order.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in and has placed orders
**Main Flow:**
1. Customer selects a specific order from order history
2. System displays detailed order information including items, quantities, prices, status, and shipping information

#### UC-C8: Book a Service
**Description:** Customer can book keyboard-related services.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in
**Main Flow:**
1. Customer navigates to services section
2. Customer selects service type (custom build, cleaning, or repair)
3. Customer provides service details and contact information
4. System creates service booking
5. System confirms booking

#### UC-C9: Track Service Booking
**Description:** Customer can check the status of their service bookings.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in and has booked services
**Main Flow:**
1. Customer navigates to service bookings section
2. System displays list of customer's service bookings with status information

#### UC-C10: Write Product Review
**Description:** Customer can write reviews for purchased products.
**Primary Actor:** Customer
**Preconditions:** Customer is logged in and has purchased the product
**Main Flow:**
1. Customer navigates to a product they've purchased
2. Customer selects "Write Review" option
3. Customer enters rating and review text
4. System saves the review

### Admin Use Cases

#### UC-A1: Manage Products
**Description:** Admin can add, update, or remove products.
**Primary Actor:** Admin
**Preconditions:** Admin is logged in
**Main Flow:**
1. Admin navigates to product management section
2. Admin can view all products
3. Admin can add new products with details (name, description, price, etc.)
4. Admin can update existing product information
5. Admin can mark products as discontinued or delete them

#### UC-A2: Manage Orders
**Description:** Admin can view and update order status.
**Primary Actor:** Admin
**Preconditions:** Admin is logged in
**Main Flow:**
1. Admin navigates to order management section
2. Admin can view all orders
3. Admin can update order status (confirm, ship, deliver, cancel)
4. Admin can add tracking information to orders

#### UC-A3: Manage Service Bookings
**Description:** Admin can view and update service booking status.
**Primary Actor:** Admin
**Preconditions:** Admin is logged in
**Main Flow:**
1. Admin navigates to service booking management section
2. Admin can view all service bookings
3. Admin can update service status (confirm, mark as in progress, complete, cancel)
4. Admin can add estimated price for services

#### UC-A4: View Dashboard
**Description:** Admin can view system statistics and metrics.
**Primary Actor:** Admin
**Preconditions:** Admin is logged in
**Main Flow:**
1. Admin navigates to dashboard
2. System displays key metrics (sales, popular products, etc.)

## Use Case Specifications

### UC-G2: Register Account

**Use Case ID:** UC-G2
**Use Case Name:** Register Account
**Created By:** System Analyst
**Last Updated By:** System Analyst

**Actors:** Guest
**Description:** Guest creates a new user account in the system
**Trigger:** Guest clicks on "Sign Up" button
**Preconditions:** Guest is not logged in

**Normal Flow:**
1. Guest clicks on "Sign Up" button
2. System displays registration form
3. Guest enters email, password, first name, and last name
4. Guest submits the form
5. System validates the information
6. System creates the account and sends verification email
7. System redirects to verification page
8. Guest receives verification code via email
9. Guest enters verification code on verification page
10. System verifies the account
11. System displays success message
12. System redirects to login page

**Alternative Flows:**
- A1: Invalid Information
  1. At step 5, if information is invalid, system displays error message
  2. Guest corrects information and resubmits
  3. Continue at step 5

- A2: Email Already Registered
  1. At step 5, if email is already registered, system displays error message
  2. Guest enters different email or navigates to login page
  3. Use case ends

- A3: Invalid Verification Code
  1. At step 10, if verification code is invalid, system displays error message
  2. Guest re-enters code or requests new code
  3. Continue at step 10

**Postconditions:** 
- Guest has a registered account
- Account is verified
- Guest can log in

**Business Rules:**
- Email must be unique
- Password must meet security requirements
- Verification code expires after 24 hours

### UC-C5: Checkout

**Use Case ID:** UC-C5
**Use Case Name:** Checkout
**Created By:** System Analyst
**Last Updated By:** System Analyst

**Actors:** Customer
**Description:** Customer completes purchase of items in cart
**Trigger:** Customer clicks "Proceed to Checkout" button
**Preconditions:** 
- Customer is logged in
- Customer has items in cart

**Normal Flow:**
1. Customer clicks "Proceed to Checkout" button
2. System displays checkout form
3. Customer enters shipping information (name, address, city, state, zip)
4. Customer selects payment method
5. System displays order summary with items, quantities, and total price
6. Customer confirms order
7. System validates all information
8. System creates order record
9. System clears customer's cart
10. System displays order confirmation with order ID
11. System redirects to order details page

**Alternative Flows:**
- A1: Missing Required Information
  1. At step 7, if required information is missing, system displays error message
  2. Customer provides missing information
  3. Continue at step 7

- A2: Payment Processing Error
  1. At step 8, if payment processing fails, system displays error message
  2. Customer selects different payment method or tries again
  3. Continue at step 8

- A3: Insufficient Stock
  1. At step 7, if product stock is insufficient, system displays error message
  2. Customer can update quantities or remove items
  3. Continue at step 5

**Postconditions:** 
- Order is created in the system
- Customer's cart is empty
- Customer can view order in order history

**Business Rules:**
- All required shipping information must be provided
- Product stock must be sufficient for order
- Order total must be calculated correctly including any applicable taxes or shipping fees

### UC-A3: Manage Service Bookings

**Use Case ID:** UC-A3
**Use Case Name:** Manage Service Bookings
**Created By:** System Analyst
**Last Updated By:** System Analyst

**Actors:** Admin
**Description:** Admin manages service booking requests
**Trigger:** Admin navigates to service booking management section
**Preconditions:** Admin is logged in

**Normal Flow:**
1. Admin navigates to service booking management section
2. System displays list of all service bookings with status information
3. Admin selects a specific booking
4. System displays detailed booking information
5. Admin updates booking status (confirm, mark as in progress, complete, cancel)
6. Admin adds estimated price for service
7. System saves changes
8. System notifies customer of status change via email

**Alternative Flows:**
- A1: Filter Bookings
  1. At step 2, admin can filter bookings by status, service type, or date
  2. System displays filtered results
  3. Continue at step 3

- A2: Add Notes
  1. At step 5, admin can add internal notes about the service
  2. System saves notes with the booking
  3. Continue at step 6

**Postconditions:** 
- Service booking status is updated
- Customer is notified of changes

**Business Rules:**
- Only admins can update service booking status
- Customers must be notified of status changes
- Estimated price can be updated until service is completed

### UC-C8: Book a Service

**Use Case ID:** UC-C8
**Use Case Name:** Book a Service
**Created By:** System Analyst
**Last Updated By:** System Analyst

**Actors:** Customer
**Description:** Customer books a keyboard-related service
**Trigger:** Customer navigates to service booking section
**Preconditions:** Customer is logged in

**Normal Flow:**
1. Customer navigates to services section
2. System displays available service types (custom build, cleaning, repair)
3. Customer selects desired service type
4. System displays service booking form
5. Customer enters service details and requirements in description
6. Customer provides contact information (email, phone)
7. Customer submits the booking request
8. System validates the information
9. System creates service booking with PENDING status
10. System displays booking confirmation with booking ID
11. System sends confirmation email to customer

**Alternative Flows:**
- A1: Missing Required Information
  1. At step 8, if required information is missing, system displays error message
  2. Customer provides missing information
  3. Continue at step 8

- A2: Service Unavailable
  1. At step 3, if selected service is temporarily unavailable, system displays notice
  2. Customer selects different service or cancels booking
  3. Use case continues or ends accordingly

**Postconditions:** 
- Service booking is created in the system
- Customer receives confirmation
- Admin is notified of new service booking

**Business Rules:**
- Service type must be selected
- Contact information must be provided
- Description of service requirements must be provided
- Initial service status is always set to PENDING

### UC-A1: Manage Products

**Use Case ID:** UC-A1
**Use Case Name:** Manage Products
**Created By:** System Analyst
**Last Updated By:** System Analyst

**Actors:** Admin
**Description:** Admin manages product catalog (add, update, remove products)
**Trigger:** Admin navigates to product management section
**Preconditions:** Admin is logged in

**Normal Flow:**
1. Admin navigates to product management section
2. System displays list of all products with basic information (name, price, stock, status)
3. Admin can filter or search products by various criteria
4. Admin selects to add a new product
5. System displays product creation form
6. Admin enters product details (name, description, price, category, brand, switch type, layout, stock, image)
7. Admin submits the form
8. System validates the information
9. System creates the new product
10. System displays success message and returns to product list with the new product visible

**Alternative Flows:**
- A1: Update Existing Product
  1. At step 4, admin selects an existing product to edit
  2. System displays product edit form with current values
  3. Admin updates desired fields
  4. Admin submits the form
  5. System validates and saves changes
  6. System displays success message and returns to product list

- A2: Discontinue Product
  1. At step 4, admin selects to discontinue a product
  2. System prompts for confirmation
  3. Admin confirms discontinuation
  4. System marks product as discontinued but retains it in the database
  5. System displays success message and returns to product list

- A3: Delete Product
  1. At step 4, admin selects to delete a product
  2. System checks if product is used in any orders
  3. If product is used in orders, system suggests discontinuing instead
  4. If product is not used in orders, system prompts for confirmation
  5. Admin confirms deletion
  6. System removes product from database
  7. System displays success message and returns to product list

- A4: Invalid Information
  1. At step 8, if information is invalid, system displays error message
  2. Admin corrects information and resubmits
  3. Continue at step 8

**Postconditions:** 
- Product catalog is updated
- Changes are immediately visible to customers

**Business Rules:**
- Product name, price, and category are required
- Price must be a positive number
- Stock must be a non-negative integer
- Products used in existing orders cannot be deleted (only discontinued)
- Admin must have appropriate permissions to manage products

## Use Case Diagram Description

A complete use case diagram for the KeyCraft E-commerce Platform would include the following elements:

### Actors
- Guest (unauthenticated user)
- Customer (authenticated regular user)
- Admin (authenticated administrator)

### Use Case Relationships

**Guest Use Cases:**
- Browse Products
- Register Account
- Login

**Customer Use Cases:**
- Manage Account
- Add Product to Cart
- View Cart
- Update Cart
- Checkout
- View Orders
- View Order Details
- Book a Service
- Track Service Booking
- Write Product Review
- (Inherits all Guest use cases except Register and Login)

**Admin Use Cases:**
- Manage Products
- Manage Orders
- Manage Service Bookings
- View Dashboard
- (Inherits all Customer use cases)

### Relationships
- "Register Account" extends to "Verify Email"
- "Checkout" includes "Process Payment"
- "Manage Products" includes "Add Product", "Update Product", "Discontinue Product", and "Delete Product"
- "Manage Orders" includes "Update Order Status" and "Add Tracking Information"
- "Manage Service Bookings" includes "Update Service Status" and "Set Price Estimate"

This diagram would visually represent all the actors and their relationships to the various use cases in the system, providing a comprehensive overview of the system's functionality from a user perspective.

## Conclusion and Next Steps

This document has identified and described all possible use cases for the KeyCraft E-commerce Platform, a specialized online store for mechanical keyboards and related services. The use cases cover the full range of functionality required by the different types of users (Guests, Customers, and Admins) who will interact with the system.

### Summary of Use Cases
- **Guest Use Cases (3)**: Focus on browsing products and authentication
- **Customer Use Cases (10)**: Cover the complete shopping experience from browsing to checkout, order tracking, and service booking
- **Admin Use Cases (4)**: Provide administrative capabilities for managing products, orders, and services

### How to Use This Document
1. **For Requirements Validation**: Ensure all stakeholder needs are captured in the use cases
2. **For System Design**: Use as a basis for designing user interfaces and system components
3. **For Testing**: Develop test cases based on the normal and alternative flows
4. **For Documentation**: Create user manuals and help content based on the use case flows

### Recommended Next Steps
1. **Prioritize Use Cases**: Determine which use cases are most critical for initial implementation
2. **Create UI Mockups**: Design user interfaces for each use case
3. **Develop Sequence Diagrams**: Detail the interactions between system components for each use case
4. **Refine Data Models**: Ensure the data model supports all use case requirements
5. **Implement and Test**: Develop and test the system based on these use cases

By following these use cases, the development team can ensure that the KeyCraft E-commerce Platform meets all user requirements and provides a comprehensive, user-friendly experience for all types of users.
