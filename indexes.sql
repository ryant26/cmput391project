
CREATE INDEX myindex1 ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex3 ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex4 ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;
