//PART 2- NoSQL
//Q2.2- MONGODB OPERATIONS
//======================

db = db.getSiblingDB("ecommerce")
db.products.drop()
print("Old collection dropped")
print("MongoDB script running")

//------------------------
// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
     {
        "product_id": "E0001",
        "name": "Sony Bravia 55 inch 4K TV",
        "category": "Electronics",
        "brand":"Sony",
        "price": 72000,

        "attributes":{
            "screen_size": "55 inch",
            "resolution":"4K UHD",
            "smart_tv":true,
            "ports":["HDMI","USB","Bluetooth"],
            "voltage": "220V"
        },
        "warranty":{
            "period":"2 years",
            "type":"manufacturer"
           }   
        },
        {
            "product_id":"C2002",
            "name":"Nike Running T-shirt",
            "category":"Clothing",
            "brand": "Nike",
            "price":1999,

            "attributes":{
            "fabric":"polyester",
            "fit":"regular",
            "sizes":["S","M","L","XL"],
            "colors":["black","white","blue"]
          },
           "care_instructions":[
            "machine wash",
            "do not bleach",
            "dry in shade"
           ]
        },
         
        {   "product_id":"G3001",
             "name":"Organic Honey 500g",
             "category":"Groceries",
             "brand":"Nature Pure",
             "price":450,
             "expiry_date":new Date("2024-12-30"),
            
             "attributes":{
             "weight": "500g",
             "organic":true
          },
         "nutrition": {
         "calories":304,
         "sugar":"82g",
         "carbs":"82g"
    
          }    
        }
         
]);
print("Documents inserted successfully.");

// OP2: find() — retrieve all Electronics products with price > 20000
var electronics = db.products.find({
    category:"Electronics",
    price:{$gt:20000}}).toArray();
    print("\nElectronics products with price > 20000:");    
    printjson(electronics);

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
var groceries = db.products.find({
    category:"Groceries",
    expiry_date:{$lt:new Date("2025-01-01")}}) .toArray();
    print("\nGroceries expiring before 2025-01-01:");
    printjson(groceries);
// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
    {product_id:"E0001"},
    {$set:{ discount_percent:10}}
);
print("\n Discount_percent field added to product E0001:");
printjson(db.products.find({product_id : "E0001"}).toArray());

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({category:1});
print("\nIndexes on product collection:");
printjson(db.products.getIndexes());
