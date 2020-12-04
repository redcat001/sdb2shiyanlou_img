db=new Sdb
var rg=db.createRG("group2");
rg.createNode(hs,11830, "/opt/sequoiadb/database/data/11830/",{sparsefile:false,diaglevel:4,logfilesz:64,logfilenum:5,transactionon:true});
rg.start();
db.close();
