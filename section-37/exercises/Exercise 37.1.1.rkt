master only writes on target1 and target2.
master-check only reads from the targe1 and target2.

master -> (target1)
master -> (target2)
master-check <- (target1)
master-check <- (target2)
