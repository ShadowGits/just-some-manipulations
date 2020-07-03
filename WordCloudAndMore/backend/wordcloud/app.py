from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os
from email.policy import strict
from getWordcloud import text_to_wordcloud
#Init app
app=Flask(__name__)

basedir=os.path.abspath(os.path.dirname(__file__))

#database
app.config['SQLALCHEMY_DATABASE_URI']='sqlite:///' + os.path.join(basedir,'db.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

#init db
db=SQLAlchemy(app)

#init marshmallow
ma=Marshmallow(app)

#Product Class/Model
class Product(db.Model):
    id=db.Column(db.Integer, primary_key=True)
    name=db.Column(db.String(100),unique=True)
    description=db.Column(db.String(200))
    price=db.Column(db.Float)
    qty=db.Column(db.Integer)
    
    def __init__(self,name,description,price,qty):
        self.name=name
        self.description=description
        self.price=price
        self.qty=qty

    
    
#Product Schema
class ProductSchema(ma.Schema):
    class Meta:
        #what fields to show go here
        fields=('id','name','description','price','qty')
        
#init schema
product_schema=ProductSchema(strict=True)
products_schema=ProductSchema(strict=True,many=True)



#Create product

@app.route('/product',methods=['POST'])
def add_product():
    name=request.json['name']
    description=request.json['description']

    price=request.json['price'] 
    qty=request.json['qty'] 
    
    product=Product(name,description,price,qty) 

    db.session.add(product)
    db.session.commit()
    
    return product_schema.jsonify(product)     

#GET ALL PRODUCTS
@app.route("/product",methods=["GET"])
def get_all_products():
    all_products=Product.query.all()
    result=products_schema.dump(all_products)
    
    return jsonify(result.data)




#GET SINGLE PRODUCT
@app.route("/product/<id>",methods=["GET"])
def get_product(id):
    product=Product.query.get(id)
    
    return product_schema.jsonify(product)

#UPDATE PRODUCT
@app.route("/product/<id>",methods=["PUT"])
def update_product(id):
    product=Product.query.get(id)
    
    name=request.json['name']
    description=request.json['description']

    price=request.json['price'] 
    qty=request.json['qty'] 
    
    product.name=name
    product.description=description
    product.price=price
    product.qty=qty
    
    db.session.commit()
    
    
    return product_schema.jsonify(product)


#DELETE PRODUCT
@app.route("/product/<id>",methods=["DELETE"])
def delete_product(id):
    product=Product.query.get(id)
    db.session.delete(product)
    db.session.commit()
    return product_schema.jsonify(product)

    


#GET IMAGE STRING
@app.route("/Image",methods=["GET"])
def get_image_string():

    string_tuple=text_to_wordcloud("")
    return jsonify({"image_string":string_tuple[0],
                    "image_string_invert":string_tuple[1]})



#Customised IMAGE STRING
@app.route("/Image",methods=["POST"])
def get_text_image_string():

    text=request.json['input_text']
    print(text)
    string_tuple=text_to_wordcloud(text)
    return jsonify({"image_string":string_tuple[0],
                    "image_string_invert":string_tuple[1]})


#Run Server
if __name__=="__main__":
    app.run(debug=True)
    
