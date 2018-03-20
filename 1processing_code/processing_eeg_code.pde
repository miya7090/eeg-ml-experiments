/* 
  Saving Values from Arduino to a .csv File Using Processing - Pseudocode

  This sketch provides a basic framework to read data from Arduino over the serial port and save it to .csv file on your computer.
  The .csv file will be saved in the same folder as your Processing sketch.
  This sketch takes advantage of Processing 2.0's built-in Table class.
  This sketch assumes that values read by Arduino are separated by commas, and each Arduino reading is separated by a newline character.
  Each reading will have it's own row and timestamp in the resulting csv file. Each file will contain all records from the beginning of the sketch's run.  
*/

import processing.serial.*;
Serial myPort; //creates a software serial port on which you will listen to Arduino
String fileName;
Table bufferTable;
int buffLength = 3; //the length of the buffer table is equal to how far back a state a tag refers to
Table dataTable;
String serialVal = null;

int readingCounter = 0; //received reading counter
int savedReadingCounter = 0; //actual reading counter
int numKeepReadings = 7; //keep one in every numKeepReadings readings
int numWriteReadings = 5; //write to file once every numWriteReadings readings

void setup()
{
  // Put the index found through iteration (refer to braingrapher init code)
  myPort = new Serial(this, Serial.list()[0], 4800);
  bufferTable = newCustomTable();
  dataTable = newCustomTable();
}

void serialEvent(Serial myPort){
  serialVal = myPort.readStringUntil('\n'); //The newline separator separates each Arduino loop. We will parse the data by each newline separator.
}

void draw()
{ 
    // timing out when no input has been read
    if (millis() > 10000 && readingCounter == 0)
    {
        println("no readings coming in. test connection?");
        println(readingCounter);
        exit();
    }
    if (serialVal != null){
        if (serialVal == "good"){ //a tag was input
            bufferTable.setFloat(buffLength, "tag", 1);
        }else if (serialVal == "bad"){
          bufferTable.setFloat(buffLength, "tag", 2);
        }else{ //a sensor reading was input
            float sensorVals[] = float(split(trim(serialVal), ',')); //parses the packet
            readingCounter++;
              
            if (readingCounter % numKeepReadings == 0){ //keeping a reading
                //PROCEDURES---------------------------------------------
                savedReadingCounter++;
                
                //add a row to buffer
                TableRow newRow = bufferTable.addRow();
                
                //write the new value into the buffer
                {
                    //format yymmddhhmmss e.g. 180317090636 
                    String timestamp = nf( int(str(year()).substring(2)) ,2) + nf(month(),2) + 
                    nf(day(),2) + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
                    
                    newRow.setInt("id", dataTable.lastRowIndex());
                    newRow.setString("timestamp", timestamp);
                    newRow.setInt("tag", 0);
                    newRow.setFloat("sensor1", sensorVals[0]);
                    newRow.setFloat("sensor2", sensorVals[1]);
                    newRow.setFloat("sensor3", sensorVals[2]);
                }
                
                //boot a row from the buffer into the datatable
                dataTable.addRow(bufferTable.getRow(buffLength));
                if (bufferTable.getRowCount() > buffLength){ //<- just a precaution
                    bufferTable.removeRow(buffLength);
                }
      
                //CHECKS-------------------------------------------------
                //once every few readings, save the data table
                if (savedReadingCounter % numWriteReadings == 0)
                {
                  fileName = str(year()) + str(month()) + str(day()) + "test_data_1.csv";
                  saveTable(dataTable, fileName, "csv");
                }
            }
        }
    }
    serialVal = null; // reset serialVal
}
