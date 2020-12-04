var serverName=[hs];
var cataServerName=[hs];
var path='/opt';

var oma = new Oma(serverName[0],11790);

oma.createCoord(18800, path+"/sequoiadb/database/coord/18800");

oma.startNode(18800);

var db = new Sdb(serverName[0],18800);

db.createCataRG(serverName[0],11800,path+'/sequoiadb/database/cata/11800',{diaglevel:4,logfilenum:5,transactionon:true});

var rg = db.createCoordRG();

for(var i=0;i<serverName.length;i++){

  rg.createNode(serverName[i], 11810, path+"/sequoiadb/database/coord/11810",{diaglevel:4,logfilenum:5,transactionon:true});

}


rg.start();
oma.removeCoord(18800);

db=new Sdb
var rg=db.createRG("group1");
rg.createNode(hs,11820, "/opt/sequoiadb/database/data/11820/",{diaglevel:4,logfilesz:64,logfilenum:5,transactionon:true});
rg.start();


db.getRG("SYSCoord").createNode(hs, 21810, "/opt/sequoiadb/database/coord/21810",{diaglevel:4,logfilenum:5,transactionon:true}).start();
db.getRG("SYSCoord").createNode(hs, 31810, "/opt/sequoiadb/database/coord/31810",{diaglevel:4,logfilenum:5,transactionon:true}).start();

db.getRG("group1").createNode(hs, 21820, "/opt/sequoiadb/database/data/21820",{diaglevel:4,logfilenum:5,transactionon:true}).start();
db.getRG("group1").createNode(hs, 31820, "/opt/sequoiadb/database/data/31820",{diaglevel:4,logfilenum:5,transactionon:true}).start();


db.getRG("SYSCatalogGroup").createNode(hs, 21800, "/opt/sequoiadb/database/cata/21800",{diaglevel:4,logfilenum:5,transactionon:true}).start();
db.getRG("SYSCatalogGroup").createNode(hs, 31800, "/opt/sequoiadb/database/cata/31800",{diaglevel:4,logfilenum:5,transactionon:true}).start();

db.close();

