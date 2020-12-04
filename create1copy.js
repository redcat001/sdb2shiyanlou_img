var serverName=[hs];
var cataServerName=[hs];
var path='/opt';

var oma = new Oma(serverName[0],11790);

oma.createCoord(18800, path+"/sequoiadb/database/coord/18800");

oma.startNode(18800);

var db = new Sdb(serverName[0],18800);

db.createCataRG(serverName[0],11800,path+'/sequoiadb/database/cata/11800',{sparsefile:false,diaglevel:4,logfilenum:5,transactionon:true});

var rg = db.createCoordRG();

for(var i=0;i<serverName.length;i++){

  rg.createNode(serverName[i], 11810, path+"/sequoiadb/database/coord/11810",{diaglevel:4,logfilenum:5,transactionon:true});

}

rg.start();
db.close();

