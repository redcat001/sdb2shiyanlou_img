db=new Sdb
var rg=db.createRG("group1");
rg.createNode(hs,11820, "/opt/sequoiadb/database/data/11820/",{sparsefile:false,diaglevel:4,logfilesz:64,logfilenum:5,transactionon:true});
rg.start();
db.close();
