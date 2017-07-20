
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
    console.log(" req.query.id" +  req.query.id);

    var name = req.body.name

    FamilySchema.findOne({ id: req.query.id }, function (err, doc){
      console.log("Human" + req.body);

      console.log("req.body.name" + req.body.name);
      console.log("human" + doc);

      doc = req.body
      doc.save()
      res.json({doc})
    });

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