# Deal
Created by: <i>Yichen Feng (iOS), Nina Xie (iOS), Joyce Huang (Backend), Xiangyi Zhao (Backend)</i>

<strong> A buying and selling app designed for the Cornell community </strong> 

<p>Deal helps Cornell students to sell their used items that are not needed anymore as well as buy used items from others with cheaper prices. </p>

<p>The users first start with signing in with their Google accounts. After loading, they can view all items that are currently on the platform on the "Deal" explore page. Through the search bar, they can search for a specific keyword in items' names or descriptions. 
Clicking into a specific item cell, they can view more information of it, including the item name, price, description and images, on its Detail View. They can scroll the description text vertically to see the full length, and can scroll the image collection view horizontally to see all images (up to 6). 
Tabbing on the seller button, they can go into the seller's profile page and see seller information. 
Back on the item's detail view, through the tool bar on the bottom, one can add the item to "My Favorites" or view and leave comments. </p>

<p>The users can navigate to their own profile page to change the profile picutre and user information. They can also view their favorited and on sale items.</p>

<p>Users can post their own items to the platform through the add feature. Later if an item is sold or the seller wants to delete it, the seller will be able to remove that on its detail page. </p>

<p>Deal does not yet accomplish all of our envisioned features such as sending system notifications to users and message chatting between buyers and sellers. We would love to further work on Deal to actually bring it to our campus in the future.


### Login Process
<img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/GID%20Sign%20In.png" width = "207" height = "447.5"> <img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/GID%20SignIn2.png" width = "207" height = "447.5">

### User Profile Page (Favorites and OnSale)
<img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Editing%20Profile%20Page.png" width = "207" height = "447.5"> <img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/User%20Profile.png" width = "207" height = "447.5"> <img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/My%20Favorite%20(User%20Profile).png" width = "207" height = "447.5">

### Home Screen: Items Display, Search Bar
<img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Home%20Screen.png" width = "207" height = "447.5"> <img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Search%20Bar.png" width = "207" height = "447.5">

### Detail Screen: Item Info, Seller Page/Like/Comment
<img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Item%20Detail%20Info.png" width = "207" height = "447.5"> <img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Comments.png" width = "207" height = "447.5">

### Post Screen: Post New Item
<img src = "https://github.com/Nina-Xie/Deal-v1/blob/master/Post%20New%20Item.png" width = "207" height = "447.5">


### iOS:
NSLayoutConstraint - used to place views as designed, and fit various screen dimensions.

GoogleSignIn API - implemented to get information of the user that is currently signed in.

UITabBarController - displayed at bottom of main ViewControllers with icons for each screen, and ability to navigate between screens. User is brought to their desired page upon click of an icon.

UICollectionView - implemented in DealVC for items and DetailVC for images. 
UITableView - implements in CommentVC for comments.

UIImagePickerController - integrated for the user to upload item images and profile picture.


### Backend:

&#10141; [Deal Spec](https://paper.dropbox.com/doc/Deal-Spec--AcljVfAX9t6dh07~Kl4dfoswAg-aiS3qX6kGyQ0M5LaVBitn)

## Authors:
&#10141; [Yichen Feng](https://github.com/AgnesYichenFeng)
&#10141; [Nina Xie](https://github.com/Nina-Xie)
&#10141; [Joyce Huang](https://github.com/JoyceHuangEC)
&#10141; [Xiangyi Zhao](https://github.com/XiangyiZhao)

©2019 by Fx&Hz

