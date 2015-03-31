JC = javac
CLASSPATH = -classpath ../lib/ojdbc6.jar:../lib/commons-fileupload-1.0.jar:../lib/servlet-api.jar
SOURCEPATH = -sourcepath .:db

defualt: Database.class
	

Database.class: db/Database.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) ./db/*.java

clean:
	$(RM) *.class
	$(RM) db/*.class