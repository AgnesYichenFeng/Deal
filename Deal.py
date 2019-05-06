import json
from flask import Flask, request
from Deal_db import db, Post, Comment, User

app = Flask(__name__)
db_filename = 'todo.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()
    # user1 = User(googleID = "hhhhh", userName="Joyce", personalInformation="genius", profileImage = '')
    # user2 = User(googleID = 'xswl', userName="Elephant", personalInformation="stupid", profileImage = '')
    # # post1 = Post(itemname="1984", itemtype="book", price=100.0, description="A nice book", item_condition="like new", username="Xiangyi", user_id=1)
    # # post2 = Post(itemname="banana", itemtype="food", price=5.0, description="A nice banana", item_condition="like new", username="Xiangyi", user_id=1)
    # db.session.add(user1)
    # db.session.add(user2)
    # # db.session.add(post1)
    # # db.session.add(post2)
    # db.session.commit()

@app.route('/')
@app.route('/api/users/')
def get_users():
    users = User.query.all()
    res = {'success':True, 'data':[user.serialize() for user in users]}
    return json.dumps(res), 200

@app.route('/api/user/<string:user_id>/')
def get_user(user_id):
    user = User.query.filter_by(googleID=user_id).first()
    if user is not None:
        return json.dumps({'success':True, 'data':user.serialize()}), 200
    return json.dumps({'success':False, 'error':'User not found'}), 404

@app.route('/api/user/<string:user_id>/', methods = ['POST'])
def create_user(user_id):
    post_body = json.loads(request.data)
    user = User.query.filter_by(googleID=user_id).first()
    if user is None:
        user = User(
            score = 0,
            googleID = user_id,
            netid = post_body.get('netid'),
            userName = post_body.get('userName'),
            personalInformation = post_body.get('personalInformation'),
            profileImage = post_body.get('profileImage')
        )
        db.session.add(user)
        db.session.commit()
        return json.dumps({'success':True, 'data':user.serialize()}), 201
    return json.dumps({'success':True, 'data':'User has already existed'}), 200

@app.route('/api/user/update/<string:user_id>/', methods = ['POST'])
def update_user(user_id):
    user = User.query.filter_by(googleID = user_id).first()
    if user is not None:
        post_body = json.loads(request.data)
        user.userName = post_body.get('userName', user.userName)
        user.personalInformation = post_body.get('personalInformation', user.personalInformation)
        user.profileImage = post_body.get('profileImage', user.profileImage)
        db.session.commit()
        return json.dumps({'success':True, 'data':user.serialize()}), 200
    return json.dumps({'success':False, 'error':'User not found'}), 404

@app.route('/api/posts/')
def get_posts():
    posts = Post.query.all()
    res = {'success':True, 'data':[post.serialize() for post in posts]}
    return json.dumps(res), 200

@app.route('/api/user/post/<string:user_id>/', methods = ['POST'])
def create_post(user_id):
    user = User.query.filter_by(googleID=user_id).first()
    if user is not None:
        post_body = json.loads(request.data)
        post = Post(
            score = 0,
            itemName = post_body.get("itemName"),
            itemtype = post_body.get("itemtype"),
            itemPrice = post_body.get("itemPrice"),
            descriptionText = post_body.get("descriptionText"),
            item_condition = post_body.get("item_condition"),
            itemImage1 = post_body.get("itemImage1"),
            itemImage2 = post_body.get("itemImage2"),
            itemImage3 = post_body.get("itemImage3"),
            itemImage4 = post_body.get("itemImage4"),
            itemImage5 = post_body.get("itemImage5"),
            itemImage6 = post_body.get("itemImage6"),
            userName = user.userName,
            userGoogleId = user.googleID
        )
        user.posts.append(post)
        db.session.add(post)
        db.session.commit()
        return json.dumps({'success':True, 'data':post.serialize()}), 201
    return json.dumps({'success':False, 'error':'User not found'}), 404

@app.route('/api/post/<int:post_id>/')
def get_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        return json.dumps({'success':True, 'data':post.serialize()}), 200
    return json.dumps({'success':False, 'error':'Post not found'}), 404

