
const FamilySchema = require('./detail_model'),
date = new Date()

CollectionDriver = function(db) {
  this.db = db;
};

// Create endpoint  to get tree json 
exports.savetree = function(req, res, err) {
    
    // console.log("Treedata" + req.query.treedata);
    var name = req.body.name;
    var id = req.body.id;
    var patientID = req.body.patientID;

    var familyTree = new FamilySchema({  
        name: name,
        id: id,
        patientID: patientID
    })
    familyTree.save(function (err, details) {
        if (err) {
            res.json({ err })
            return console.error(err);
        }
        else  {
            console.log("Saved: " + name)
            res.json({ details })
        }
    })
}

// Create endpoint  to get tree json 
exports.gettree = function(req, res, err) {
    FamilySchema.findOne({id: req.query.id}, function (err, callback) {
        if (err) {
            res.json({ err })
            return console.error(err);
        } else {
            res.json(callback)
        }
    })

}