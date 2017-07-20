
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
    var familyKey =  Object.keys(req.body)[0]
    console.log("familyKey " + familyKey)
    var allHumans = req.body[familyKey]
    var savedHumans = []
    Object.keys(allHumans).forEach(key => {
        let currentHuman = allHumans[key];
        console.log("key " + key)
        console.log("Name " + currentHuman.name)

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
                console.log("Details saved "+ details)
                savedHumans.push({ "Saved" : details })
            }
        })
    });

    res.json({savedHumans})


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

//Contact.update({phone:request.phone}, 
// {$set: { phone: request.phone }}, 
// {upsert: true}, 
// function(err){...})


    FamilySchema.update({id: req.query.id }, 
        {$set: req.body }, 
        {upsert: true}, 
        function(err, callback){
            if (err) return res.send(500, { error: err });
            return res.json(callback);

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