from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

like_association_table = db.Table(
    'like',
    db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('post_id', db.Integer, db.ForeignKey('user.id'))
)

class User(db.Model):
    __tablename__='user'
    id = db.Column(db.Integer, primary_key = True)
    googleID = db.Column(db.String, nullable = False)
    netid = db.Column(db.String)
    userName = db.Column(db.String, nullable = False)
    personalInformation = db.Column(db.String, nullable = True)
    profileImage = db.Column(db.String)
    posts = db.relationship('Post', cascade = 'delete')
    comments = db.relationship('Comment', cascade = 'delete')
    likedPosts = db.relationship('Post', secondary=like_association_table)

    def __init__(self, **kwargs):
        self.netid = kwargs.get('netid', '')
        self.googleID = kwargs.get('googleID', '')
        self.userName = kwargs.get('userName', '')
        self.personalInformation = kwargs.get('personalInformation', '')
        self.profileImage = kwargs.get('profileImage', '')
        self.posts = []
        self.comments = []
        self.likedPosts = []

    def serialize(self):
        return {
            'id': self.id,
            'googleID': self.googleID,
            'netid': self.netid,
            # 'onsale': [a.serialize() for a in self.onsale],
            # 'sold': [a.serialize() for a in self.sold],
            'userName': self.userName,
            'personalInformation': self.personalInformation,
            'profileImage': self.profileImage,
            'posts':[a.serialize() for a in self.posts],
            'comments': [a.serialize() for a in self.comments]
        }

    def serialize2(self):
        return {
            'likedPosts': [a.serialize2() for a in self.likedPosts]
        }

class Post(db.Model):
    __tablename__='post'
    id = db.Column(db.Integer, primary_key = True)
    score = db.Column(db.Integer, nullable = False)
    itemName = db.Column(db.String, nullable = False)
    itemtype = db.Column(db.String)
    itemPrice = db.Column(db.Float, nullable = False)
    descriptionText = db.Column(db.String, nullable = False)
    item_condition = db.Column(db.String)
    # images = db.Column(db.PickleType, nullable = False)
    userName = db.Column(db.String, nullable = False)
    itemImage1 = db.Column(db.String)
    itemImage2 = db.Column(db.String)
    itemImage3 = db.Column(db.String)
    itemImage4 = db.Column(db.String)
    itemImage5 = db.Column(db.String)
    itemImage6 = db.Column(db.String)
    comments = db.relationship('Comment', cascade ='delete')
    userGoogleId = db.Column(db.String, db.ForeignKey('user.googleID'), nullable = False)
    likedUsers = db.relationship('User', secondary=like_association_table)

    def __init__(self, **kwargs):
        self.score = kwargs.get('score', 0)
        self.itemName = kwargs.get('itemName','Mysterious item')
        self.itemtype = kwargs.get('itemtype', 'Others')
        self.itemPrice = kwargs.get('itemPrice', 0.0)
        self.descriptionText = kwargs.get('descriptionText', 'N/A')
        self.item_condition = kwargs.get('item_condition', 'N/A')
        # self.images = []
        self.userName = kwargs.get('userName', 'Anonymous user')
        self.itemImage1 = kwargs.get('itemImage1', '')
        self.itemImage2 = kwargs.get('itemImage2', '')
        self.itemImage3 = kwargs.get('itemImage3', '')
        self.itemImage4 = kwargs.get('itemImage4', '')    
        self.itemImage5 = kwargs.get('itemImage5', '')  
        self.itemImage6 = kwargs.get('itemImage6', '')                  
        self.userGoogleId = kwargs.get('user.googleID', '')
        self.comments = []
        self.likedUsers = []

    def serialize(self):
        return {
            'id': self.id,
            'googleID': self.userGoogleId,
            'score': self.score,
            'itemName': self.itemName,
            'itemtype': self.itemtype,
            'itemPrice': self.itemPrice,
            'descriptionText': self.descriptionText,
            'item_condition': self.item_condition,
            # 'images' : [a.serialize() for a in self.images],
            'userName': self.userName,
            'itemImage1': self.itemImage1,
            'itemImage2': self.itemImage2,
            'itemImage3': self.itemImage3,
            'itemImage4': self.itemImage4,
            'itemImage5': self.itemImage5,
            'itemImage6': self.itemImage6,
            'comments': [a.serialize() for a in self.comments]
        }

    def serialize2(self):
        return{
            'id':self.id
        }

class Comment(db.Model):
    __tablename__='comment'
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Integer, nullable = False)
    message = db.Column(db.String, nullable = False)
    userName = db.Column(db.String, nullable = False)
    post_id = db.Column(db.Integer, db.ForeignKey('post.id'), nullable = False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable = False)

    def __init__(self, **kwargs):
        self.score = kwargs.get('score', 0)
        self.message = kwargs.get('message', '')
        self.userName = kwargs.get('userName','')
        self.post_id = kwargs.get('post_id')
        self.user_id = kwargs.get('user_id')

    def serialize(self):
        return {
            'id': self.id,
            'score': self.score,
            #'text': self.text,
            'message': self.message,
            'userName': self.userName
        }