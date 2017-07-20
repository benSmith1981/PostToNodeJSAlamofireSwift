
const FamilySchema = require('./detail_model'),
date = new Date()

CollectionDriver = function(db) {
  this.db = db;
};
//req.body
//req.query
//req.params
// Create endpoint  to get tree json 
exports.savetree = function(req, res, err) {
      // res.json(req.body)
    //     res.json(req.query)
        // res.json(req.params)
    var response = []
    for (var key in req.body) {
        console.log("key "+key)
        console.log("body "+req.body[key])
        console.log("name "+req.body[key].name)

        var currentHuman = req.body[key]

        var familyTree = new FamilySchema({  
            name: currentHuman.name,
            id: currentHuman.id,
            patientID: currentHuman.patientID
        })

        familyTree.save(function (err, details) {
            if (err) {
                res.json({ err })
                return console.error(err);
            }
            else  {
                response.push(details)
                console.log("name "+req.body[key].name)

                // res.json({ details })
            }
        })

    }

}

exports.addOneHuman = function(req, res, err) {
    var familyTree = new FamilySchema({  
        name: req.body.name,
        id: req.body.id,
        patientID: req.body.patientID
    })

    familyTree.save(function (err, details) {
        if (err) {
            res.json({ err })
            return console.error(err);
        }
        else  {
            res.json({ details })
        }
    })
}

exports.edithuman = function(req, res, err) {

    // var query = {id: req.query.id };
    // // req.newData.username = req.user.username;
    // FamilySchema.findOneAndUpdate(query, req.body, {upsert:true}, function(err, doc){
    //     if (err) return res.send(500, { error: err });
    //     return res.send("succesfully saved");
    // });



    // FamilySchema.findOne({id: req.query.id}, function(err, human) {
    // if(!err) {
    //     if(!human) {
    //         human = new FamilySchema();
    //         human.name = req.name;
    //     }
    //     human.save(function(err) {
    //         if(!err) {
    //             console.log("human " + human.name + " updated at " + Date);
    //         }
    //         else {
    //             console.log("Error: could not save contact " + human.name);
    //         }
    //     });
    // }
    // });


    FamilySchema.update({id: req.query.id }, 
        {$set: req.body }, 
        {upsert: true}, 
        function(err){
            if (err) return res.send(500, { error: err });
            return res.send("succesfully saved");

    })
}

// Create endpoint  to get tree json 
exports.gettree = function(req, res, err) {
    console.log("req.query.patientID "+req.query.patientID)
    FamilySchema.find({patientID: req.query.patientID}, function (err, callback) {
        if (err) {
            res.json({ err })
            return console.error(err);
        } else {
            res.json(callback)
        }
    })

}