JC = javac
CLASSPATH = -classpath ../lib/
SOURCEPATH = -sourcepath .:db

defualt: Database.class
	

Database.class: db/Database.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) ./db/*.java

clean:
	$(RM) *.class
	$(RM) db/*.class