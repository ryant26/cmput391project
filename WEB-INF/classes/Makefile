JC = javac
CLASSPATH = -classpath :../lib/*
SOURCEPATH = -sourcepath .:db

defualt: Database.class servlets
	

Database.class: db/Database.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) ./db/*.java

servlets:
	$(JC) $(CLASSPATH) $(SOURCEPATH) ./*.java

clean:
	$(RM) *.class
	$(RM) db/*.class