@app.route('/api/posts/<string:user_id>/')
def get_user_posts(user_id):
    user = User.query.filter_by(googleID = user_id).first()
    if user is not None:
        return json.dumps({'success':True, 'data':[post.serialize() for post in user.posts]}), 200
    return json.dumps({'success':False, 'error':'User not found'})
        
@app.route('/api/post/<int:post_id>/', methods = ['POST'])
def update_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        post_body = json.loads(request.data)
        post.itemName = post_body.get('itemName', post.itemName)
        post.itemtype = post_body.get('itemtype', post.itemtype)
        post.itemPrice = post_body.get('itemPrice', post.itemPrice)
        post.descriptionText = post_body.get('descriptionText', post.descriptionText)
        post.item_condition = post_body.get('item_condition', post.item_condition)
        post.itemImage1 = post_body.get('itemImage1', post.itemImage1)
        post.itemImage2 = post_body.get('itemImage2', post.itemImage2)
        post.itemImage3 = post_body.get('itemImage3', post.itemImage3)
        post.itemImage4 = post_body.get('itemImage4', post.itemImage4)
        post.itemImage5 = post_body.get('itemImage5', post.itemImage5)
        post.itemImage6 = post_body.get('itemImage6', post.itemImage6)
        db.session.commit()
        return json.dumps({'success':True, 'data':post.serialize()}), 200
    return json.dumps({'success':False, 'error':'Post not found'}), 404

@app.route('/api/favouritePosts/<string:user_id>/<int:post_id>/', methods=['POST'])
def like(user_id, post_id):
    user = User.query.filter_by(googleID=user_id).first()
    post = Post.query.filter_by(id=post_id).first()
    if user is None or post is None:
        return json.dumps({'success': False, 'error': 'Post or User not found'}), 404
    post.likedUsers.append(user)
    user.likedPosts.append(post)
    db.session.commit()
    return json.dumps({'success': True, 'data': user.serialize2()}), 200

@app.route('/api/removeFavouritePosts/<string:user_id>/<int:post_id>/', methods=['POST'])
def dislike(user_id, post_id):
    user = User.query.filter_by(googleID=user_id).first()
    post = Post.query.filter_by(id=post_id).first()
    if user is None or post is None:
        return json.dumps({'success': False, 'error': 'Post or User not found'}), 404
    post.likedUsers.remove(user)
    user.likedPosts.remove(post)
    db.session.commit()
    return json.dumps({'success': True, 'data': user.serialize2()}), 200

@app.route('/api/favouritePosts/<string:user_id>/')
def get_likedPosts(user_id):
    user = User.query.filter_by(googleID = user_id).first()
    if user is not None:
        return json.dumps({'success':True, 'data':[post.serialize() for post in user.likedPosts]}), 200
    return json.dumps({'success':False, 'error':'User not found'})

@app.route('/api/post/<int:post_id>/', methods = ['DELETE'])
def delete_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        db.session.delete(post)
        db.session.commit()
        return json.dumps({'success':True, 'data':post.serialize()}), 200
    return json.dumps({'success':False, 'error':'Post not found'}), 404

@app.route('/api/post/<int:post_id>/comments/')
def get_comments(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        comments = [comment.serialize() for comment in post.comments]
        return json.dumps({'success':True, 'data':comments}), 200
    return json.dumps({'success':False, 'error':'Post not found'}), 404          

@app.route('/api/post/<string:user_id>/<int:post_id>/comment/', methods = ['POST'])
def create_comment(post_id, user_id):
    user = User.query.filter_by(googleID=user_id).first()
    if user is not None:
        post = Post.query.filter_by(id=post_id).first()
        if post is not None:
            post_body = json.loads(request.data)
            comment = Comment(
                score = 0,
                message = post_body.get('message'),
                userName = user.userName,
                post_id = post.id
            )
            post.comments.append(comment)
            user.comments.append(comment)
            db.session.add(comment)
            db.session.commit()
            return json.dumps({'success':True, 'data':comment.serialize()}), 201
        return json.dumps({'success':False, 'error':'Post not found'}), 404
    return json.dumps({'success':False, 'error':'User not found'}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)