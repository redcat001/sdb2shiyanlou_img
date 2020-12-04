db=new Sdb
var rg=db.createRG("group3");
rg.createNode(hs,11840, "/opt/sequoiadb/database/data/11840/",{sparsefile:false,diaglevel:4,logfilesz:64,logfilenum:5,transactionon:true});
rg.start();
db.close();
