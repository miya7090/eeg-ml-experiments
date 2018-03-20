Table newCustomTable()
{
  Table dataTable = new Table();
  
  dataTable.addColumn("id"); //unique identifier for each record
  
  dataTable.addColumn("timestamp");
  
  //if this state (default 0) is associated with a good (1) or not good (2) behavior
  dataTable.addColumn("tag");
  
  //columns for each data value. Add as needed.
  dataTable.addColumn("sensor1"); //stores data values
  dataTable.addColumn("sensor2");
  dataTable.addColumn("sensor3");
  
  return dataTable;
}
