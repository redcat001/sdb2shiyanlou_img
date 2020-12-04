var ssh = new Ssh( "localhost", "sdbadmin", "sdbadmin", 22 )
var hostname=ssh.exec("hostname")
var hs=hostname.replace(/[\r\n]/g,"");

var db=new Sdb("localhost",11810)
var path='/opt';

var sys_size=db.list(7,{"GroupName": "SYSCoord"}).current().toObj().Group.length


if(sys_size==1){

println("begin to add 2cp ...")

db.getRG("SYSCoord").createNode(hs, 21810, "/opt/sequoiadb/database/coord/21810",{logfilenum:5,transactionon:true}).start();
db.getRG("SYSCoord").createNode(hs, 31810, "/opt/sequoiadb/database/coord/31810",{logfilenum:5,transactionon:true}).start();

//db.getRG("SYSCatalogGroup").createNode(hs, 21800, "/opt/sequoiadb/database/cata/21800",{logfilenum:5,transactionon:true}).start();
//db.getRG("SYSCatalogGroup").createNode(hs, 31800, "/opt/sequoiadb/database/cata/31800",{logfilenum:5,transactionon:true}).start();


db.getRG("group1").createNode(hs, 21820, "/opt/sequoiadb/database/data/21820",{logfilenum:5,transactionon:true}).start();
db.getRG("group1").createNode(hs, 31820, "/opt/sequoiadb/database/data/31820",{logfilenum:5,transactionon:true}).start();


db.getRG("group2").createNode(hs, 21830, "/opt/sequoiadb/database/data/21830",{logfilenum:5,transactionon:true}).start();
db.getRG("group2").createNode(hs, 31830, "/opt/sequoiadb/database/data/31830",{logfilenum:5,transactionon:true}).start();

db.getRG("group3").createNode(hs, 21840, "/opt/sequoiadb/database/data/21840",{logfilenum:5,transactionon:true}).start();
db.getRG("group3").createNode(hs, 31840, "/opt/sequoiadb/database/data/31840",{logfilenum:5,transactionon:true}).start();
println("complete ... ")
}
db.close()
