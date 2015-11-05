/**
 * Logger <br>
 *  
 * @author Mandeep Singh
 * @Student Id 27849559
 * 
 */
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public aspect Logger {

	//declaring precedence
	declare precedence : Logger,LifeSupport,Authorization;
	//delimiter
	final String delimiter = " : ";
	// for creating log file
	File file =new File("system-logs.txt");
	
	StringBuilder logs = new StringBuilder();
	
	/**
	 * Method to intercept all messages sent to on-board Computer by crew memeber
	 * @param officer
	 */
	before(Crew officer): call(* OnBoardComputer.*(..)) &&within(Crew)  && this(officer){
		logs.append(System.nanoTime() % 1000).append(delimiter)
				.append(officer.getClass().getName()).append(delimiter)
				.append(officer.system.name).append(delimiter)
				.append(thisJoinPoint.getSignature().getName()).append("\n");
		
	}
	
	/**
	 * Method is used to Intercept getLifeStatus and kill message
	 * @param officer1
	 */
	before(Crew officer):(call(* Crew.getLifeStatus(..)) || call(* Crew.kill(..))) &&target(officer){
		logs.append(System.nanoTime() % 1000).append(delimiter)
		.append(thisJoinPointStaticPart.getSourceLocation().getWithinType().getName()).append(delimiter)
		.append(officer.name ).append(delimiter)
		.append(thisJoinPointStaticPart.getSignature().getName()).append("\n");
	
	} 
	
	
	after(): execution(* *.main(..)) {

		writeToSystemfile(logs.toString());
	}
	
	/**
	 * It is used to write to System file
	 * @param data
	 */
	public void writeToSystemfile(String data) {
		try {

			// if file doesnt exists, then create it
			if (!file.exists()) {
				file.createNewFile();
			}

			// true = append file
			FileWriter fileWritter = new FileWriter(file.getName(), true);
			BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
			bufferWritter.write(data);
			bufferWritter.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}